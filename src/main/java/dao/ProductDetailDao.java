/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Authors;
import model.Category;
import model.Product;
import model.ProductDetail;

/**
 *
 * @author Asus
 */
public class ProductDetailDao extends DBContext{
    public ProductDetail getById(int id){
        ProductDetail productDetail=null;
        Authors author=null;
        Product product=null;
        Category category=null;
        
        try {
            String query = "select pd.id,pd.book_name,pd.format,pd.dimensions,pd.publication_date,pd.pages,\n" +
"p.img,p.description,p.quantity,p.Language,p.price,p.sku,\n" +
"c.name,\n" +
"a.bio,a.name as author\n" +
"from Category c join Product p\n" +
"on c.id = p.category_id\n" +
"join productDetail pd\n" +
"on p.sku = pd.product_sku\n" +
"join Product_Author pa\n" +
"on pa.product_sku=p.sku\n" +
"join Author a\n" +
"on pa.author_id= a.id\n" +
"where pd.id=?";
            PreparedStatement statement = this.getConnection().prepareStatement(query);
            statement.setInt(1, id);

            //thuc hien cau truy van neu co object thi tra ve, ko co the tra ve null
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                //them vao author
                String authorName= rs.getString("author"); 
                
                String bio=rs.getString("bio");
                
                author=new Authors(authorName, bio);
                
                //them vao product
                int quantity=rs.getInt("quantity");
                String img=rs.getString("img");
                String des=rs.getString("description");
                float price= rs.getFloat("price"); 
                String sku=rs.getString("sku");
                product=new Product(des, quantity, img,price,sku);
                
                //them vao cat
                String cat=rs.getString("name");
                category= new Category(cat);
                
                //them vao productDetail
                String name = rs.getString("book_name");
                 
                String format= rs.getString("format");
                int pages= rs.getInt("pages");
                String dimensions= rs.getString("dimensions");
                Date date= rs.getDate("publication_date");
                String language=rs.getString("Language");
                productDetail = new ProductDetail(id, name, format, pages, dimensions, date,language, author, product, category);
            }
        } catch (SQLException ex) {
            System.getLogger(ProductDetailDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return productDetail;
    }
        
}
