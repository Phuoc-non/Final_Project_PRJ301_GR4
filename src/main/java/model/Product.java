
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Date;
/**
 *
 * @author Asus
 */



public class Product {
    
    
    
     private String sku;
    private String bookName;
    private String description;
    private int quantity;
    private float price;
    private boolean status;
    private int categoryId;
    private int publisherId;
    private String language;
    
    //bảng product
    private String sku_product; //thuộc tính list,create
    private String name_product; //thuộc tính list,create
    private double price_product;//thuộc tính list,create
    private String description_product; //thuộc tính create
    private String img; //list,create
    private Date created_product;//thuộc tính list,create
    
    //bảng productDetail
    private int pages; //thuộc tính create
    
    //bảng category
    private String category_name;// category name nếu JOIN,thuộc tính list,create
    
    //bảng author
    private String author_name;//thuộc tính list,create
    
    //bảng orderDetails
    private int quantity_orderDetail; //này là cái sum số lượng đã bán của bảng quantity,thuộc tính list


    public Product() {
    }


    public Product(String bookName, int quantity, float price, String img) {
        this.bookName = bookName;
        this.quantity = quantity;
        this.price = price;
        this.img = img;
    }

    public Product(String description, int quantity, String img,float price,String sku) {
        this.description = description;
        this.quantity = quantity;
        this.img = img;
        this.price=price;
        this.sku=sku;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }
    
    
    public Product(String sku_product, String name_product, double price_product, String description_product, String img, Date created_product, int pages, String category_name, String author_name, int quantity_orderDetail) {
        this.sku_product = sku_product;
        this.name_product = name_product;
        this.price_product = price_product;
        this.description_product = description_product;
        this.img = img;
        this.created_product = created_product;
        this.pages = pages;
        this.category_name = category_name;
        this.author_name = author_name;
        this.quantity_orderDetail = quantity_orderDetail;
    }

    public String getSku_product() {
        return sku_product;
    }

    public void setSku_product(String sku_product) {
        this.sku_product = sku_product;
    }

    public String getName_product() {
        return name_product;
    }

    public void setName_product(String name_product) {
        this.name_product = name_product;
    }

    public double getPrice_product() {
        return price_product;
    }

    public void setPrice_product(double price_product) {
        this.price_product = price_product;
    }

    public String getDescription_product() {
        return description_product;
    }

    public void setDescription_product(String description_product) {
        this.description_product = description_product;

    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }


    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getPublisherId() {
        return publisherId;
    }

    public void setPublisherId(int publisherId) {
        this.publisherId = publisherId;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }
    
    public Date getCreated_product() {
        return created_product;
    }

    public void setCreated_product(Date created_product) {
        this.created_product = created_product;
    }

    public int getPages() {
        return pages;
    }

    public void setPages(int pages) {
        this.pages = pages;
    }

    public String getCategory_name() {
        return category_name;
    }

    public void setCategory_name(String category_name) {
        this.category_name = category_name;
    }

    public String getAuthor_name() {
        return author_name;
    }

    public void setAuthor_name(String author_name) {
        this.author_name = author_name;
    }

    public int getQuantity_orderDetail() {
        return quantity_orderDetail;
    }

    public void setQuantity_orderDetail(int quantity_orderDetail) {
        this.quantity_orderDetail = quantity_orderDetail;
    }

    @Override
    public String toString() {
        return "Product{"  + "quantity=" + quantity + "sku_product=" + sku_product + ", name_product=" + name_product + ", price_product=" + price_product + ", description_product=" + description_product + ", img=" + img + ", created_product=" + created_product + ", pages=" + pages + ", category_name=" + category_name + ", author_name=" + author_name + ", quantity_orderDetail=" + quantity_orderDetail + '}';
    }



    
}
