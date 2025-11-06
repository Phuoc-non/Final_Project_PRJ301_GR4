/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Book;
import model.Category;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "AllBook", urlPatterns = {"/ab"})
public class AllBookServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AllBook</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AllBook at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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

        ProductDAO dao = new ProductDAO();

        // Nhận tham số từ client
        String keyword = request.getParameter("keyword");
        String type = request.getParameter("type");
        String sortBy = request.getParameter("sortBy");

        // ✅ Gán mặc định
        if (type == null || type.isEmpty()) {
            type = "title";
        }
        List<Book> list = null;

        // ✅ Ưu tiên tìm kiếm
        if (keyword != null && !keyword.trim().isEmpty()) {
            keyword = keyword.trim();
            if ("author".equalsIgnoreCase(type)) {
                list = dao.searchBookByAuthor(keyword);
            } else {
                list = dao.searchBookByTitle(keyword);
                type = "title"; // tránh lỗi UI
            }
        } else {
            // ✅ Không search → sort
            if ("title".equalsIgnoreCase(sortBy)) {
                list = dao.getBooksSortedByName();
            } else if ("price".equalsIgnoreCase(sortBy)) {
                list = dao.getBooksSortedByPrice();
            } else {
                // ✅ Không search & không sort → lấy tất cả
                list = dao.getAllBook();
            }
        }

        // ✅ Lấy danh mục
        List<Category> categories = dao.getAllCategories();

        // ✅ Đẩy dữ liệu sang JSP
        request.setAttribute("list", list);
        request.setAttribute("categories", categories);
        request.setAttribute("keyword", keyword);
        request.setAttribute("type", type);
        request.setAttribute("sortBy", sortBy);

        request.getRequestDispatcher("/WEB-INF/User/AllBook.jsp").forward(request, response);
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
        processRequest(request, response);
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
