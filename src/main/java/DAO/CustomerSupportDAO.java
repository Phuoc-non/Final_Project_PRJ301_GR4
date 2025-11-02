/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CustomerSupport;
import model.Order;
import model.Registration;

/**
 *
 * @author ASUS
 */
public class CustomerSupportDAO extends DBContext {

    /**
     * Thêm yêu cầu hỗ trợ mới
     */
    public boolean addSupportRequest(CustomerSupport support) {
        String sql = "INSERT INTO [dbo].[ReturnRequest] "
                + "([order_id], [username], [reason], [total_refund], [description], [email], [status]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, support.getOrderId());
            ps.setString(2, support.getUsername());
            ps.setString(3, support.getReason());
            ps.setDouble(4, support.getTotalRefund());
            ps.setString(5, support.getDescription());
            ps.setString(6, support.getEmail());
            ps.setString(7, "Pending"); // Mặc định là Pending
            
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            Logger.getLogger(CustomerSupportDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    /**
     * Lấy tổng tiền của đơn hàng
     */
    public double getOrderTotal(int orderId) {
        String sql = "SELECT total FROM Orders WHERE id = ?";
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total");
            }
        } catch (SQLException e) {
            Logger.getLogger(CustomerSupportDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return 0;
    }

    /**
     * Lấy tất cả yêu cầu hỗ trợ của một user
     */
    public List<CustomerSupport> getSupportRequestsByUsername(String username) {
        List<CustomerSupport> list = new ArrayList<>();
        String sql = "SELECT rr.*, o.dateBuy, o.total, o.name, o.phone, o.address, "
                + "r.id as reg_id, r.full_name, r.email as reg_email "
                + "FROM ReturnRequest rr "
                + "JOIN Orders o ON rr.order_id = o.id "
                + "JOIN Registration r ON rr.username = r.username "
                + "WHERE rr.username = ? "
                + "ORDER BY rr.request_date DESC";
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                CustomerSupport cs = new CustomerSupport();
                cs.setId(rs.getInt("id"));
                cs.setOrderId(rs.getInt("order_id"));
                cs.setUsername(rs.getString("username"));
                cs.setReason(rs.getString("reason"));
                cs.setTotalRefund(rs.getDouble("total_refund"));
                cs.setDescription(rs.getString("description"));
                cs.setEmail(rs.getString("email"));
                cs.setStatus(rs.getString("status"));
                cs.setRequestDate(rs.getTimestamp("request_date"));
                
                // Set Order info
                Order order = new Order();
                order.setId(rs.getInt("order_id"));
                order.setDateBuy(rs.getTimestamp("dateBuy"));
                order.setTotal(rs.getInt("total"));
                order.setName(rs.getString("name"));
                order.setPhone(rs.getString("phone"));
                order.setAddress(rs.getString("address"));
                cs.setOrder(order);
                
                // Set Registration info
                Registration reg = new Registration();
                reg.setId(rs.getInt("reg_id"));
                reg.setFull_name(rs.getString("full_name"));
                reg.setUsername(rs.getString("username"));
                reg.setEmail(rs.getString("reg_email"));
                cs.setRegistration(reg);
                
                list.add(cs);
            }
        } catch (SQLException e) {
            Logger.getLogger(CustomerSupportDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }

    /**
     * Lấy tất cả yêu cầu hỗ trợ (cho admin)
     */
    public List<CustomerSupport> getAllSupportRequests() {
        List<CustomerSupport> list = new ArrayList<>();
        String sql = "SELECT rr.*, o.dateBuy, o.total, o.name, o.phone, o.address, "
                + "r.id as reg_id, r.full_name, r.email as reg_email "
                + "FROM ReturnRequest rr "
                + "JOIN Orders o ON rr.order_id = o.id "
                + "JOIN Registration r ON rr.username = r.username "
                + "ORDER BY rr.request_date DESC";
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                CustomerSupport cs = new CustomerSupport();
                cs.setId(rs.getInt("id"));
                cs.setOrderId(rs.getInt("order_id"));
                cs.setUsername(rs.getString("username"));
                cs.setReason(rs.getString("reason"));
                cs.setTotalRefund(rs.getDouble("total_refund"));
                cs.setDescription(rs.getString("description"));
                cs.setEmail(rs.getString("email"));
                cs.setStatus(rs.getString("status"));
                cs.setRequestDate(rs.getTimestamp("request_date"));
                
                // Set Order info
                Order order = new Order();
                order.setId(rs.getInt("order_id"));
                order.setDateBuy(rs.getTimestamp("dateBuy"));
                order.setTotal(rs.getInt("total"));
                order.setName(rs.getString("name"));
                order.setPhone(rs.getString("phone"));
                order.setAddress(rs.getString("address"));
                cs.setOrder(order);
                
                // Set Registration info
                Registration reg = new Registration();
                reg.setId(rs.getInt("reg_id"));
                reg.setFull_name(rs.getString("full_name"));
                reg.setUsername(rs.getString("username"));
                reg.setEmail(rs.getString("reg_email"));
                cs.setRegistration(reg);
                
                list.add(cs);
            }
        } catch (SQLException e) {
            Logger.getLogger(CustomerSupportDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }

    /**
     * Cập nhật trạng thái yêu cầu (cho admin)
     */
    public boolean updateSupportStatus(int id, String status) {
        String sql = "UPDATE ReturnRequest SET status = ? WHERE id = ?";
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, id);
            
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            Logger.getLogger(CustomerSupportDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    /**
     * Xóa yêu cầu hỗ trợ
     */
    public boolean deleteSupportRequest(int id) {
        String sql = "DELETE FROM ReturnRequest WHERE id = ?";
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, id);
            
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            Logger.getLogger(CustomerSupportDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    /**
     * Kiểm tra xem đơn hàng đã có yêu cầu hỗ trợ chưa
     */
    public boolean hasExistingRequest(int orderId, String username) {
        String sql = "SELECT COUNT(*) FROM ReturnRequest WHERE order_id = ? AND username = ?";
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.setString(2, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            Logger.getLogger(CustomerSupportDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    /**
     * Lấy chi tiết một yêu cầu hỗ trợ
     */
    public CustomerSupport getSupportRequestById(int id) {
        String sql = "SELECT rr.*, o.dateBuy, o.total, o.name, o.phone, o.address, "
                + "r.id as reg_id, r.full_name, r.email as reg_email "
                + "FROM ReturnRequest rr "
                + "JOIN Orders o ON rr.order_id = o.id "
                + "JOIN Registration r ON rr.username = r.username "
                + "WHERE rr.id = ?";
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                CustomerSupport cs = new CustomerSupport();
                cs.setId(rs.getInt("id"));
                cs.setOrderId(rs.getInt("order_id"));
                cs.setUsername(rs.getString("username"));
                cs.setReason(rs.getString("reason"));
                cs.setTotalRefund(rs.getDouble("total_refund"));
                cs.setDescription(rs.getString("description"));
                cs.setEmail(rs.getString("email"));
                cs.setStatus(rs.getString("status"));
                cs.setRequestDate(rs.getTimestamp("request_date"));
                
                // Set Order info
                Order order = new Order();
                order.setId(rs.getInt("order_id"));
                order.setDateBuy(rs.getTimestamp("dateBuy"));
                order.setTotal(rs.getInt("total"));
                order.setName(rs.getString("name"));
                order.setPhone(rs.getString("phone"));
                order.setAddress(rs.getString("address"));
                cs.setOrder(order);
                
                // Set Registration info
                Registration reg = new Registration();
                reg.setId(rs.getInt("reg_id"));
                reg.setFull_name(rs.getString("full_name"));
                reg.setUsername(rs.getString("username"));
                reg.setEmail(rs.getString("reg_email"));
                cs.setRegistration(reg);
                
                return cs;
            }
        } catch (SQLException e) {
            Logger.getLogger(CustomerSupportDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return null;
    }
}
