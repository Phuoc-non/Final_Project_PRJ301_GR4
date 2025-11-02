/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Promotion;

/**
 *
 * @author Admin
 */
public class PromotionDao extends DBContext {

    public ArrayList<Promotion> getAll() {
        ArrayList<Promotion> list = new ArrayList<>();
        try {
            Connection con = this.getConnection();
          String sql = "SELECT * FROM Promotion";
            String setSatus = "UPDATE Promotion\n"
                    + "SET status = CASE\n"
                    + "                WHEN CAST(GETDATE() AS DATE) BETWEEN CAST(start_date AS DATE) AND CAST(end_date AS DATE) THEN 1\n"
                    + "                WHEN CAST(GETDATE() AS DATE) < CAST(start_date AS DATE) THEN 2\n"
                    + "                WHEN CAST(GETDATE() AS DATE) > CAST(end_date AS DATE) THEN 0\n"
                    + "               \n"
                    + "             END;";
            Statement statement1 = con.createStatement();
            statement1.execute(setSatus);

            PreparedStatement statement = con.prepareStatement(sql);

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {

                list.add(new Promotion(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getDate(4), rs.getDate(5), rs.getString(6), rs.getInt(7), rs.getInt(8), rs.getInt(9)));

            }

        } catch (SQLException ex) {
            System.getLogger(PromotionDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);

        }
        return list;
    }
    public int create(String code, int discount, Date startDay, Date endDay, String description, int status, int minOrderValue,int quantity) {

        try {
            String query = " insert into Promotion (code,discount_percent, start_date, end_date,description,status,min_order_value,quantity)\n"
                    + "  values (?,?,?,?,?,?,?,?);";

            Connection con = this.getConnection();

            PreparedStatement statement = con.prepareStatement(query);

            statement.setString(1, code);
            statement.setInt(2, discount);
            statement.setDate(3, new java.sql.Date(startDay.getTime()));
            statement.setDate(4, new java.sql.Date(endDay.getTime()));
            statement.setString(5, description);
            statement.setInt(6, status);
            statement.setInt(7, minOrderValue);
            statement.setInt(8, quantity);
            return statement.executeUpdate();

        } catch (SQLException ex) {
            System.getLogger(PromotionDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return 0;
    }

    public int edit(int id, String code, int discount, String description, int minOrderValue,int quantity) {

        try {
            String sql = "UPDATE  Promotion \n"
                    + "set  code =?,discount_percent = ?,description =?,min_order_value=?,quantity = ? \n"
                    + "where id = ?";
            PreparedStatement statement = this.getConnection().prepareStatement(sql);
            statement.setString(1, code);
            statement.setInt(2, id);
            statement.setString(3, description);
            statement.setInt(4, minOrderValue);
            statement.setInt(6, id);
            statement.setInt(5, quantity);

            return statement.executeUpdate();
        } catch (SQLException ex) {
            System.getLogger(PromotionDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return 0;
    }

     public boolean checkCodeDuplicate(String name) {

        try {
            String sql = " select code from Promotion ";
            PreparedStatement statement = this.getConnection().prepareStatement(sql);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                if (name.equalsIgnoreCase(rs.getString("code"))) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.getLogger(CategoryDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return false;
    }
    
    
    public int delete(int id) {

        try {
            String sql = "delete  from Promotion  where id = ?";
            PreparedStatement statement = this.getConnection().prepareStatement(sql);
            statement.setInt(1, id);

            return statement.executeUpdate();
        } catch (SQLException ex) {
            System.getLogger(PromotionDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }

        return 0;
    }
    public List<Promotion> getPromotionList(int page) {
        List<Promotion> list = new ArrayList<>();
        String sql = """
        SELECT 
            id,
            code,
            discount_percent,
            start_date,
            end_date,
            description,
            status,
            min_order_value,
            quantity
        FROM Promotion
        ORDER BY id
        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
    """;

        // each page = 10 rows (change if needed)
        int pageSize = 10;
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String code = rs.getString("code");

                    // discount_percent trong DB là float -> lấy về double rồi convert nếu model là int
                    double discountPercent = rs.getDouble("discount_percent");
                    int discount = (int) Math.round(discountPercent); // hoặc (int)discountPercent nếu muốn cắt

                    // Lấy ngày (java.sql.Date -> java.util.Date)
                    java.util.Date startDay = null;
                    java.util.Date endDay = null;
                    java.sql.Timestamp tsStart = rs.getTimestamp("start_date");
                    java.sql.Timestamp tsEnd = rs.getTimestamp("end_date");
                    if (tsStart != null) {
                        startDay = new java.util.Date(tsStart.getTime());
                    }
                    if (tsEnd != null) {
                        endDay = new java.util.Date(tsEnd.getTime());
                    }

                    String description = rs.getString("description");
                    int status = rs.getInt("status");

                    // min_order_value DECIMAL -> lấy double rồi cast/round về int cho model hiện tại
                    double minOrderValueDouble = rs.getDouble("min_order_value");
                    int minOrderValue = (int) Math.round(minOrderValueDouble);

                    int quantity = rs.getInt("quantity");

                    // Tạo đối tượng Promotion theo constructor của bạn
                    Promotion promo = new Promotion(id, code, discount, startDay, endDay, description, status, minOrderValue, quantity);
                    list.add(promo);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // in stack trace để debug
        }

        return list;
    }

    public int getTotalRows() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM Promotion";
            PreparedStatement ps = this.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            Logger.getLogger(PromotionDao.class.getName()).log(Level.SEVERE, null, e);
        }
        return count;
    }
}
