/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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

    public int create(String name) {

        String query = "  insert into Category (name, created_at, updated_at)\n"
                + "values (?, CAST(GETDATE() AS date), NULL);\n";


        try {
            Connection con = this.getConnection();

            PreparedStatement statement = con.prepareStatement(query);
            statement.setString(1, name);
           return statement.executeUpdate();

            
        } catch (SQLException ex) {
            System.getLogger(CategoryDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
            return 0;
        }
    }

    public boolean checkNameCategory(String name) {

        try {
            String sql = " select name from Category ";
            PreparedStatement statement = this.getConnection().prepareStatement(sql);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                if (name.equalsIgnoreCase(rs.getString("name"))) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.getLogger(CategoryDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return false;
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

    public int delete(int id) {

        try {
            String sql = "delete  from Category  where id = ?";
            PreparedStatement statement = this.getConnection().prepareStatement(sql);
            statement.setInt(1, id);

            return statement.executeUpdate();
        } catch (SQLException ex) {
            System.getLogger(CategoryDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }

        return 0;
    }

    public List<Category> getCategoryList(int page) {
        List<Category> list = new ArrayList<>();
        try {
            String sql = """
            SELECT 
                c.id,
                c.name,
                COUNT(p.category_id) AS quantity,
                c.created_at,
                c.updated_at
            FROM category c
            LEFT JOIN product p ON c.id = p.category_id
            GROUP BY c.id, c.name, c.created_at, c.updated_at
            ORDER BY c.id
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;

            PreparedStatement ps = this.getConnection().prepareStatement(sql);
            ps.setInt(1, (page - 1) * 10); // Bỏ qua (page-1)*10 dòng
            ps.setInt(2, 10);              // Lấy 10 dòng tiếp theo

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                int quantity = rs.getInt("quantity");
                Date created_at = rs.getDate("created_at");
                Date updated_at = rs.getDate("updated_at");

                // ⚙️ Tạo đối tượng Category (bạn đổi theo tên class thật)
                Category category = new Category(id, name, quantity, created_at, updated_at);
                list.add(category);
            }

        } catch (SQLException e) {
            Logger.getLogger(CategoryDao.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }

    public int getTotalRows() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM Category";
            PreparedStatement ps = this.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            Logger.getLogger(CategoryDao.class.getName()).log(Level.SEVERE, null, e);
        }
        return count;
    }
}
