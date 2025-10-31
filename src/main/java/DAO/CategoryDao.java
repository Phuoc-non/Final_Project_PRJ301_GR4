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
import model.Category;

/**
 *
 * @author Admin
 */
public class CategoryDao extends DBContext {

    public ArrayList<Category> getAll() {
        ArrayList<Category> list = new ArrayList<>();
        try {
            String sql = "SELECT \n"
                    + "    c.id,\n"
                    + "    c.name,\n"
                    + "	  COUNT(p.category_id) AS quantity,\n"
                    + "   c.created_at ,\n"
                    + "  c.updated_at \n"
                    + "  \n"
                    + "FROM category c\n"
                    + "LEFT JOIN product p ON c.id = p.category_id\n"
                    + "GROUP BY c.id, c.name, c.created_at, c.updated_at\n"
                    + "ORDER BY c.id;";
            PreparedStatement statement = this.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Category cate = new Category(rs.getInt("id"), rs.getString("name"), rs.getInt("quantity"), rs.getDate("created_at"), rs.getDate("updated_at"));
                list.add(cate);

            }

        } catch (SQLException ex) {
            System.getLogger(CategoryDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);

        }
        return list;
    }

    public int create(int id,String name) {

        try {
            String query = "SET IDENTITY_INSERT Category ON;\n"
                    + "\n"
                    + "insert into Category (id,name, created_at, updated_at)\n"
                    + "values (?,?, CAST(GETDATE() AS date), NULL);\n"
                    + "\n"
                    + "SET IDENTITY_INSERT Category OFF;";

            PreparedStatement statement = this.getConnection().prepareStatement(query);
            statement.setInt(1, id);
            statement.setString(2, name);

            return statement.executeUpdate();
        } catch (SQLException ex) {
            System.getLogger(CategoryDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
            return 0;
        }
    }

    public boolean checkNameCategory(String name) {

        try {
            String sql = " select name from Category";
            PreparedStatement statement = this.getConnection().prepareStatement(sql);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                if (name.equals(rs.getString("name"))) {
                    return false;
                }
            }
        } catch (SQLException ex) {
            System.getLogger(CategoryDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return true;
    }

    public int edit(int id, String newName) {

        try {
            String sql = "UPDATE Category SET name = ? where id = ? ";
            PreparedStatement statement = this.getConnection().prepareStatement(sql);
            statement.setString(1, newName);
            statement.setInt(2, id);

            return statement.executeUpdate();
        } catch (SQLException ex) {
            System.getLogger(CategoryDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return 0;
    }
    
    public int delete(int id){
        
        try {
            String sql="delete  from Category  where id = ?";
            PreparedStatement statement = this.getConnection().prepareStatement(sql);
            statement.setInt(1, id);
            
            return statement.executeUpdate();
        } catch (SQLException ex) {
            System.getLogger(CategoryDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        
        return 0;
    }
}
