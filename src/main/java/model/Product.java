package model;

import java.sql.Date;

public class Product {
    
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
        return "Product{" + "sku_product=" + sku_product + ", name_product=" + name_product + ", price_product=" + price_product + ", description_product=" + description_product + ", img=" + img + ", created_product=" + created_product + ", pages=" + pages + ", category_name=" + category_name + ", author_name=" + author_name + ", quantity_orderDetail=" + quantity_orderDetail + '}';
    }


    
}
