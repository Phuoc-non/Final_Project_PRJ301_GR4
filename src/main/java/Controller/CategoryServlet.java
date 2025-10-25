/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CategoryDao;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Category;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CategoryServlet", urlPatterns = {"/Category"})
public class CategoryServlet extends HttpServlet {

   

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
        CategoryDao dao = new CategoryDao();
        ArrayList< Category> list = dao.getAll();
        request.setAttribute("category", list);
        request.getRequestDispatcher("/WEB-INF/admin/category.jsp").forward(request, response);
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

        String action = request.getParameter("action");

        if (action.equals("create")) {
            String name = request.getParameter("name");
            CategoryDao dao = new CategoryDao();
           
            if (dao.checkNameCategory(name)) {
               
                int checkCreate = dao.create(name);
                if (checkCreate == 0) { // lỗi
                    request.setAttribute("messageType", "error");
                    request.setAttribute("message", "Add category failed! Please try again.");
                } else { // thành công
                    request.setAttribute("messageType", "success");
                    request.setAttribute("message", "Category added successfully!");
                }

                request.setAttribute("category", dao.getAll());
                request.getRequestDispatcher("/WEB-INF/admin/category.jsp").forward(request, response);
            } else {
                request.setAttribute("messageType", "error");
                request.setAttribute("message", "Category Name is already in use! Please try again.");
                request.setAttribute("category", dao.getAll());
                request.getRequestDispatcher("/WEB-INF/admin/category.jsp").forward(request, response);
            }
        } else if (action.equals("edit")) {
            String id = request.getParameter("id");
            String newName = request.getParameter("name");

            CategoryDao dao = new CategoryDao();
            int checkEdit = dao.edit(Integer.parseInt(id), newName);
            if (checkEdit == 0) {
                request.setAttribute("messageType", "error");
                request.setAttribute("message", "Category edit failed! Please try again.");

            } else {
                request.setAttribute("messageType", "success");
                request.setAttribute("message", "Category edited successfully!");
            }
            request.setAttribute("category", dao.getAll());
            request.getRequestDispatcher("/WEB-INF/admin/category.jsp").forward(request, response);
        }
        else if(action.equals("delete")){
            String id = request.getParameter("id");
             CategoryDao dao = new CategoryDao();
             int checkDelete = dao.delete(Integer.parseInt(id));
             if(checkDelete == 0){
                 request.setAttribute("messageType", "error");
                request.setAttribute("message", "Category deletion failed! Please try again.");
                 
             }else{
                  request.setAttribute("messageType", "success");
                request.setAttribute("message", "Category deleted successfully!");
                 
             }
            
                request.setAttribute("category", dao.getAll());
            request.getRequestDispatcher("/WEB-INF/admin/category.jsp").forward(request, response);
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
