/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import model.ProductDetail;

/**
 *
 * @author Asus
 */
public class test {
    public static void main(String[] args) {
        // TODO code application logic here
         ProductDetailDao a= new ProductDetailDao();
         ProductDetail b= a.getById(1);
         System.out.println(b.toString());
    }
}
