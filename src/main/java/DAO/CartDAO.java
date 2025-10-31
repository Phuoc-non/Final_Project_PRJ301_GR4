/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.CartItem;
import model.Product;

/**
 *
 * @author Asus
 */
public class CartDAO extends DBContext {

    /**
     *
     * @param username
     * @return
     */
    public Cart getCart(String username) {
        Cart cart = null;
        try {

            Date createdDate = null;
            Date upadatedDat = null;

            String query = "select * from Cart where username= ?";
            PreparedStatement statement = this.getConnection().prepareStatement(query);
            statement.setString(1, username);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                createdDate = rs.getDate("created_date");
                upadatedDat = rs.getDate("updated_date");
                cart = new Cart(id, username, createdDate, upadatedDat);
            }
            return cart;
        } catch (SQLException ex) {
            System.getLogger(CartDAO.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return null;
    }

    /**
     *
     * @param username
     */
    public void creatCart(String username) {

        try {
            String query = "INSERT INTO Cart (username)\n"
                    + "VALUES (?);";
            PreparedStatement statement = this.getConnection().prepareStatement(query);
            statement.setString(1, username);

            statement.executeUpdate();
        } catch (SQLException ex) {
            System.getLogger(CartDAO.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }

    }

    /**
     *
     * @param id
     * @param sku
     * @param quantity
     * @return
     */
    public int createCartItem(int id, String sku, int quantity) {
        try {
            String query = "INSERT INTO CartItem (cart_id, product_sku, quantity)\n"
                    + "VALUES \n"
                    + "    (?, ?, ?);";
            PreparedStatement statement = this.getConnection().prepareStatement(query);
            statement.setInt(1, id);
            statement.setString(2, sku);
            statement.setInt(3, quantity);
            return statement.executeUpdate();
        } catch (SQLException ex) {
            System.getLogger(CartDAO.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return 0;
    }

    /**
     *
     * @param cartId
     * @param sku
     * @return
     */
    public CartItem getCartItem(int cartId, String sku) {
        CartItem cartItem = null;
        try {
            String query = "select * from CartItem "
                    + "where cart_id=? and product_sku=?";
            PreparedStatement statement = this.getConnection().prepareStatement(query);
            statement.setInt(1, cartId);
            statement.setString(2, sku);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                int quantity = rs.getInt("quantity");
                int id = rs.getInt("id");
                cartItem = new CartItem(id, cartId, sku, quantity);
            }
            return cartItem;
        } catch (SQLException ex) {
            System.getLogger(CartDAO.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return null;
    }

    /**
     *
     * @param cartId
     * @param sku
     * @param quantity
     * @return
     */
    public int updateCartItem(int cartId, String sku, int quantity) {
        try {
            String query = "update CartItem\n"
                    + "set quantity=?\n"
                    + " where cart_id=? and product_sku=?";
            PreparedStatement statement = this.getConnection().prepareStatement(query);
            statement.setInt(1, quantity);
            statement.setInt(2, cartId);
            statement.setString(3, sku);
            return statement.executeUpdate();
        } catch (SQLException ex) {
            System.getLogger(CartDAO.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return 0;
    }

    public List<CartItem> cartAll(int cartId) {
        List<CartItem> listCartItem = new ArrayList<>();
        Product product=null;
        try {
            String query = "select c.cart_id,c.product_sku, p.name,p.img, p.price,c.quantity as cartQuan,p.quantity as PQuan\n"
                    + "from Product p join CartItem c\n"
                    + "on p.sku=c.product_sku\n"
                    + "where c.cart_id=?";

            PreparedStatement statement = this.getConnection().prepareStatement(query);
            statement.setInt(1, cartId);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                String bookName=rs.getString("name");
                String img=rs.getString("img");
                String sku = rs.getString("product_sku");
                int cartQuantity = rs.getInt("CartQuan");
                int ProductQuantity = rs.getInt("PQuan");
                int price=rs.getInt("price");
                
                product=new Product(bookName, ProductQuantity, price, img);
                listCartItem.add(new CartItem(cartId, sku, cartQuantity, product));
            }
            return listCartItem;
        } catch (SQLException ex) {
            System.getLogger(CartDAO.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }

        return null;
    }
    public int deleteCartItem(int cartId, String sku){
        try {
            String query="delete CartItem where cart_id=? and product_sku=?";
            PreparedStatement statement = this.getConnection().prepareStatement(query);
            statement.setInt(1, cartId);
            statement.setString(2, sku);
            
            return statement.executeUpdate();
        } catch (SQLException ex) {
            System.getLogger(CartDAO.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return 0;
    }
    public int updateCart(String name){
        try {
            String query="update cart set updated_date=(select GETDATE()) where username=?";
            PreparedStatement statement = this.getConnection().prepareStatement(query);
            statement.setString(1, name);
            return statement.executeUpdate();
        } catch (SQLException ex) {
            System.getLogger(CartDAO.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return 0;
    }
}
