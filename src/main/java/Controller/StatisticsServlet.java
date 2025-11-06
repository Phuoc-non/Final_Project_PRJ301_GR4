/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dao.StatisticsDAO;
import com.google.gson.Gson;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ChartData;

/**
 *
 * @author Admin
 */
@WebServlet(name = "StatisticsServlet", urlPatterns = {"/statistics"})
public class StatisticsServlet extends HttpServlet {

   

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param req servlet request
     * @param resp servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        StatisticsDAO dao = new StatisticsDAO();
        Gson gson = new Gson();
        
        String period = req.getParameter("period");
        if (period == null) period = "month";

        ChartData revenue = dao.getRevenueByPeriod(period);
        ChartData bestSeller = dao.getBestSellingProducts(period);

        String jsonRevenue = String.format(
            "{\"labels\":%s,\"datasets\":[{\"label\":\"Tổng doanh thu\",\"data\":%s}]}",
            gson.toJson(revenue.getLabels()), gson.toJson(revenue.getValues())
        );

        String jsonBestSeller = String.format(
            "{\"labels\":%s,\"datasets\":[{\"label\":\"Sản phẩm bán chạy\",\"data\":%s}]}",
            gson.toJson(bestSeller.getLabels()), gson.toJson(bestSeller.getValues())
        );

        req.setAttribute("revenueData", jsonRevenue);
        req.setAttribute("bestSellerData", jsonBestSeller);
        req.setAttribute("period", period);

        req.getRequestDispatcher("/WEB-INF/admin/statistics.jsp").forward(req, resp);
    }


    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
     
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
