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
import model.Order;
import model.Registration;

/**
 *
 * @author DELL
 */
public class CustomerDAO extends DBContext {

    public List<Order> getAllCustomer() {
        List<Order> list = new ArrayList<>();
        try {
            String query = "SELECT \n"
                    + "    R.id AS reg_id,\n"
                    + "    R.full_name,\n"
                    + "    R.username,\n"
                    + "    R.email,\n"
                    + "    R.address AS reg_address,\n"
                    + "    MAX(O.phone) AS phone,             \n"
                    + "    COUNT(O.id) AS totalOrders,\n"
                    + "    MIN(O.dateBuy) AS CreateOrder\n"
                    + "FROM Registration R\n"
                    + "LEFT JOIN Orders O ON R.username = O.username\n"
                    + "WHERE R.isAdmin = 0 \n"
                    + "GROUP BY R.id, R.full_name, R.username, R.email, R.address\n"
                    + "ORDER BY R.id ASC;";   //sắp xếp theo id tăng dần

            PreparedStatement statement = this.getConnection().prepareStatement(query);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Registration reg = new Registration();
                reg.setId(rs.getInt("reg_id"));
                reg.setFull_name(rs.getString("full_name"));
                reg.setUsername(rs.getString("username"));
                reg.setEmail(rs.getString("email"));
                reg.setAddress(rs.getString("reg_address"));
                reg.setIsAdmin(false); // vì WHERE R.isAdmin = 0

                Order order = new Order();
                order.setPhone(rs.getString("phone"));
                order.setTotal(rs.getInt("totalOrders"));
                order.setDateBuy(rs.getTimestamp("CreateOrder"));
                order.setRegistration(reg);

                list.add(order);
            }

        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;

    }

    public Order getLastOrderByRegistrationId(int registrationId) {
        String sql = "SELECT TOP 1 * FROM Orders O "
                + "JOIN Registration R ON O.username = R.username "
                + "WHERE R.id = ? "
                + "ORDER BY O.dateBuy DESC";

        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setInt(1, registrationId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setDateBuy(rs.getTimestamp("dateBuy"));
                o.setTotal(rs.getInt("total"));
                o.setName(rs.getString("name"));
                o.setPhone(rs.getString("phone"));
                o.setAddress(rs.getString("address"));
                return o;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean hasOrderByRegistrationId(int registrationId) {
        String sql = "SELECT COUNT(*) AS total FROM Orders WHERE username = (SELECT username FROM Registration WHERE id = ?)";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setInt(1, registrationId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total") > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
