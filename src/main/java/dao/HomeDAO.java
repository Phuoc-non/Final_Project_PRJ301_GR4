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
import model.ProductDetail;

/**
 *
 * @author ADMIN
 */
public class HomeDAO extends DBContext {

    public List<Book> getTop6Books() {
        List<Book> list = new ArrayList<>();
        String query = """
           with orderList as (
            select sum(od.quantity) as quantity,od.sku from OrderDetails od join Orders o
            on od.order_id=o.id
            group by od.sku
            )
            select top 6
            pd.id,pd.book_name,
            p.img,p.description,p.quantity,p.price,p.sku,
            STRING_AGG( a.name,', ') as authur_name,
            ol.quantity as selling_quan,
            c.name as category
            from product p join productDetail pd
            on p.sku=pd.product_sku
            join Product_Author pa
            on pa.product_sku=p.sku
            join Author a
            on a.id=pa.author_id
            join orderList ol
            on ol.sku=p.sku
            join Category c
            on c.id=p.category_id
            group by
            pd.id,pd.book_name,
            p.img,p.description,p.quantity,p.price,p.sku,ol.quantity,c.name
            order by selling_quan desc
        """;

        try (PreparedStatement ps = this.getConnection().prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProductDetail p= new ProductDetail(rs.getInt("id"));
                list.add(new Book(rs.getString("sku"), rs.getString("img"), rs.getString("book_name"), 
                        rs.getDouble("price"), rs.getInt("quantity"), rs.getString("category"), rs.getString("authur_name"), rs.getInt("selling_quan"), p));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public Book getTop1Books() {
        Book list = null;
        String query = """
           with orderList as (
            select sum(od.quantity) as quantity,od.sku from OrderDetails od join Orders o
            on od.order_id=o.id
            group by od.sku
            )
            select top 6
            pd.id,pd.book_name,
            p.img,p.description,p.quantity,p.price,p.sku,
            STRING_AGG( a.name,', ') as authur_name,
            ol.quantity as selling_quan,
            c.name as category
            from product p join productDetail pd
            on p.sku=pd.product_sku
            join Product_Author pa
            on pa.product_sku=p.sku
            join Author a
            on a.id=pa.author_id
            join orderList ol
            on ol.sku=p.sku
            join Category c
            on c.id=p.category_id
            group by
            pd.id,pd.book_name,
            p.img,p.description,p.quantity,p.price,p.sku,ol.quantity,c.name
            order by selling_quan desc
        """;

        try (PreparedStatement ps = this.getConnection().prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                ProductDetail p= new ProductDetail(rs.getInt("id"));
                list=new Book(rs.getString("sku"), rs.getString("img"), rs.getString("book_name"),rs.getDouble("price"), rs.getInt("quantity"), rs.getString("category"), rs.getString("authur_name"), rs.getInt("selling_quan"), p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
