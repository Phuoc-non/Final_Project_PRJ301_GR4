/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

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
@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

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
            out.println("<title>Servlet ProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Registration user = (Registration) session.getAttribute("user");

        if (user == null) {
        response.sendRedirect(getServletContext().getContextPath() + "/login");
            return;
        }

        request.setAttribute("currentUser", user);
        request.getRequestDispatcher("/WEB-INF/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Registration user = (Registration) session.getAttribute("user");

        if (user == null) {
        response.sendRedirect(getServletContext().getContextPath() + "/login");
            return;
        }

        try {
            // Lấy dữ liệu từ form
            String fullName = request.getParameter("full_name");
            String email = request.getParameter("email");
            String address = request.getParameter("address");

            // Cập nhật dữ liệu trong object user
            user.setFull_name(fullName);
            user.setEmail(email);
            user.setAddress(address);

            // Cập nhật DB
            RegistrationDAO dao = new RegistrationDAO();
            boolean updated = dao.updateUserInfo(user);

            if (updated) {
                session.setAttribute("user", user);
                request.setAttribute("message", "Thành công");
            } else {
                request.setAttribute("message", "Cập nhật thất bại");
            }

        } catch (Exception e) {
            request.setAttribute("message", "Lỗi hệ thống: " + e.getMessage());
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
