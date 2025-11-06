/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Promotion {
    private int id;
    private String code;
    private int discount;
    private Date startDay;
    private Date endDay;
    private String description;
    private int status;
    private int minOrderValue;


    public Promotion() {
    }

    public Promotion(String code, int discount, int minOrderValue) {
        this.code = code;
        this.discount = discount;
        this.minOrderValue = minOrderValue;
    }

    
    public Promotion(int id,String code, int discount, Date startDay, Date endDay, String description, int status,int minOrderValue ) {
        this.id = id;
        this.code = code;
        this.discount = discount;
        this.startDay = startDay;
        this.endDay = endDay;
        this.description = description;
        this.status = status;
        this.minOrderValue = minOrderValue;
      
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public Date getStartDay() {
        return startDay;
    }

    public void setStartDay(Date startDay) {
        this.startDay = startDay;
    }

    public Date getEndDay() {
        return endDay;
    }

    public void setEndDay(Date endDay) {
        this.endDay = endDay;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getMinOrderValue() {
        return minOrderValue;
    }

    public void setMinOrderValue(int minOrderValue) {
        this.minOrderValue = minOrderValue;
    }
    
    
    
}