/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

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
                    + "    COUNT(p.category_id) AS quantity\n"
                    + "FROM category c\n"
                    + "LEFT JOIN product p ON c.id = p.category_id\n"
                    + "GROUP BY c.id, c.name\n"
                    + "ORDER BY c.id;";
            PreparedStatement statement = this.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {

                list.add(new Category(rs.getInt("id"), rs.getString("name"), rs.getInt("quantity")));

            }

        } catch (SQLException ex) {
            System.getLogger(CategoryDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);

        }
        return list;
    }

}
