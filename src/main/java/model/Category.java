/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Admin
 */
public class Category {

    private int id;
    private String name;
    private int quantity;
    private Date dayCreate;
    private Date dayUpdate;

    public Category() {
    }

    public Category(int id, String name, int quantity, Date dayCreate, Date dayUpdate) {
        this.id = id;
        this.name = name;
        this.quantity = quantity;
        this.dayCreate = dayCreate;
        this.dayUpdate = dayUpdate;
       
      
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

    public Date getDayCreate() {
        return dayCreate;
    }

    public void setDayCreate(Date dayCreate) {
        this.dayCreate = dayCreate;
    }

    public Date getDayUpdate() {
        return dayUpdate;
    }

    public void setDayUpdate(Date dayUpdate) {
        this.dayUpdate = dayUpdate;
    }

  
}



