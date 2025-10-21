/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.ProductDetail;

/**
 *
 * @author Asus
 */
public class ProductDetailDao extends DBContext{
    public ProductDetail getById(int id){
        ProductDetail product=null;
        try {
            String query = "select pd.id,pd.price,pd.author,pd.book_name,pd.format,pd.dimensions,pd.publication_date,p.img,p.description,pd.pages,c.name \n" +
"from Category c join Product p\n" +
"on c.id = p.category_id\n" +
"join productDetail pd\n" +
"on p.sku = pd.product_sku\n" +
"where pd.id=?";
            PreparedStatement statement = this.getConnection().prepareStatement(query);
            statement.setInt(1, id);

            //thuc hien cau truy van neu co object thi tra ve, ko co the tra ve null
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                String name = rs.getString("book_name");
                String price= rs.getString("price");
                String author= rs.getString("author");
                String format= rs.getString("format");
                int pages= rs.getInt("pages");
                String dimensions= rs.getString("dimensions");
                String date= rs.getString("publication_date");
                String img=rs.getString("img");
                String des=rs.getString("description");
                String cat=rs.getString("name");
                product = new ProductDetail(id, price, author, name, format, pages, dimensions, date,img,des,cat);
            }
        } catch (SQLException ex) {
            System.getLogger(ProductDetailDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return product;
    }
        
}
