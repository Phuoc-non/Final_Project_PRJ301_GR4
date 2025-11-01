/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
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
}
