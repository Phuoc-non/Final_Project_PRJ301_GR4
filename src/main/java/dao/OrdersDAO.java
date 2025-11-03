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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Orders;

/**
 *
 * @author ACER
 */
public class OrdersDAO extends DBContext {

    public List<Orders> getOrders() {
        List<Orders> list = new ArrayList<>();
        String sql = """
                SELECT 
                
                    o.id,                           
                    o.name,                         
                    o.phone,                        
                    o.address,                     
                    o.total,                       
                    o.datebuy,                   
                    o.updated_at,                   
                    o.status                        
                FROM Orders o
                JOIN OrderDetails od ON o.id = od.order_id
                JOIN Product p ON od.sku = p.sku
                GROUP BY 
                    o.id, o.name, o.phone, o.address, o.total, 
                    o.datebuy, o.updated_at, o.status
                ORDER BY o.datebuy DESC;
                """;

        try (PreparedStatement ps = this.getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Orders order = new Orders(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getDouble("total"),
                        rs.getDate("datebuy"),
                        rs.getDate("updated_at"),
                        rs.getString("status")
                );
                list.add(order);
            }

        } catch (SQLException e) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }

    public void deleteOrders(int id) {
        String sql = "DELETE FROM Orders WHERE id = ?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(sql);
            {
                ps.setInt(1, id);
                ps.execute();
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void editOrders(int id, String status) throws SQLException {
        String sql = "UPDATE Orders SET status = ?, updated_at = GETDATE() WHERE id = ?";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
            throw ex;
        }
    }
}
