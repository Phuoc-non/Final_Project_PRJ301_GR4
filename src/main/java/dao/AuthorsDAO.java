package dao;

import db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Authors;

public class AuthorsDAO extends DBContext {

    // Lấy toàn bộ danh sách tác giả
    public List<Authors> getAllAuthors() {
        List<Authors> list = new ArrayList<>();
        String sql = """
             SELECT 
                   a.id ,
                   a.name ,
                   a.bio, 
                   a.created_at,
                   a.updated_at,
                   COUNT(pa.product_sku) AS bookcount
               FROM Author a
               LEFT JOIN Product_Author pa ON a.id = pa.author_id
               LEFT JOIN Product p ON pa.product_sku = p.sku
               GROUP BY a.id, a.name, a.bio, a.created_at, a.updated_at
               ORDER BY a.name;
        """;

        try (PreparedStatement ps = this.getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Authors author = new Authors(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("bio"),             
                rs.getDate("created_at"),
                rs.getDate("updated_at"),
                rs.getInt("bookcount"));              
                list.add(author);
            }

        } catch (SQLException e) {
            Logger.getLogger(AuthorsDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return list;
    }


// Thêm mới tác giả
public void createAuthor(Authors author) {
        String sql = "INSERT INTO Author (name, bio) VALUES (?, ?)";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setString(1, author.getName());
            ps.setString(2, author.getBio());
            ps.executeUpdate();
            System.out.println("Thêm tác giả thành công!");
        } catch (SQLException e) {
            Logger.getLogger(AuthorsDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    // Cập nhật thông tin tác giả
    public void updateAuthor(Authors author) {
        String sql = "UPDATE Author SET name = ?, bio = ? WHERE id = ?";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setString(1, author.getName());
            ps.setString(2, author.getBio());
            ps.setInt(3, author.getId());
            ps.executeUpdate();
            System.out.println("Cập nhật tác giả thành công!");
        } catch (SQLException e) {
            Logger.getLogger(AuthorsDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    // Xóa tác giả theo ID
    public void deleteAuthor(int id) {
        String sql = "DELETE FROM Author WHERE id = ?";
        try (PreparedStatement ps = this.getConnection().prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("Xóa tác giả thành công!");
        } catch (SQLException e) {
            Logger.getLogger(AuthorsDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }
}
