/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author DELL
 */
import java.util.List;
import model.Cart;
import model.CartItem;
import model.ProductDetail;
import model.Registration;

public class TestLogin {

    public static void main(String[] args) {
//        RegistrationDAO dao = new RegistrationDAO();
//
//        String username = "administrator";
//        String password = "984afce66eeeecb03a1d14201a695683";
//
//        Registration re = dao.login(username, password);
//
//        if (re != null) {
//            System.out.println("Login successful!");
//            System.out.println("Username: " + re.getUsername());
//            System.out.println("Password: " + re.getPassword());
//            System.out.println("IsAdmin: " + re.isIsAdmin());
//        } else {
//            System.out.println("Login fail!");
//        }
       CartDAO cd= new CartDAO();
       
//        
//        Cart c= cd.getCart("duyduc");
//        CartItem ci=cd.getCartItem(2, "BOOK01");
//        int n=cd.createCartItem(2, "BOOK02", 4);
//        int up=cd.updateCartItem(2, "BOOK02", 20);
//        List<CartItem> l= cd.cartAll(1);

           int n=cd.deleteCartItem(1, "BOOK01");
           ProductDetailDao pd= new ProductDetailDao();
           ProductDetail p=pd.getById(1);
        if (p!=null){

         System.out.println("insert successfull");
            System.out.println(p.toString());
        }
        else {
        System.out.println("AN CUC");
//             System.out.println(cart1.getCartId());
        }
                }
}
