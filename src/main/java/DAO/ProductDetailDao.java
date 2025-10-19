/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

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
            String query = "select p1.id,p1.price,p1.author,p1.book_name,p1.format,p1.dimensions,p1.publication_date,p2.img,p2.description,p1.pages from productDetail p1 join [Product] p2  on p1.product_sku=p2.sku where p1.id=?";
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
                product = new ProductDetail(id, price, author, name, format, pages, dimensions, date,img,des);
            }
        } catch (SQLException ex) {
            System.getLogger(ProductDetailDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return product;
    }
        
}
