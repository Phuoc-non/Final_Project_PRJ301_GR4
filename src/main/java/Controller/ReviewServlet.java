/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dao.ReviewDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Registration;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Asus
 */
@WebServlet(name = "ReviewServlet", urlPatterns = {"/ReviewServlet"})
public class ReviewServlet extends HttpServlet {

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
        int star = 0;
        String rq = request.getParameter("id");
        String comment = request.getParameter("content");
        String starStr = request.getParameter("star");
        HttpSession session = request.getSession();
        Registration user = (Registration) session.getAttribute("user");
//        Làm cái sử lý lỗi khi chưa có đăng nhập mà comment.
        if (rq != null && !rq.isEmpty()) { //nếu ko bị lỗi trang hiển thị, nếu id ko tồn tại thì sao?
            int id=Integer.parseInt(rq);
            if (user != null) {// nếu user trong trạng thái đăng nhập
                if (starStr != null && !starStr.isEmpty()) {// nếu nhận số sao khác null và trống, chắc chắn phải có rồi, nhưng làm cho chắc kk.
                    star = Integer.parseInt(starStr);
                    ReviewDao insert = new ReviewDao();
                    if ((insert.insertByID(id, user.getUsername(), star, comment))== 1){
                    response.sendRedirect(getServletContext().getContextPath()+"/ProductDetail?productId="+id);
                }
                } else {                  
                    request.setAttribute("Errol", "StarErrol");
                    request.getRequestDispatcher("/assets/404errol.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("Errol", "UserErrol");
                request.getRequestDispatcher("/assets/404errol.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("Errol", "IDErrol");
            request.getRequestDispatcher("/assets/404errol.jsp").forward(request, response);
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
