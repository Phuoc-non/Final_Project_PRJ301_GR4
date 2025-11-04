/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dao.HomeDAO;
import dao.ReviewDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Book;
import model.UserReview;

/**
 *
 * @author DELL
 */
@WebServlet(name = "BookServlet", urlPatterns = {"/book"})
public class BookServlet extends HttpServlet {

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
        HomeDAO dao = new HomeDAO();
        List<Book> list = dao.getTop6Books();
        ReviewDao rd = new ReviewDao();
        List<UserReview> rating = rd.getAll();
        for (Book book : list) {
             double avgRating = 0;
              int sum = 0;
              int count=0;
                System.out.println("----------");
            for (UserReview userReview : rating) {
                if(book.getSku_product().equals(userReview.getSku())){
                    sum += userReview.getRating();
                    System.out.println(userReview.getRating()+userReview.getSku());
                    count+=1;
                }
                avgRating = (double) sum / count;
                System.out.println(avgRating);
            }
        }
        request.setAttribute("rw", rating);
        request.setAttribute("bookList", list);
        Book top1 = dao.getTop1Books();
        request.setAttribute("Top1", top1);
        request.getRequestDispatcher("/WEB-INF/home.jsp").forward(request, response);
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
