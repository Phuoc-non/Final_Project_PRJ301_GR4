/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dao.PromotionDao;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Category;
import model.Promotion;

/**
 *
 * @author Admin
 */
@WebServlet(name = "PromotionServlet", urlPatterns = {"/Promotion"})
public class PromotionServlet extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PromotionDao dao = new PromotionDao();
        // 🧩 1. Lấy số trang từ URL (?page=2), mặc định là trang 1
        int page = 1;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException ex) {
                System.err.println("Invalid page parameter");
            }
        }

        // 🧩 2. Gọi DAO lấy danh sách category theo trang
        List<Promotion> categoryList = dao.getPromotionList(page);

        // 🧩 3. Lấy tổng số dòng để tính tổng số trang
        int totalRows = dao.getTotalRows();
        int totalPages = (int) Math.ceil(totalRows / 10.0); // Mỗi trang 10 dòng

        // 🧩 4. Truyền dữ liệu sang JSP
        request.setAttribute("list", categoryList); // ⚠️ Dùng danh sách theo trang
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("/WEB-INF/admin/promotion.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("create")) {
            try {
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

                PromotionDao dao = new PromotionDao();

                String code = request.getParameter("code");
                Date sday = formatter.parse(request.getParameter("sday"));
                Date eday = formatter.parse(request.getParameter("eday"));
                int discount = Integer.parseInt(request.getParameter("discount"));
                int minvalue = Integer.parseInt(request.getParameter("minValue"));
                String description = request.getParameter("description");
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                int status = 0;
                Date today = new Date();
                if (!today.before(sday) && !today.after(eday)) {
                    status = 1; // đang trong khoảng
                } else if (today.before(sday)) {
                    status = 2; // chưa tới ngày bắt đầu
                }
                int checkCreate = dao.create(code, discount, sday, eday, description, status, minvalue, quantity);
                if (checkCreate == 0) { // lỗi
                    request.setAttribute("messageType", "error");
                    request.setAttribute("message", "Add promotion failed! Please try again.");
                } else { // thành công
                    request.setAttribute("messageType", "success");
                    request.setAttribute("message", "Promotion added successfully!");
                }
                request.setAttribute("list", dao.getPromotionList(1));

                request.getRequestDispatcher("/WEB-INF/admin/promotion.jsp").forward(request, response);
            } catch (ParseException ex) {
                System.getLogger(PromotionServlet.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
            }

        } else if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String code = request.getParameter("code");
            String description = request.getParameter("description");
            int minvalue = Integer.parseInt(request.getParameter("minValue"));
            int discount = Integer.parseInt(request.getParameter("discount"));

            PromotionDao dao = new PromotionDao();
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int checkEdit = dao.edit(id, code, discount, description, minvalue, quantity);
            if (checkEdit == 0) { // lỗi
                request.setAttribute("messageType", "error");
                request.setAttribute("message", "Edit promotion failed! Please try again.");
            } else { // thành công
                request.setAttribute("messageType", "success");
                request.setAttribute("message", "Promotion editted successfully!");
            }
            request.setAttribute("list", dao.getPromotionList(1));

            request.getRequestDispatcher("/WEB-INF/admin/promotion.jsp").forward(request, response);

        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            PromotionDao dao = new PromotionDao();
            int checkDelete = dao.delete(id);

            if (checkDelete == 0) { // lỗi
                request.setAttribute("messageType", "error");
                request.setAttribute("message", "Delete promotion failed! Please try again.");
            } else { // thành công
                request.setAttribute("messageType", "success");
                request.setAttribute("message", "Promotion deleted successfully!");
            }
            request.setAttribute("list", dao.getPromotionList(1));

            request.getRequestDispatcher("/WEB-INF/admin/promotion.jsp").forward(request, response);
        }

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
