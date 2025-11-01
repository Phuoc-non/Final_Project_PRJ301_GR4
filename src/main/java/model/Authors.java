/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;


public class Authors {
    private int id;
    private String name;
    private String bio;
    private Date created_at;
    private Date updated_at;
    private int bookcount; 

    
    public Authors() {}

       public Authors(String name, String bio) {
        this.name = name;
        this.bio = bio;
        
    }
    public Authors(int id, String name, String bio, Date created_at, Date updated_at, int bookcount) {
        this.id = id;
        this.name = name;
        this.bio = bio;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.bookcount = bookcount;
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

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
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

    public int getBookcount() {
        return bookcount;
    }

    public void setBookcount(int bookcount) {
        this.bookcount = bookcount;
    }

    

}

