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
import model.Promotion;


/**
 *
 * @author Admin
 */
public class PromotionDao extends DBContext{
    
      public ArrayList<Promotion> getAll() {
        ArrayList<Promotion> list = new ArrayList<>();
        try {
            String sql = "select * from Promotion";
            PreparedStatement statement = this.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                
                list.add(new Promotion(rs.getString(2),rs.getInt(3),rs.getDate(4),rs.getDate(5),rs.getString(6),rs.getInt(7)));

            }

        } catch (SQLException ex) {
            System.getLogger(PromotionDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);

        }
        return list;
    }
}
