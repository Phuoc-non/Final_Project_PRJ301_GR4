package model;

import java.util.Date;

public class Order {
    private int id;
    private Date dateBuy;
    private int total;
    private String name;
    private String phone;
    private String address;

    // 🔗 Khóa ngoại (Foreign Key) — quan hệ đến Registration
    private Registration registration;

    public Order() {}

    public Order(int id, Date dateBuy, int total,
                 String name, String phone, String address, Registration registration) {
        this.id = id;
        this.dateBuy = dateBuy;
        this.total = total;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.registration = registration;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Date getDateBuy() { return dateBuy; }
    public void setDateBuy(Date dateBuy) { this.dateBuy = dateBuy; }

    public int getTotal() { return total; }
    public void setTotal(int total) { this.total = total; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public Registration getRegistration() { return registration; }
    public void setRegistration(Registration registration) { this.registration = registration; }
 
}
