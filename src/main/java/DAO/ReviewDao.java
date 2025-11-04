/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.UserReview;
import db.DBContext;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Asus
 */
public class ReviewDao extends DBContext {

    public List<UserReview> getById(int id) {
        List<UserReview> reviews = new ArrayList<>();
        try {
            String query = "select r.rating, r.comment, r.username, r.created_date,r.product_sku from Product p join Review r on p.sku=r.product_sku \n"
                    + "join productDetail pd\n"
                    + "on pd.product_sku=p.sku\n"
                    + "where pd.id=?";
            PreparedStatement statement = this.getConnection().prepareStatement(query);
            statement.setInt(1, id);

            //thuc hien cau truy van neu co object thi tra ve, ko co the tra ve null
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                int rating = rs.getInt("rating");
                String username = rs.getString("username");
                String comm = rs.getString("comment");
                Date date = rs.getDate("created_date");
                String sku = rs.getString("product_sku");
                reviews.add(new UserReview(rating, username, comm, date, sku));
            }
        } catch (SQLException ex) {
            System.getLogger(ProductDetailDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return reviews;
    }

    public int insertByID(int id, String username, int rating, String comment) {
        try {
            String query = "Declare @sku NVARCHAR(20);\n"
                    + "\n"
                    + "set @sku=(select p.sku from Product p\n"
                    + "join productDetail pd\n"
                    + "on p.sku = pd.product_sku\n"
                    + "where pd.id=?)\n"
                    + "\n"
                    + "INSERT [dbo].[Review] ([product_sku], [username], [rating], [comment]) \n"
                    + "VALUES (@sku,?,?,?);\n";
            //ko cần N'' vì PreparedStatement sẽ tự xử lý phần dữ liệu có dấu cho mình. mới biết Wowwww.
            PreparedStatement statement = this.getConnection().prepareStatement(query);
            statement.setInt(1, id);
            statement.setString(2, username);
            statement.setInt(3, rating);
            statement.setString(4, comment);

            return statement.executeUpdate();
        } catch (SQLException ex) {
            System.getLogger(ReviewDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return 0;
    }

    public List<UserReview> getAll() {
        List<UserReview> reviews = new ArrayList<>();
        try {
            String query = "select r.rating, r.comment, r.username, r.created_date,r.product_sku,pd.id from Product p join Review r on p.sku=r.product_sku \n"
                    + "join productDetail pd\n"
                    + "on pd.product_sku=p.sku";
            PreparedStatement statement = this.getConnection().prepareStatement(query);
           

            //thuc hien cau truy van neu co object thi tra ve, ko co the tra ve null
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                int rating = rs.getInt("rating");
                String username = rs.getString("username");
                String comm = rs.getString("comment");
                Date date = rs.getDate("created_date");
                String sku = rs.getString("product_sku");
                reviews.add(new UserReview(rating, username, comm, date, sku));
            }
        } catch (SQLException ex) {
            System.getLogger(ProductDetailDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return reviews;
    }
}
