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
public class ProductDetail {

    private int id;
   
    private String bookName;
    private String format;
    private int pages;
    private String dimensions;
    private Date publicationDate;
    private String language;
    private Authors author;
    private Product product;
    private Category category;
    
    public ProductDetail() {
    }

    public ProductDetail(int id, String bookName, String format, int pages, String dimensions, Date publicationDate,String language, Authors author, Product product, Category category) {
        this.id = id;    
        this.bookName = bookName;
        this.format = format;
        this.pages = pages;
        this.dimensions = dimensions;
        this.publicationDate = publicationDate;
        this.language=language;
        this.author = author;
        this.product = product;
        this.category = category;
    }

    public ProductDetail(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }



    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }

    public int getPages() {
        return pages;
    }

    public void setPages(int pages) {
        this.pages = pages;
    }

    public String getDimensions() {
        return dimensions;
    }

    public void setDimensions(String dimensions) {
        this.dimensions = dimensions;
    }

    public Date getPublicationDate() {
        return publicationDate;
    }

    public void setPublicationDate(Date publicationDate) {
        this.publicationDate = publicationDate;
    }

    public Authors getAuthor() {
        return author;
    }

    public void setAuthor(Authors author) {
        this.author = author;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    @Override
    public String toString() {
        return "ProductDetail{" + "id=" + id + ", bookName=" + bookName + ", format=" + format + ", pages=" + pages + ", dimensions=" + dimensions + ", publicationDate=" + publicationDate + ", language=" + language + ", author=" + author + ", product=" + product + ", category=" + category + '}';
    }

    
}