/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dao.CustomerDAO;
import dao.RegistrationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Order;
import model.Registration;

/**
 *
 * @author DELL
 */
@WebServlet(name = "CutomerServlet", urlPatterns = {"/cutomer"})
public class CutomerServlet extends HttpServlet {

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
            out.println("<title>Servlet CutomerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CutomerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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

        String view = request.getParameter("view");
        String idParam = request.getParameter("id");

        CustomerDAO customerDAO = new CustomerDAO();
        RegistrationDAO regDao = new RegistrationDAO();

        // Nếu không có "view" → hiển thị danh sách khách hàng
        if (view == null || view.trim().isEmpty()) {
            List<Order> list = customerDAO.getAllCustomer();
            request.setAttribute("reports", list);
            request.getRequestDispatcher("/WEB-INF/user_ad.jsp").forward(request, response);
            return;
        }

        // 🧩 Kiểm tra hợp lệ của ID
        int id = -1;
        if (idParam == null || idParam.isEmpty()) {
            request.setAttribute("errorMessage", "Thiếu tham số ID.");
            List<Order> list = customerDAO.getAllCustomer();
            request.setAttribute("reports", list);
            request.getRequestDispatcher("/WEB-INF/user_ad.jsp").forward(request, response);
            return;
        }

        try {
            id = Integer.parseInt(idParam);
            if (id <= 0) {
                request.setAttribute("errorMessage", "ID phải là số dương hợp lệ!");
                List<Order> list = customerDAO.getAllCustomer();
                request.setAttribute("reports", list);
                request.getRequestDispatcher("/WEB-INF/user_ad.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Tham số ID không đúng định dạng số!");
            List<Order> list = customerDAO.getAllCustomer();
            request.setAttribute("reports", list);
            request.getRequestDispatcher("/WEB-INF/user_ad.jsp").forward(request, response);
            return;
        }

        // 🧩 Lấy thông tin khách hàng theo ID
        Registration reg = regDao.getRegistrationById(id);
        if (reg == null) {
            request.setAttribute("errorMessage", "Không tìm thấy khách hàng có ID = " + id);
            List<Order> list = customerDAO.getAllCustomer();
            request.setAttribute("reports", list);
            request.getRequestDispatcher("/WEB-INF/user_ad.jsp").forward(request, response);
            return;
        }

        // 🧩 Xử lý từng hành động
        switch (view) {
            case "edit-user": {
                Order lastOrder = customerDAO.getLastOrderByRegistrationId(id);
                request.setAttribute("currentUser", reg);
                request.setAttribute("lastOrder", lastOrder);
                request.getRequestDispatcher("/WEB-INF/profile_user.jsp").forward(request, response);
                break;
            }

            case "delete-user": {
                boolean hasOrder = customerDAO.hasOrderByRegistrationId(id);
                if (hasOrder) {
                    request.setAttribute("errorMessage", "Không thể xóa khách hàng đang có đơn hàng!");
                } else {
                    boolean deleted = regDao.deleteRegistrationById(id);
                    if (deleted) {
                        request.setAttribute("successMessage", "Xóa khách hàng thành công!");
                    } else {
                        request.setAttribute("errorMessage", "Xóa khách hàng thất bại!");
                    }
                }
                List<Order> list = customerDAO.getAllCustomer();
                request.setAttribute("reports", list);
                request.getRequestDispatcher("/WEB-INF/user_ad.jsp").forward(request, response);
                break;
            }

            default: {
                request.setAttribute("errorMessage", "Hành động không hợp lệ!");
                List<Order> list = customerDAO.getAllCustomer();
                request.setAttribute("reports", list);
                request.getRequestDispatcher("/WEB-INF/user_ad.jsp").forward(request, response);
                break;
            }
        }
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
