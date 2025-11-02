/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import db.DBContext;
import java.util.ArrayList;
import java.util.List;
import model.ChartData;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


/**
 *
 * @author Admin
 */
public class StatisticsDAO extends DBContext{
      // ---------- 1️⃣ Thống kê doanh thu ----------
    public ChartData getRevenueByPeriod(String period) {
        try {
            String sql;
            switch (period) {
                case "day":
                    sql = """
                                          SELECT CONVERT(VARCHAR(10), dateBuy, 120) AS Label, SUM(total) AS Revenue
                                          FROM Orders
                                          GROUP BY CONVERT(VARCHAR(10), dateBuy, 120)
                                          ORDER BY Label
                                          """;
                    break;
                case "year":
                    sql = """
                                          SELECT YEAR(dateBuy) AS Label, SUM(total) AS Revenue
                                          FROM Orders
                                          GROUP BY YEAR(dateBuy)
                                          ORDER BY Label
                                          """;
                    break;
                default: // month
                    sql = """
                                          SELECT FORMAT(dateBuy, 'yyyy-MM') AS Label, SUM(total) AS Revenue
                                          FROM Orders
                                          GROUP BY FORMAT(dateBuy, 'yyyy-MM')
                                          ORDER BY Label
                                          """;
            }
            
            List<String> labels = new ArrayList<>();
            List<Double> values = new ArrayList<>();
            
            
            PreparedStatement st = this.getConnection().prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                labels.add(rs.getString("Label"));
                values.add(rs.getDouble("Revenue"));
            }
            
            return new ChartData(labels, values);
        } catch (SQLException ex) {
            System.getLogger(StatisticsDAO.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return null;
    }

    // ---------- 2️⃣ Thống kê sản phẩm bán chạy ----------
    public ChartData getBestSellingProducts(String period) {
        try {
            String sql;
            switch (period) {
                case "day":
                    sql = """
                                          SELECT TOP 5 p.name AS Product, SUM(od.quantity) AS Sold
                                          FROM OrderDetails od
                                          JOIN Orders o ON od.order_id = o.id
                                          JOIN Product p ON od.sku = p.sku
                                          GROUP BY p.name, CONVERT(VARCHAR(10), o.dateBuy, 120)
                                          ORDER BY Sold DESC
                                          """;
                    break;
                case "year":
                    sql = """
                                          SELECT TOP 5 p.name AS Product, SUM(od.quantity) AS Sold
                                          FROM OrderDetails od
                                          JOIN Orders o ON od.order_id = o.id
                                          JOIN Product p ON od.sku = p.sku
                                          GROUP BY p.name, YEAR(o.dateBuy)
                                          ORDER BY Sold DESC
                                          """;
                    break;
                default:
                    sql = """
                                          SELECT TOP 5 p.name AS Product, SUM(od.quantity) AS Sold
                                          FROM OrderDetails od
                                          JOIN Orders o ON od.order_id = o.id
                                          JOIN Product p ON od.sku = p.sku
                                          GROUP BY p.name, FORMAT(o.dateBuy, 'yyyy-MM')
                                          ORDER BY Sold DESC
                                          """;
            }
            
            List<String> labels = new ArrayList<>();
            List<Double> values = new ArrayList<>();
            
            
            PreparedStatement ps = this.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                labels.add(rs.getString("Product"));
                values.add(rs.getDouble("Sold"));
            }
            
            
            return new ChartData(labels, values);
        } catch (SQLException ex) {
            System.getLogger(StatisticsDAO.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return null;
    }
}