/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Author;
import model.Book;
import model.Category;
import model.Product;
import model.ProductDetail;

/**
 *
 * @author ADMIN
 */
public class ProductDAO extends DBContext {

    //list
    public List<Product> getList() {
        List<Product> list = new ArrayList<>();
        String query = """
        SELECT 
            p.sku,
            p.name AS product_name ,
            p.img,
            p.description,
            p.quantity,          
            c.name AS category_name,
            a.name AS author_name,
            p.price,
            COALESCE(SUM(od.quantity), 0) AS sold,
            p.created_product AS created_date,
            pd.pages AS pages
        FROM Product p
        LEFT JOIN Product_Author pa ON p.sku = pa.product_sku
        LEFT JOIN Author a ON pa.author_id = a.id
        LEFT JOIN Category c ON p.category_id = c.id
        LEFT JOIN OrderDetails od ON p.sku = od.sku
        LEFT JOIN productDetail pd ON p.sku = pd.product_sku
        GROUP BY p.sku, p.name, p.img, c.name, a.name, p.price, p.created_product,p.description, p.quantity, pd.pages
        ORDER BY p.sku ASC;
        """;

        try (PreparedStatement ps = this.getConnection().prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product p = new Product();
                p.setSku_product(rs.getString("sku"));
                p.setName_product(rs.getString("product_name"));
                p.setImg(rs.getString("img"));
                p.setCategory_name(rs.getString("category_name"));
                p.setAuthor_name(rs.getString("author_name"));
                p.setPrice_product(rs.getDouble("price"));
                p.setQuantity_orderDetail(rs.getInt("sold"));
                p.setCreated_product(rs.getDate("created_date"));
                p.setDescription_product(rs.getString("description"));
                p.setPages(rs.getInt("pages"));
                p.setQuantity(rs.getInt("quantity"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int createList(String sku_product, String name_product, String author_name, String img,
            String description_product, Date created_date, int pages_productDetail,
            String category_name, double price_product, int quantity) {

        // 1️⃣ Thêm tác giả nếu chưa có
        String insertAuthor = """
        IF NOT EXISTS (SELECT 1 FROM Author WHERE name = ?)
        BEGIN
            INSERT INTO Author (name, bio)
            VALUES (?, 'New author added automatically');
        END
    """;

        // 2️⃣ Thêm sản phẩm (Product)
        String insertProduct = """
        INSERT INTO Product (sku, name, description, img, price, created_product, category_id, quantity, status)
        SELECT TOP 1
            ? AS sku,
            ? AS name,
            ? AS description,
            ? AS img,
            ? AS price,
            ? AS created_product,
            c.id AS category_id,
            ? AS quantity,
            1 AS status
        FROM Category c
        WHERE LTRIM(RTRIM(LOWER(c.name))) = LTRIM(RTRIM(LOWER(?)));
    """;

        // 3️⃣ Thêm ProductDetail nếu chưa có
        String insertProductDetail = """
        IF NOT EXISTS (SELECT 1 FROM productDetail WHERE product_sku = ?)
        BEGIN
            INSERT INTO productDetail (product_sku, book_name, format, pages, dimensions, publication_date)
            VALUES (?, ?, 'Default Format', ?, 'N/A', ?);
        END
    """;

        // 4️⃣ Thêm Product_Author nếu chưa có (bản giống hệt SQL bạn test thành công)
        String insertProductAuthor = """
        DECLARE @author_id INT;
        SELECT @author_id = id FROM Author WHERE name = ?;
        IF @author_id IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM Product_Author WHERE product_sku = ? AND author_id = @author_id)
            BEGIN
                INSERT INTO Product_Author (product_sku, author_id)
                VALUES (?, @author_id);
            END
        END
    """;

        try (
                PreparedStatement psAuthor = this.getConnection().prepareStatement(insertAuthor); PreparedStatement psProduct = this.getConnection().prepareStatement(insertProduct); PreparedStatement psDetail = this.getConnection().prepareStatement(insertProductDetail); PreparedStatement psProdAuthor = this.getConnection().prepareStatement(insertProductAuthor)) {
            // ✅ B1: Insert Author
            psAuthor.setString(1, author_name);
            psAuthor.setString(2, author_name);
            psAuthor.executeUpdate();

            // ✅ B2: Insert Product
            psProduct.setString(1, sku_product);
            psProduct.setString(2, name_product);
            psProduct.setString(3, description_product);
            psProduct.setString(4, img);
            psProduct.setDouble(5, price_product);
            psProduct.setDate(6, created_date);
            psProduct.setInt(7, quantity);
            psProduct.setString(8, category_name);

            int inserted = psProduct.executeUpdate();
            if (inserted == 0) {
                System.out.println("⚠️ Category not found or product not inserted!");
                return 0;
            }

            // ✅ B3: Insert ProductDetail
            psDetail.setString(1, sku_product);
            psDetail.setString(2, sku_product);
            psDetail.setString(3, name_product);
            psDetail.setInt(4, pages_productDetail);
            psDetail.setDate(5, created_date);
            psDetail.executeUpdate();

            // ✅ B4: Insert Product_Author
            psProdAuthor.setString(1, author_name);
            psProdAuthor.setString(2, sku_product);
            psProdAuthor.setString(3, sku_product);
            psProdAuthor.executeUpdate();

            System.out.println("✅ All data inserted successfully!");
            return 1;

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("❌ SQL Error: " + e.getMessage());
            return 0;
        }
    }

    // Lấy 1 sản phẩm theo SKU
    public Product getBySku(String sku_product) {
        String query = """
    SELECT 
        p.sku,
        p.name AS product_name,
        p.img,
        p.description,
        p.quantity,
        c.name AS category_name,
        a.name AS author_name,
        p.price,
        COALESCE(SUM(od.quantity), 0) AS sold,
        p.created_product AS created_date,
        pd.pages AS pages
    FROM Product p
    LEFT JOIN Product_Author pa ON p.sku = pa.product_sku
    LEFT JOIN Author a ON pa.author_id = a.id
    LEFT JOIN Category c ON p.category_id = c.id
    LEFT JOIN OrderDetails od ON p.sku = od.sku
    LEFT JOIN productDetail pd ON p.sku = pd.product_sku
    WHERE p.sku = ?
    GROUP BY p.sku, p.name, p.img, p.description, p.quantity,
             c.name, a.name, p.price, p.created_product, pd.pages
""";

        try (PreparedStatement ps = this.getConnection().prepareStatement(query)) {
            ps.setString(1, sku_product);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Product p = new Product();
                    p.setSku_product(rs.getString("sku"));
                    p.setName_product(rs.getString("product_name"));
                    p.setImg(rs.getString("img"));
                    p.setDescription_product(rs.getString("description"));
                    p.setCategory_name(rs.getString("category_name"));
                    p.setAuthor_name(rs.getString("author_name"));
                    p.setPrice_product(rs.getDouble("price"));
                    p.setQuantity_orderDetail(rs.getInt("sold"));
                    p.setCreated_product(rs.getDate("created_date"));
                    p.setPages(rs.getInt("pages"));
                    p.setQuantity(rs.getInt("quantity"));
                    return p;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("❌ Error fetching product with SKU: " + sku_product);
        }
        return null;
    }

    public int updateBook(String sku, String name, String author, String imgPath,
            String description, Date createdDate, int pages,
            String categoryName, double price, int quantity) {
        String sql = """
        UPDATE Product
        SET name = ?, description = ?, img = ?, price = ?, created_product = ?, quantity=?,
            category_id = (SELECT id FROM Category WHERE name = ?)
        WHERE sku = ?
    """;
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setString(3, imgPath);
            ps.setDouble(4, price);
            ps.setDate(5, createdDate);
            ps.setInt(6, quantity);
            ps.setString(7, categoryName);
            ps.setString(8, sku);
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int deleteList(String sku_product) {
        String deleteProductAuthor = "DELETE FROM Product_Author WHERE product_sku = ?";
        String deleteProductDetail = "DELETE FROM ProductDetail WHERE product_sku = ?";
        String deleteProduct = "DELETE FROM Product WHERE sku = ?";

        try (
                PreparedStatement psProductAuthor = this.getConnection().prepareStatement(deleteProductAuthor); PreparedStatement psProductDetail = this.getConnection().prepareStatement(deleteProductDetail); PreparedStatement psProduct = this.getConnection().prepareStatement(deleteProduct)) {

            psProductAuthor.setString(1, sku_product);
            psProductAuthor.executeUpdate();

            psProductDetail.setString(1, sku_product);
            psProductDetail.executeUpdate();

            psProduct.setString(1, sku_product);
            int rowsDeleted = psProduct.executeUpdate();

            if (rowsDeleted > 0) {
                System.out.println("✅ Deleted product with SKU: " + sku_product);
                return 1;
            } else {
                System.out.println("⚠️ No product found with SKU: " + sku_product);
                return 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("❌ Error deleting product with SKU: " + sku_product);
            return 0;
        }
    }

    public String generateNextBookCode() {
        String query = "SELECT sku FROM product ORDER BY sku ASC";
        List<String> existingCodes = new ArrayList<>();

        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                existingCodes.add(rs.getString("sku"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Kiểm tra từ BOOK01 đến BOOK99 xem số nào trống
        for (int i = 1; i <= 99; i++) {
            String code = String.format("BOOK%02d", i);
            if (!existingCodes.contains(code)) {
                return code; // Trả về code trống đầu tiên
            }
        }

        return "BOOK99"; // fallback (giới hạn đến BOOK99)
    }

    public List<Author> getAllAuthors() {
        List<Author> list = new ArrayList<>();
        String sql = "SELECT id, name FROM Author";
        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Author(rs.getInt("id"), rs.getString("name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT id, name FROM Category";
        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Category(rs.getInt("id"), rs.getString("name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ⚠️ Method cũ - KHÔNG DÙNG NỮA - Dùng getAllBook(int page) thay thế
    public List<Book> getAllBook() {
        List<Book> list = new ArrayList<>();
        String query = """
        SELECT 
                    p.sku,
                    p.name AS product_name,
                    p.img,
                    p.price AS price_vnd, 
                  p.quantity -COALESCE(SUM(od.quantity), 0) AS remaining_quantity,
                    p.description,
                   pd.id,
                    c.name AS category_name,
                    a.name AS author_name,
                   COALESCE(SUM(od.quantity), 0) AS sold
                FROM Product p
                LEFT JOIN Product_Author pa ON p.sku = pa.product_sku
                LEFT JOIN Author a ON pa.author_id = a.id
                LEFT JOIN Category c ON p.category_id = c.id
                LEFT JOIN OrderDetails od ON p.sku = od.sku
                left join productDetail pd on pd.product_sku=p.sku
                GROUP BY p.sku, p.name, p.img, c.name, a.name, p.price, p.quantity,p.description,pd.id
                ORDER BY p.sku ASC;
    """;

        try (PreparedStatement ps = this.getConnection().prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                ProductDetail p = new ProductDetail(rs.getInt("id"));
                list.add(new Book(rs.getString("sku"), rs.getString("img"), rs.getString("product_name"),
                        rs.getDouble("price_vnd"), rs.getInt("remaining_quantity"), rs.getString("category_name"),
                        rs.getString("author_name"), rs.getInt("sold"), p));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Book> getBookCate(String nameCate, int page) {
        List<Book> list = new ArrayList<>();
        try {

            String query = """
                               SELECT
                                   p.sku,
                                   p.name AS product_name,
                                   p.img,
                                   p.price AS price_vnd,
                                   p.quantity - COALESCE(SUM(od.quantity), 0) AS remaining_quantity,
                                   p.description,
                                   c.name AS category_name,
                                   a.name AS author_name,
                                   COALESCE(SUM(od.quantity), 0) AS sold,
                                   pd.id AS detail_id
                               FROM Product p
                               LEFT JOIN Product_Author pa ON p.sku = pa.product_sku
                               LEFT JOIN Author a ON pa.author_id = a.id
                               LEFT JOIN Category c ON p.category_id = c.id
                               LEFT JOIN OrderDetails od ON p.sku = od.sku
                               LEFT JOIN productDetail pd ON p.sku = pd.product_sku
                               where c.name = ?
                               GROUP BY p.sku, p.name, p.img, c.name, a.name, p.price, p.quantity, p.description, pd.id
                               ORDER BY p.sku ASC
                               OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY
                           """;

            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ps.setInt(2, (page - 1) * 4); // Bỏ qua (page-1)*12 dòng
            ps.setString(1, nameCate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Book b = new Book();
                b.setSku_product(rs.getString("sku"));
                b.setName_product(rs.getString("product_name"));
                b.setImg(rs.getString("img"));
                b.setPrice_product(rs.getDouble("price_vnd"));
                b.setQuantity_product(rs.getInt("remaining_quantity"));
                b.setCategory_name(rs.getString("category_name"));
                b.setAuthor_name(rs.getString("author_name"));
                b.setQuantity_orderDetail(rs.getInt("sold"));
                b.setDescription(rs.getString("description"));

                model.ProductDetail pd = new model.ProductDetail();
                pd.setId(rs.getInt("detail_id"));
                b.setProductDetail(pd);

                list.add(b);
            }
        } catch (SQLException ex) {
            System.getLogger(ProductDAO.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return list;
    }

    public List<Book> searchBookByTitle(String title) {
        List<Book> list = new ArrayList<>();
        String query = """
        SELECT 
            p.sku, p.name AS product_name, p.img,
            p.price AS price_vnd,
            p.quantity - COALESCE(SUM(od.quantity), 0) AS remaining_quantity,
            c.name AS category_name, a.name AS author_name,
            COALESCE(SUM(od.quantity), 0) AS sold
        FROM Product p
        LEFT JOIN Product_Author pa ON p.sku = pa.product_sku
        LEFT JOIN Author a ON pa.author_id = a.id
        LEFT JOIN Category c ON p.category_id = c.id
        LEFT JOIN OrderDetails od ON p.sku = od.sku
        WHERE p.name LIKE ?
        GROUP BY p.sku, p.name, p.img, c.name, a.name, p.price, p.quantity;
    """;

        try (PreparedStatement ps = getConnection().prepareStatement(query)) {
            ps.setString(1, "%" + title + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Book b = new Book();
                    b.setSku_product(rs.getString("sku"));
                    b.setName_product(rs.getString("product_name"));
                    b.setImg(rs.getString("img"));
                    b.setPrice_product(rs.getDouble("price_vnd"));
                    b.setQuantity_product(rs.getInt("remaining_quantity"));
                    b.setCategory_name(rs.getString("category_name"));
                    b.setAuthor_name(rs.getString("author_name"));
                    b.setQuantity_orderDetail(rs.getInt("sold"));
                    list.add(b);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

// 🔍 Tìm sách theo tên tác giả (gần đúng, không phân biệt hoa thường)
    @Deprecated
    public List<Book> searchBookByAuthor(String author) {
        return searchBookByAuthor(author, 1);
    }

    // 🔍 Tìm sách theo TÊN SÁCH HOẶC TÊN TÁC GIẢ (Universal Search)
    @Deprecated
    public List<Book> searchBooks(String keyword) {
        return searchBooks(keyword, 1);
    }

    /**
     * Lấy Category theo id
     */
    public Category getBooksByCategoryId(int id) {
        String sql = "SELECT id, name FROM Category WHERE id = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Category(rs.getInt("id"), rs.getString("name"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 🔽 Sắp xếp theo TÊN (A-Z)
    @Deprecated
    public List<Book> getBooksSortedByName() {
        return getBooksSortedByName(1);
    }

// 🔽 Sắp xếp theo GIÁ (Thấp → Cao)
    @Deprecated
    public List<Book> getBooksSortedByPrice() {
        return getBooksSortedByPrice(1);
    }

// 🔽 Hàm sắp xếp danh sách Product theo tiêu chí
    public List<Product> getListSorted(String sortBy) {
        List<Product> list = new ArrayList<>();

        String baseQuery = """
        SELECT 
            p.sku,
            p.name AS product_name,
            p.img,
            p.description,
            c.name AS category_name,
            a.name AS author_name,
            p.price,
            COALESCE(SUM(od.quantity), 0) AS sold,
            p.created_product AS created_date,
            pd.pages AS pages
        FROM Product p
        LEFT JOIN Product_Author pa ON p.sku = pa.product_sku
        LEFT JOIN Author a ON pa.author_id = a.id
        LEFT JOIN Category c ON p.category_id = c.id
        LEFT JOIN OrderDetails od ON p.sku = od.sku
        LEFT JOIN productDetail pd ON p.sku = pd.product_sku
        GROUP BY p.sku, p.name, p.img, c.name, a.name, p.price, p.created_product, p.description, pd.pages
    """;

        // thêm ORDER BY động
        switch (sortBy) {
            case "title" ->
                baseQuery += " ORDER BY p.name ASC";
            case "price" ->
                baseQuery += " ORDER BY p.price ASC";
            case "number_sold" ->
                baseQuery += " ORDER BY sold DESC";
            default ->
                baseQuery += " ORDER BY p.sku ASC";
        }

        try (PreparedStatement ps = this.getConnection().prepareStatement(baseQuery); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product p = new Product();
                p.setSku_product(rs.getString("sku"));
                p.setName_product(rs.getString("product_name"));
                p.setImg(rs.getString("img"));
                p.setCategory_name(rs.getString("category_name"));
                p.setAuthor_name(rs.getString("author_name"));
                p.setPrice_product(rs.getDouble("price"));
                p.setQuantity_orderDetail(rs.getInt("sold"));
                p.setCreated_product(rs.getDate("created_date"));
                p.setDescription_product(rs.getString("description"));
                p.setPages(rs.getInt("pages"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Product> getListSortedPaged(int page) {
        List<Product> list = new ArrayList<>();
        String query = """
        SELECT 
            p.sku,
            p.name AS product_name,
            p.price,
            p.description,
            p.img,
            p.created_product,
            c.name AS category_name,
            a.name AS author_name,
            COALESCE(SUM(od.quantity), 0) AS quantity_sold,
            pd.pages AS pages
        FROM Product p
        LEFT JOIN Product_Author pa ON p.sku = pa.product_sku
        LEFT JOIN Author a ON pa.author_id = a.id
        LEFT JOIN Category c ON p.category_id = c.id
        LEFT JOIN OrderDetails od ON p.sku = od.sku
        LEFT JOIN productDetail pd ON p.sku = pd.product_sku
        GROUP BY p.sku, p.name, p.price, p.description, p.img, p.created_product,
                 c.name, a.name, pd.pages
        ORDER BY p.sku ASC
        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;
        """;

        try (Connection conn = this.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, (page - 1) * 10); // offset
            ps.setInt(2, 10); // limit

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();

                // ánh xạ dữ liệu từ SQL sang đối tượng Product
                p.setSku_product(rs.getString("sku"));
                p.setName_product(rs.getString("product_name"));
                p.setPrice_product(rs.getDouble("price"));
                p.setDescription_product(rs.getString("description"));
                p.setImg(rs.getString("img"));
                p.setCreated_product(rs.getDate("created_product"));
                p.setCategory_name(rs.getString("category_name"));
                p.setAuthor_name(rs.getString("author_name"));
                p.setQuantity_orderDetail(rs.getInt("quantity_sold"));
                p.setPages(rs.getInt("pages"));

                list.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int getTotalRows() {
        String query = "SELECT COUNT(*) AS total FROM Product";
        try (Connection conn = this.getConnection(); PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                int total = rs.getInt("total");
                System.out.println("🧩 Total rows in Product = " + total);
                return total;
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("❌ Error in getTotalRows(): " + ex.getMessage());
        }
        return 0;
    }

    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();

        // Test 1: Lấy tất cả sách
        System.out.println("=== TEST 1: Get All Books ===");
        List<Book> allBooks = dao.getAllBook();
        System.out.println("Total books: " + allBooks.size());
        for (Book b : allBooks) {
            System.out.println("SKU: " + b.getSku_product()
                    + " | Name: " + b.getName_product()
                    + " | Author: " + b.getAuthor_name());
        }

        // Test 2: Tìm theo tác giả
        System.out.println("\n=== TEST 2: Search by Author 'james' ===");
        List<Book> byAuthor = dao.searchBookByAuthor("james");
        System.out.println("Found: " + byAuthor.size() + " books");
        for (Book b : byAuthor) {
            System.out.println("SKU: " + b.getSku_product()
                    + " | Name: " + b.getName_product()
                    + " | Author: " + b.getAuthor_name());
        }

        // Test 3: Universal search
        System.out.println("\n=== TEST 3: Universal Search 'james' ===");
        List<Book> universal = dao.searchBooks("james");
        System.out.println("Found: " + universal.size() + " books");
        for (Book b : universal) {
            System.out.println("SKU: " + b.getSku_product()
                    + " | Name: " + b.getName_product()
                    + " | Author: " + b.getAuthor_name());
        }
    }

    // ==================== PAGINATION METHODS ====================
    /**
     * Lấy tổng số sách
     */
    public int getTotalBooks() {
        int count = 0;
        String query = "SELECT COUNT(DISTINCT p.sku) FROM Product p";
        try (PreparedStatement ps = this.getConnection().prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int getTotalBooksByCategoryName(String name) {
         int count = 0;
        try {
           
            String query = """
                                   SELECT COUNT(*)
                                                                   FROM Product p
                                                                   LEFT JOIN Product_Author pa ON p.sku = pa.product_sku
                                                                   LEFT JOIN Author a ON pa.author_id = a.id
                                                                   LEFT JOIN Category c ON p.category_id = c.id
                                                                   LEFT JOIN OrderDetails od ON p.sku = od.sku
                                                                   LEFT JOIN productDetail pd ON p.sku = pd.product_sku
                                                                   where c.name = ?
                                                                  
                                    """;
            
            
            
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        count = rs.getInt(1);
                    }
                    
                    
        } catch (SQLException ex) {
            System.getLogger(ProductDAO.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return count;
    }
    
    
    /**
     * Lấy tổng số sách theo tiêu đề
     */
    public int getTotalBooksByTitle(String title) {
        int count = 0;
        String query = """
            SELECT COUNT(DISTINCT p.sku)
            FROM Product p
            WHERE LOWER(p.name) LIKE LOWER(?)
        """;
        try (PreparedStatement ps = this.getConnection().prepareStatement(query)) {
            ps.setString(1, "%" + title + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    /**
     * Lấy tổng số sách theo tác giả
     */
    public int getTotalBooksByAuthor(String author) {
        int count = 0;
        String query = """
            SELECT COUNT(DISTINCT p.sku)
            FROM Product p
            INNER JOIN Product_Author pa ON p.sku = pa.product_sku
            INNER JOIN Author a ON pa.author_id = a.id
            WHERE LOWER(a.name) LIKE LOWER(?)
        """;
        try (PreparedStatement ps = this.getConnection().prepareStatement(query)) {
            ps.setString(1, "%" + author + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    /**
     * Lấy tổng số sách theo keyword (tìm cả tên và tác giả)
     */
    public int getTotalBooksByKeyword(String keyword) {
        int count = 0;
        String query = """
            SELECT COUNT(DISTINCT p.sku)
            FROM Product p
            LEFT JOIN Product_Author pa ON p.sku = pa.product_sku
            LEFT JOIN Author a ON pa.author_id = a.id
            WHERE LOWER(p.name) LIKE LOWER(?) OR LOWER(a.name) LIKE LOWER(?)
        """;
        try (PreparedStatement ps = this.getConnection().prepareStatement(query)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    /**
     * Lấy tất cả sách với phân trang
     */
    public List<Book> getAllBook(int page) {
        List<Book> list = new ArrayList<>();
        String query = """
        SELECT 
            p.sku,
            p.name AS product_name,
            p.img,
            p.price AS price_vnd, 
            p.quantity - COALESCE(SUM(od.quantity), 0) AS remaining_quantity,
            p.description,
            c.name AS category_name,
            a.name AS author_name,
            COALESCE(SUM(od.quantity), 0) AS sold,
            pd.id AS detail_id
        FROM Product p
        LEFT JOIN Product_Author pa ON p.sku = pa.product_sku
        LEFT JOIN Author a ON pa.author_id = a.id
        LEFT JOIN Category c ON p.category_id = c.id
        LEFT JOIN OrderDetails od ON p.sku = od.sku
        LEFT JOIN productDetail pd ON p.sku = pd.product_sku
        GROUP BY p.sku, p.name, p.img, c.name, a.name, p.price, p.quantity, p.description, pd.id
        ORDER BY p.sku ASC
        OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY
    """;

        try (PreparedStatement ps = this.getConnection().prepareStatement(query)) {
            ps.setInt(1, (page - 1) * 4); // Bỏ qua (page-1)*12 dòng

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Book b = new Book();
                b.setSku_product(rs.getString("sku"));
                b.setName_product(rs.getString("product_name"));
                b.setImg(rs.getString("img"));
                b.setPrice_product(rs.getDouble("price_vnd"));
                b.setQuantity_product(rs.getInt("remaining_quantity"));
                b.setCategory_name(rs.getString("category_name"));
                b.setAuthor_name(rs.getString("author_name"));
                b.setQuantity_orderDetail(rs.getInt("sold"));
                b.setDescription(rs.getString("description"));

                model.ProductDetail pd = new model.ProductDetail();
                pd.setId(rs.getInt("detail_id"));
                b.setProductDetail(pd);

                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Tìm kiếm sách theo tiêu đề với phân trang
     */
    public List<Book> searchBookByTitle(String title, int page) {
        List<Book> list = new ArrayList<>();
        String query = """
        SELECT 
            p.sku, p.name AS product_name, p.img,
            p.price AS price_vnd,
            p.quantity - COALESCE(SUM(od.quantity), 0) AS remaining_quantity,
            p.description,
            c.name AS category_name, a.name AS author_name,
            COALESCE(SUM(od.quantity), 0) AS sold,
            pd.id AS detail_id
        FROM Product p
        LEFT JOIN Product_Author pa ON p.sku = pa.product_sku
        LEFT JOIN Author a ON pa.author_id = a.id
        LEFT JOIN Category c ON p.category_id = c.id
        LEFT JOIN OrderDetails od ON p.sku = od.sku
        LEFT JOIN productDetail pd ON p.sku = pd.product_sku
        WHERE LOWER(p.name) LIKE LOWER(?)
        GROUP BY p.sku, p.name, p.img, c.name, a.name, p.price, p.quantity, p.description, pd.id
        ORDER BY p.sku ASC
        OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY
    """;

        try (PreparedStatement ps = getConnection().prepareStatement(query)) {
            ps.setString(1, "%" + title + "%");
            ps.setInt(2, (page - 1) * 4);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Book b = new Book();
                b.setSku_product(rs.getString("sku"));
                b.setName_product(rs.getString("product_name"));
                b.setImg(rs.getString("img"));
                b.setPrice_product(rs.getDouble("price_vnd"));
                b.setQuantity_product(rs.getInt("remaining_quantity"));
                b.setCategory_name(rs.getString("category_name"));
                b.setAuthor_name(rs.getString("author_name"));
                b.setQuantity_orderDetail(rs.getInt("sold"));
                b.setDescription(rs.getString("description"));

                model.ProductDetail pd = new model.ProductDetail();
                pd.setId(rs.getInt("detail_id"));
                b.setProductDetail(pd);

                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Tìm kiếm sách theo tác giả với phân trang
     */
    public List<Book> searchBookByAuthor(String author, int page) {
        List<Book> list = new ArrayList<>();
        String query = """
        SELECT 
            p.sku, p.name AS product_name, p.img,
            p.price AS price_vnd,
            p.quantity - COALESCE(SUM(od.quantity), 0) AS remaining_quantity,
            p.description,
            c.name AS category_name, a.name AS author_name,
            COALESCE(SUM(od.quantity), 0) AS sold,
            COALESCE(pd.id, 0) AS detail_id
        FROM Product p
        INNER JOIN Product_Author pa ON p.sku = pa.product_sku
        INNER JOIN Author a ON pa.author_id = a.id
        LEFT JOIN Category c ON p.category_id = c.id
        LEFT JOIN OrderDetails od ON p.sku = od.sku
        LEFT JOIN productDetail pd ON p.sku = pd.product_sku
        WHERE LOWER(a.name) LIKE LOWER(?)
        GROUP BY p.sku, p.name, p.img, c.name, a.name, p.price, p.quantity, p.description, pd.id
        ORDER BY p.sku ASC
        OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY
    """;

        try (PreparedStatement ps = getConnection().prepareStatement(query)) {
            ps.setString(1, "%" + author + "%");
            ps.setInt(2, (page - 1) * 4);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Book b = new Book();
                b.setSku_product(rs.getString("sku"));
                b.setName_product(rs.getString("product_name"));
                b.setImg(rs.getString("img"));
                b.setPrice_product(rs.getDouble("price_vnd"));
                b.setQuantity_product(rs.getInt("remaining_quantity"));
                b.setCategory_name(rs.getString("category_name"));
                b.setAuthor_name(rs.getString("author_name"));
                b.setQuantity_orderDetail(rs.getInt("sold"));
                b.setDescription(rs.getString("description"));

                model.ProductDetail pd = new model.ProductDetail();
                pd.setId(rs.getInt("detail_id"));
                b.setProductDetail(pd);

                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Tìm kiếm sách theo keyword với phân trang
     */
    public List<Book> searchBooks(String keyword, int page) {
        List<Book> list = new ArrayList<>();
        String query = """
        SELECT 
            p.sku, p.name AS product_name, p.img,
            p.price AS price_vnd,
            p.quantity - COALESCE(SUM(od.quantity), 0) AS remaining_quantity,
            p.description,
            c.name AS category_name, a.name AS author_name,
            COALESCE(SUM(od.quantity), 0) AS sold,
            COALESCE(pd.id, 0) AS detail_id
        FROM Product p
        LEFT JOIN Product_Author pa ON p.sku = pa.product_sku
        LEFT JOIN Author a ON pa.author_id = a.id
        LEFT JOIN Category c ON p.category_id = c.id
        LEFT JOIN OrderDetails od ON p.sku = od.sku
        LEFT JOIN productDetail pd ON p.sku = pd.product_sku
        WHERE LOWER(p.name) LIKE LOWER(?) OR LOWER(a.name) LIKE LOWER(?)
        GROUP BY p.sku, p.name, p.img, c.name, a.name, p.price, p.quantity, p.description, pd.id
        ORDER BY sold DESC
        OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY
    """;

        try (PreparedStatement ps = getConnection().prepareStatement(query)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setInt(3, (page - 1) * 4);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Book b = new Book();
                b.setSku_product(rs.getString("sku"));
                b.setName_product(rs.getString("product_name"));
                b.setImg(rs.getString("img"));
                b.setPrice_product(rs.getDouble("price_vnd"));
                b.setQuantity_product(rs.getInt("remaining_quantity"));
                b.setCategory_name(rs.getString("category_name"));
                b.setAuthor_name(rs.getString("author_name"));
                b.setQuantity_orderDetail(rs.getInt("sold"));
                b.setDescription(rs.getString("description"));

                model.ProductDetail pd = new model.ProductDetail();
                pd.setId(rs.getInt("detail_id"));
                b.setProductDetail(pd);

                list.add(b);
            }
        } catch (SQLException e) {
            System.err.println("Error in searchBooks: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy sách sắp xếp theo tên với phân trang
     */
    public List<Book> getBooksSortedByName(int page) {
        List<Book> list = new ArrayList<>();
        String query = """
        SELECT 
            p.sku, p.name AS product_name, p.img,
            p.price AS price_vnd,
            p.quantity - COALESCE(SUM(od.quantity), 0) AS remaining_quantity,
            p.description,
            c.name AS category_name, a.name AS author_name,
            COALESCE(SUM(od.quantity), 0) AS sold,
            pd.id AS detail_id
        FROM Product p
        LEFT JOIN Product_Author pa ON p.sku = pa.product_sku
        LEFT JOIN Author a ON pa.author_id = a.id
        LEFT JOIN Category c ON p.category_id = c.id
        LEFT JOIN OrderDetails od ON p.sku = od.sku
        LEFT JOIN productDetail pd ON p.sku = pd.product_sku
        GROUP BY p.sku, p.name, p.img, c.name, a.name, p.price, p.quantity, p.description, pd.id
        ORDER BY p.name ASC
        OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY
    """;

        try (PreparedStatement ps = getConnection().prepareStatement(query)) {
            ps.setInt(1, (page - 1) * 4);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Book b = new Book();
                b.setSku_product(rs.getString("sku"));
                b.setName_product(rs.getString("product_name"));
                b.setImg(rs.getString("img"));
                b.setPrice_product(rs.getDouble("price_vnd"));
                b.setQuantity_product(rs.getInt("remaining_quantity"));
                b.setCategory_name(rs.getString("category_name"));
                b.setAuthor_name(rs.getString("author_name"));
                b.setQuantity_orderDetail(rs.getInt("sold"));
                b.setDescription(rs.getString("description"));

                model.ProductDetail pd = new model.ProductDetail();
                pd.setId(rs.getInt("detail_id"));
                b.setProductDetail(pd);

                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy sách sắp xếp theo giá với phân trang
     */
    public List<Book> getBooksSortedByPrice(int page) {
        List<Book> list = new ArrayList<>();
        String query = """
        SELECT 
            p.sku, p.name AS product_name, p.img,
            p.price AS price_vnd,
            p.quantity - COALESCE(SUM(od.quantity), 0) AS remaining_quantity,
            p.description,
            c.name AS category_name, a.name AS author_name,
            COALESCE(SUM(od.quantity), 0) AS sold,
            pd.id AS detail_id
        FROM Product p
        LEFT JOIN Product_Author pa ON p.sku = pa.product_sku
        LEFT JOIN Author a ON pa.author_id = a.id
        LEFT JOIN Category c ON p.category_id = c.id
        LEFT JOIN OrderDetails od ON p.sku = od.sku
        LEFT JOIN productDetail pd ON p.sku = pd.product_sku
        GROUP BY p.sku, p.name, p.img, c.name, a.name, p.price, p.quantity, p.description, pd.id
        ORDER BY p.price ASC
        OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY
    """;

        try (PreparedStatement ps = getConnection().prepareStatement(query)) {
            ps.setInt(1, (page - 1) * 4);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Book b = new Book();
                b.setSku_product(rs.getString("sku"));
                b.setName_product(rs.getString("product_name"));
                b.setImg(rs.getString("img"));
                b.setPrice_product(rs.getDouble("price_vnd"));
                b.setQuantity_product(rs.getInt("remaining_quantity"));
                b.setCategory_name(rs.getString("category_name"));
                b.setAuthor_name(rs.getString("author_name"));
                b.setQuantity_orderDetail(rs.getInt("sold"));
                b.setDescription(rs.getString("description"));

                model.ProductDetail pd = new model.ProductDetail();
                pd.setId(rs.getInt("detail_id"));
                b.setProductDetail(pd);

                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}
