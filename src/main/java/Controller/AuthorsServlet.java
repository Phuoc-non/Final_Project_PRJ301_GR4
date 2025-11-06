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

    private boolean isValidAuthorName(String name) {
        if (name == null) {
            return false;
        }
        return name.matches("^[a-zA-Z\\-\\s]+$");
    }

    private void createAuthor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String bio = request.getParameter("bio");

        // Xử lý null hoặc rỗng
        if (name == null || name.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessage", "Tên tác giả không được để trống!");
            response.sendRedirect("authors");
            return;
        }

        name = name.trim();
        if (!isValidAuthorName(name)) {
            request.getSession().setAttribute("errorMessage",
                    "Tên tác giả chỉ được chứa chữ cái!");
            response.sendRedirect("authors");
            return;
        }

        bio = (bio == null) ? "" : bio.trim();

        AuthorsDAO dao = new AuthorsDAO();

        // Kiểm tra trùng tên
        if (dao.checkDuplicateAuthorname(name, 0)) {
            request.getSession().setAttribute("errorMessage", "Tên tác giả đã tồn tại!");
            response.sendRedirect("authors");
            return;
        }

        // Tạo tác giả
        Authors author = new Authors();
        author.setName(name);
        author.setBio(bio);

        boolean success = false;
        try {
            success = dao.createAuthor(author);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (success) {
            request.getSession().setAttribute("successMessage", "Thêm tác giả thành công!");
        } else {
            request.getSession().setAttribute("errorMessage", "Thêm tác giả thất bại! Vui lòng thử lại.");
        }

        response.sendRedirect("authors"); // Luôn redirect để reload danh sách + giữ thông báo
    }

    private void deleteAuthor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessage", "ID tác giả không hợp lệ!");
            response.sendRedirect("authors");
            return;
        }

        int id = Integer.parseInt(idParam);

        AuthorsDAO dao = new AuthorsDAO();
        boolean success = false;

        try {
            dao.deleteAuthor(id);
            success = true; // Giả sử luôn xóa thành công (vì không có FK ràng buộc)
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (success) {
            request.getSession().setAttribute("successMessage", "Xóa tác giả thành công!");
        } else {
            request.getSession().setAttribute("errorMessage", "Xóa tác giả thất bại!");
        }

        response.sendRedirect("authors");

    }

    private void editAuthor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String idParam = request.getParameter("id");
        String name = request.getParameter("name");
        String bio = request.getParameter("bio");

        // Kiểm tra dữ liệu đầu vào
        if (idParam == null || idParam.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessage", "ID tác giả không hợp lệ!");
            response.sendRedirect("authors");
            return;
        }

        int id = Integer.parseInt(idParam);
        if (name == null || name.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessage", "Tên tác giả không được để trống!");
            response.sendRedirect("authors");
            return;
        }

        name = name.trim();
        if (!isValidAuthorName(name)) {
            request.getSession().setAttribute("errorMessage", "Tên tác giả chỉ được chứa chữ cái!");
            response.sendRedirect("authors");
            return;
        }

        bio = (bio == null) ? "" : bio.trim();

        AuthorsDAO dao = new AuthorsDAO();

        // Kiểm tra trùng tên (nhưng cho phép giữ nguyên tên cũ của chính nó)
        if (dao.checkDuplicateAuthorname(name, id)) {
            request.getSession().setAttribute("errorMessage", "Tên tác giả đã tồn tại!");
            response.sendRedirect("authors");
            return;
        }

        // Cập nhật
        Authors author = new Authors();
        author.setId(id);
        author.setName(name);
        author.setBio(bio);

        boolean success = false;
        try {
            dao.editAuthor(author);
            success = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (success) {
            request.getSession().setAttribute("successMessage", "Cập nhật tác giả thành công!");
        } else {
            request.getSession().setAttribute("errorMessage", "Cập nhật thất bại! Vui lòng thử lại.");
        }

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
