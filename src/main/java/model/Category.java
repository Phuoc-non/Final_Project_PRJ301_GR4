/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Category {
   private int id;
   private String name;
   private int quantity;
   private String dayCreate;
   private String dayUpdate;

    public Category() {
    }

    public Category(int id, String name, int quantity/*, String dayCreate, String dayUpdate*/) {
        this.id = id;
        this.name = name;
        this.quantity = quantity;
//        this.dayCreate = dayCreate;
//        this.dayUpdate = dayUpdate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDayCreate() {
        return dayCreate;
    }

    public void setDayCreate(String dayCreate) {
        this.dayCreate = dayCreate;
    }

    public String getDayUpdate() {
        return dayUpdate;
    }

    public void setDayUpdate(String dayUpdate) {
        this.dayUpdate = dayUpdate;
    }
    
   
   
}
