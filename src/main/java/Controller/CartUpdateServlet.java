/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.CartItem;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "CartUpdateServlet", urlPatterns = {"/cartupdate"})
public class CartUpdateServlet extends HttpServlet {

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
            out.println("<title>Servlet CartUpdateServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartUpdateServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        // Nhận dữ liệu JSON
        String json = request.getReader().lines().reduce("", (acc, line) -> acc + line);

        // Parse JSON
        com.google.gson.Gson gson = new com.google.gson.Gson();
        java.lang.reflect.Type listType = new com.google.gson.reflect.TypeToken<java.util.List<CartItemUpdate>>(){}.getType();
        List<CartItemUpdate> updates = gson.fromJson(json, listType);

        // Lấy giỏ hàng từ session
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("listCartItem");

        // Cập nhật quantity
        if (cart != null) {
            for (CartItemUpdate upd : updates) {
                for (CartItem item : cart) {
                    if (item.getSku().equals(upd.getSku())) {
                        item.setQuantity(upd.getQuantity());
                    }
                }
            }
            session.setAttribute("listCartItem", cart);
        }

        response.getWriter().write("updated");
    }

    // Lớp phụ để parse JSON
    private static class CartItemUpdate {
        private String sku;
        private int quantity;
        public String getSku() { return sku; }
        public int getQuantity() { return quantity; }
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
