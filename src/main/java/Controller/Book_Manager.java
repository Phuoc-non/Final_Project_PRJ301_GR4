/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.List;
import model.Author;
import model.Category;
import model.Product;

/**
 *
 * @author ADMIN
 */
@jakarta.servlet.annotation.MultipartConfig
@WebServlet(name = "Book_Manager", urlPatterns = {"/bm"})
public class Book_Manager extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Book_Manager</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Book_Manager at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String view = request.getParameter("view");
        String sortBy = request.getParameter("sortBy");
        String pageStr = request.getParameter("page");

        ProductDAO dao = new ProductDAO();

        // 🧩 1. Lấy số trang hiện tại
        int page = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException ex) {
                System.err.println("Invalid page parameter");
            }
        }

        // 🧩 2. Lấy dữ liệu danh sách mặc định
        List<Product> productList = dao.getListSortedPaged(page);
        int totalProducts = dao.getTotalRows();
        int totalPages = (int) Math.ceil(totalProducts / 10.0);


        // 🧩 3. Gán dữ liệu cho JSP (luôn có, cho tất cả view)
        request.setAttribute("list", productList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // 🧩 4. Chuẩn bị đường dẫn JSP
        String path = "/WEB-INF/CRUD_Book/list.jsp";

        if ("create".equals(view)) {
            List<Author> authors = dao.getAllAuthors();
            List<Category> categories = dao.getAllCategories();
            request.setAttribute("authors", authors);
            request.setAttribute("categories", categories);
            path = "/WEB-INF/CRUD_Book/create.jsp";

        } else if ("detail".equals(view)) {
            String sku = request.getParameter("sku");
            Product p = dao.getBySku(sku);
            if (p != null) {
                request.setAttribute("product", p);
                path = "/WEB-INF/CRUD_Book/detail.jsp";
            } else {
                request.setAttribute("error", "⚠️ Book not found!");
            }

        } else if ("update".equals(view)) {
            String sku = request.getParameter("sku");
            Product p = dao.getBySku(sku);
            List<Author> authors = dao.getAllAuthors();
            List<Category> categories = dao.getAllCategories();
            request.setAttribute("product", p);
            request.setAttribute("authors", authors);
            request.setAttribute("categories", categories);
            path = "/WEB-INF/CRUD_Book/update.jsp";
        }

        // ✅ 5. Forward 1 lần duy nhất
        request.getRequestDispatcher(path).forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        ProductDAO dao = new ProductDAO();
        if ("create".equals(action)) {
            try {
                request.setCharacterEncoding("UTF-8");
                response.setCharacterEncoding("UTF-8");

                String sku = request.getParameter("sku");
                String name = request.getParameter("title");
                String author = request.getParameter("author");
                String description = request.getParameter("description");
                String dateStr = request.getParameter("created_date");
                String category_name = request.getParameter("catalog");
                int pages = Integer.parseInt(request.getParameter("pages"));
                double price = Double.parseDouble(request.getParameter("price"));

                // ⚙️ Fix format ngày: form nhập dd/MM/yyyy → đổi sang đúng pattern
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd-MM-yyyy");
                java.util.Date utilDate = sdf.parse(dateStr);
                java.sql.Date created_date = new java.sql.Date(utilDate.getTime());

                // 🟩 Upload ảnh (từ máy người dùng)
                Part filePart = request.getPart("img");
                String fileName = filePart.getSubmittedFileName();
                String imgPath;

                if (fileName != null && !fileName.isEmpty()) {
                    // Thư mục lưu ảnh trong server (Lib/images)
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs(); // tạo thư mục nếu chưa có
                    }

                    // Ghi file ảnh vào thư mục /images
                    String filePath = uploadPath + File.separator + fileName;
                    filePart.write(filePath);

                    // 🟢 Sinh ra URL ảnh đầy đủ để lưu vào DB
                    String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
                            + request.getContextPath() + "/images/";
                    imgPath = baseUrl + fileName;

                } else {
                    imgPath = "https://example.com/default.jpg";
                }

                // ⚙️ Kiểm tra SKU trùng
                if (dao.isSkuExist(sku)) {
                    // 🟢 Gửi lại danh sách để form không trống
                    List<Author> authors = dao.getAllAuthors();
                    List<Category> categories = dao.getAllCategories();

                    request.setAttribute("authors", authors);
                    request.setAttribute("categories", categories);

                    request.setAttribute("error", "❌ SKU already exists!");
                    request.getRequestDispatcher("WEB-INF/CRUD_Book/create.jsp").forward(request, response);
                    return;
                }

                int result = dao.createList(sku, // BOOK23
                        name,
                        author,
                        imgPath,
                        description,
                        created_date,
                        pages,
                        category_name,
                        price);

                if (result == 1) {
                    // ✅ Thành công → quay về list
                    response.sendRedirect(request.getContextPath() + "/bm?view=list");
                } else {
                    // ❌ Thất bại → quay lại form
                    request.setAttribute("error", "❌ Failed to add book. Please check your data.");
                    request.getRequestDispatcher("WEB-INF/CRUD_Book/create.jsp").forward(request, response);
                }

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "⚠️ Error while creating book: " + e.getMessage());
                request.getRequestDispatcher("WEB-INF/CRUD_Book/create.jsp").forward(request, response);
            }
        } else if ("delete".equals(action)) {
            try {
                String sku = request.getParameter("sku");

                // ⚙️ Xóa trong DB
                int result = dao.deleteList(sku);

                if (result == 1) {
                    // ✅ Xóa thành công
                    response.sendRedirect(request.getContextPath() + "/bm?view=list");
                } else {
                    // ⚠️ Không tìm thấy sản phẩm
                    request.setAttribute("error", "⚠️ Product not found or cannot be deleted!");
                    request.getRequestDispatcher("WEB-INF/CRUD_Book/list.jsp").forward(request, response);
                }

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "❌ Error while deleting book: " + e.getMessage());
                request.getRequestDispatcher("WEB-INF/CRUD_Book/list.jsp").forward(request, response);
            }
        } else if ("update".equals(action)) {
            try {
                request.setCharacterEncoding("UTF-8");
                response.setCharacterEncoding("UTF-8");

                String sku = request.getParameter("sku");
                String name = request.getParameter("title");
                String author = request.getParameter("author");
                String description = request.getParameter("description");
                String dateStr = request.getParameter("created_date");
                String category_name = request.getParameter("catalog");
                int pages = Integer.parseInt(request.getParameter("pages"));
                double price = Double.parseDouble(request.getParameter("price"));
                String oldImg = request.getParameter("oldImg"); // 🟢 ảnh cũ

                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd-MM-yyyy");
                java.util.Date utilDate = sdf.parse(dateStr);
                java.sql.Date created_date = new java.sql.Date(utilDate.getTime());

                // 🟢 Kiểm tra nếu user chọn ảnh mới
                Part filePart = request.getPart("img");
                String fileName = filePart.getSubmittedFileName();
                String imgPath = oldImg; // mặc định là ảnh cũ

                if (fileName != null && !fileName.isEmpty()) {
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    String filePath = uploadPath + File.separator + fileName;
                    filePart.write(filePath);
                    imgPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
                            + request.getContextPath() + "/images/" + fileName;
                }

                int result = dao.updateBook(sku, name, author, imgPath, description,
                        created_date, pages, category_name, price);

                if (result == 1) {
                    response.sendRedirect(request.getContextPath() + "/bm?view=list");
                } else {
                    request.setAttribute("error", "⚠️ Update failed!");
                    request.getRequestDispatcher("WEB-INF/CRUD_Book/update.jsp").forward(request, response);
                }

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "❌ Error while updating: " + e.getMessage());
                request.getRequestDispatcher("WEB-INF/CRUD_Book/update.jsp").forward(request, response);
            }
        }

//
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
