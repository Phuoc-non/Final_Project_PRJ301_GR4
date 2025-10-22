/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.List;
import model.Authors;

/**
 *
 * @author ACER
 */
public class test {
    public static void main(String[] args) {
        AuthorsDAO dao = new AuthorsDAO();
        List<Authors> authorList = dao.getAllAuthors();
        for (Authors o : authorList) {
            System.out.println(o.getBio());
        }
    }
    
}
