/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author DELL
 */
import db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Registration;

/**
 *
 * @author DELL
 */
public class RegistrationDAO extends DBContext {

    public Registration login(String username, String password) {
        try {
            String sql = "select * from Registration where username = ? and password = ?";
            PreparedStatement stm = this.getConnection().prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Registration a = new Registration(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getBoolean(6), rs.getString(7));
                return a;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegistrationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean register(Registration re) {
        String sql = "INSERT INTO [dbo].[Registration]\n"
                + "           ([full_name]\n"
                + "           ,[username]\n"
                + "           ,[password]\n"
                + "           ,[email]\n"
                + "           ,[isAdmin]\n"
                + "           ,[address])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?)";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(sql);
            ps.setString(1, re.getFull_name());
            ps.setString(2, re.getUsername());
            ps.setString(3, re.getPassword());
            ps.setString(4, re.getEmail());
            ps.setBoolean(5, false); // mặc định user không phải admin
            ps.setString(6, re.getAddress());
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public boolean checkDuplicateUsername(String username) {
        String checkDuplicateUsername = "SELECT * FROM Registration WHERE username = ?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(checkDuplicateUsername);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
//update profile
    public boolean updateUserInfo(Registration user) {
        String sql = "UPDATE Registration SET full_name=?, email=?, address=? WHERE id=?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(sql);

            ps.setString(1, user.getFull_name());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getAddress());
            ps.setInt(4, user.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }

    
    }   
        

    public boolean updatePassword(int id, String newPasswordHash) {
        String sql = "UPDATE Registration SET password=? WHERE id=?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(sql);
            ps.setString(1, newPasswordHash);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("updatePassword error: " + e.getMessage());
        }
        return false;
    }
    
    
    public boolean deleteRegistrationById(int id) {
        String sql = "DELETE FROM Registration WHERE id = ?";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public Registration getRegistrationById(int id) {
        String sql = "SELECT * FROM Registration WHERE id = ?";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Registration r = new Registration();
                r.setId(rs.getInt("id"));
                r.setFull_name(rs.getString("full_name"));
                r.setUsername(rs.getString("username"));
                r.setPassword(rs.getString("password"));
                r.setEmail(rs.getString("email"));
                r.setIsAdmin(rs.getBoolean("isAdmin"));
                r.setAddress(rs.getString("address"));
                return r;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
