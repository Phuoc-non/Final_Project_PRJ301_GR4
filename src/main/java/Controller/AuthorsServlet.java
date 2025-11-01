/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dao.AuthorsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Authors;

/**
 *
 *
 *
 * @author ACER
 */
@WebServlet(name = "Authors", urlPatterns = {"/authors"})
public class AuthorsServlet extends HttpServlet {

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
            out.println("<title>Servlet Authors</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Authors at " + request.getContextPath() + "</h1>");
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
        AuthorsDAO dao = new AuthorsDAO();
        List<Authors> authorList = dao.getAllAuthors();
        request.setAttribute("authorList", authorList);

        request.getRequestDispatcher("/WEB-INF/authors.jsp").forward(request, response);
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

        if (action != null && action.equals("create")) {
            createAuthor(request, response);
        }
        if (action != null && action.equals("delete")) {
            deleteAuthor(request, response);
        }
        if (action != null && action.equals("edit")) {
            editAuthor(request, response);
        }
    }

    private void createAuthor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name").trim();
        String bio = request.getParameter("bio").trim();

        AuthorsDAO dao = new AuthorsDAO();

        // Kiểm tra tên rỗng
        if (name.isEmpty()) {
            request.setAttribute("errorMessage", "Tên tác giả không được để trống!");
            request.setAttribute("authorList", dao.getAllAuthors());
            request.getRequestDispatcher("/WEB-INF/authors.jsp").forward(request, response);
            return;
        }

        // Kiểm tra trùng tên
        if (dao.checkDuplicateAuthorname(name)) {
            request.setAttribute("errorMessage", "Tên tác giả đã tồn tại!");
            request.setAttribute("authorList", dao.getAllAuthors());
            request.getRequestDispatcher("/WEB-INF/authors.jsp").forward(request, response);
            return;
        }

        // Tạo mới
        Authors author = new Authors();
        author.setName(name);
        author.setBio(bio);

        boolean success = dao.createAuthor(author);
        if (success) {
            // Lưu thông báo vào session để hiển thị sau redirect
            request.getSession().setAttribute("successMessage", "Thêm tác giả thành công!");
            response.sendRedirect("authors"); // redirect để load lại danh sách
        } else {
            request.setAttribute("errorMessage", "Thêm tác giả thành công!");
            request.setAttribute("authorList", dao.getAllAuthors());
            request.getRequestDispatcher("/WEB-INF/authors.jsp").forward(request, response);
        }
    }

    private void deleteAuthor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        Authors author = new Authors();
        author.setId(id);

        AuthorsDAO dao = new AuthorsDAO();
        dao.deleteAuthor(id);

        response.sendRedirect("authors");
    }

    private void editAuthor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String bio = request.getParameter("bio");

        name = name.trim();
        bio = bio.trim();

        Authors author = new Authors();
        author.setId(id);
        author.setName(name);
        author.setBio(bio);

        AuthorsDAO dao = new AuthorsDAO();
        dao.editAuthor(author);

        response.sendRedirect("authors");
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
