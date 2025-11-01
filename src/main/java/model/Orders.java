/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author ACER
 */
public class Orders {

    private int id;
    private String name;
    private String phone;
    private Date datebuy;
    private String address;
    private double total;
    private Date created_at;
    private Date updated_at;
    private String status;

    public Orders(int id, String name, String phone, String address, double total, Date created_at, Date updated_at, String status) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.total = total;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.status = status;
    }

    public Orders() {
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public Date getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Date updated_at) {
        this.updated_at = updated_at;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Orders{" + "id=" + id + ", name=" + name + ", phone=" + phone + ", address=" + address + ", total=" + total + ", created_at=" + created_at + ", updated_at=" + updated_at + ", status=" + status + '}';
    }

}
