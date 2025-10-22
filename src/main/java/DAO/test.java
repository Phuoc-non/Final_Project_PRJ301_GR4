/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.List;
import model.ProductDetail;
import model.UserReview;

/**
 *
 * @author Asus
 */
public class test {
    public static void main(String[] args) {
        // TODO code application logic here
         ReviewDao dao= new ReviewDao();
         List<UserReview> b= dao.getById(1);
        for (UserReview userReview : b) {
            System.out.println(userReview.getDate()+"\n");
        }
    }
}
