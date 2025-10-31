/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Asus
 */
public class CartItem {
    private int id;
    private int cartId;
    private String sku;
    private int quantity;
    private Product product;
    
    
    public CartItem() {
    }

    public CartItem(int id, int cartId, String sku, int quantity) {
        this.id = id;
        this.cartId = cartId;
        this.sku = sku;
        this.quantity = quantity;
        
    }

    public CartItem(int cartId, String sku, int quantity, Product product) {
        this.cartId = cartId;
        this.sku = sku;
        this.quantity = quantity;
        this.product = product;
        
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    
}
