/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author DELL
 */
import model.Registration;

public class TestLogin {

    public static void main(String[] args) {
        RegistrationDAO dao = new RegistrationDAO();

        String username = "administrator";
        String password = "984afce66eeeecb03a1d14201a695683";

        Registration re = dao.login(username, password);

        if (re != null) {
            System.out.println("Login successful!");
            System.out.println("Username: " + re.getUsername());
            System.out.println("Password: " + re.getPassword());
            System.out.println("IsAdmin: " + re.isIsAdmin());
        } else {
            System.out.println("Login fail!");
        }
    }
}
