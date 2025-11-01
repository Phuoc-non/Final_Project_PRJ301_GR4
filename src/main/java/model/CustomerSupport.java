/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author ASUS
 */
public class CustomerSupport {

    private int id;
    private int orderId;
    private String username;
    private String reason;
    private double totalRefund;
    private String description;
    private String email;
    private String status; // Pending | Approved | Rejected
    private Timestamp requestDate;

    // Thông tin bổ sung từ bảng khác
    private Registration registration;
    private Order order;

    public CustomerSupport() {
    }

    public CustomerSupport(int id, int orderId, String username, String reason, double totalRefund, 
                          String description, String email, String status, Timestamp requestDate) {
        this.id = id;
        this.orderId = orderId;
        this.username = username;
        this.reason = reason;
        this.totalRefund = totalRefund;
        this.description = description;
        this.email = email;
        this.status = status;
        this.requestDate = requestDate;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public double getTotalRefund() {
        return totalRefund;
    }

    public void setTotalRefund(double totalRefund) {
        this.totalRefund = totalRefund;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(Timestamp requestDate) {
        this.requestDate = requestDate;
    }

    public Registration getRegistration() {
        return registration;
    }

    public void setRegistration(Registration registration) {
        this.registration = registration;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    @Override
    public String toString() {
        return "CustomerSupport{" + "id=" + id + ", orderId=" + orderId + ", username=" + username 
                + ", reason=" + reason + ", totalRefund=" + totalRefund + ", description=" + description 
                + ", email=" + email + ", status=" + status + ", requestDate=" + requestDate + '}';
    }
}
