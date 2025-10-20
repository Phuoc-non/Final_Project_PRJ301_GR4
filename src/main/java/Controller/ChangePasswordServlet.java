/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Util.MD5Util;
import dao.RegistrationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Registration;

/**
 *
 * @author DELL
 */
@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/change-password"})
public class ChangePasswordServlet extends HttpServlet {

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
            out.println("<title>Servlet ChangePasswordServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePasswordServlet at " + request.getContextPath() + "</h1>");
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
        response.sendRedirect(request.getContextPath() + "/profile");
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

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Registration user = (Registration) session.getAttribute("user");

        // Nếu chưa đăng nhập thì quay lại login
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy dữ liệu từ form
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");

        // Mã hoá MD5 cho mật khẩu nhập vào
        String oldPasswordHash = MD5Util.md5(oldPassword);
        String newPasswordHash = MD5Util.md5(newPassword);

        RegistrationDAO dao = new RegistrationDAO();

        // So sánh mật khẩu cũ (đã mã hoá) với DB
        if (!user.getPassword().equals(oldPasswordHash)) {
            request.setAttribute("message", "Old password is incorrect!");
            request.getRequestDispatcher("/WEB-INF/profile.jsp").forward(request, response);
            return;
        }

        // Kiểm tra mật khẩu mới khớp nhau
        if (!newPassword.equals(confirmNewPassword)) {
            request.setAttribute("message", "New password does not match!");
            request.getRequestDispatcher("/WEB-INF/profile.jsp").forward(request, response);
            return;
        }

        // Cập nhật DB với mật khẩu mới (đã hash MD5)
        boolean updated = dao.updatePassword(user.getId(), newPasswordHash);
        if (updated) {
            // Cập nhật lại session
            user.setPassword(newPasswordHash);
            session.setAttribute("user", user);
            request.setAttribute("message", "successful");
        } else {
            request.setAttribute("message", "Password change failed!");
        }

        request.setAttribute("currentUser", user);
        request.getRequestDispatcher("/WEB-INF/profile.jsp").forward(request, response);
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
