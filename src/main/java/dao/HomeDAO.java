/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Book;

/**
 *
 * @author ADMIN
 */
public class HomeDAO extends DBContext {


    public List<Book> getTop6Books() {
        List<Book> list = new ArrayList<>();
        String query = """
            SELECT TOP 6 
                p.sku,
                p.name AS product_name,
                p.img,
                p.price AS price_vnd, 
                p.quantity - COALESCE(SUM(od.quantity), 0) AS remaining_quantity,
                p.description,
                c.name AS category_name,
                a.name AS author_name,
                COALESCE(SUM(od.quantity), 0) AS sold
            FROM Product p
            LEFT JOIN Product_Author pa ON p.sku = pa.product_sku
            LEFT JOIN Author a ON pa.author_id = a.id
            LEFT JOIN Category c ON p.category_id = c.id
            LEFT JOIN OrderDetails od ON p.sku = od.sku
            GROUP BY p.sku, p.name, p.img, c.name, a.name, p.price, p.quantity, p.description
            ORDER BY p.sku ASC;
        """;

        try (PreparedStatement ps = this.getConnection().prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Book b = new Book();
                b.setSku_product(rs.getString("sku"));
                b.setName_product(rs.getString("product_name"));
                b.setImg(rs.getString("img"));
                b.setDescription(rs.getString("description"));
                b.setPrice_product(rs.getDouble("price_vnd"));
                b.setQuantity_product(rs.getInt("remaining_quantity"));
                b.setCategory_name(rs.getString("category_name"));
                b.setAuthor_name(rs.getString("author_name"));
                b.setQuantity_orderDetail(rs.getInt("sold"));
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}


