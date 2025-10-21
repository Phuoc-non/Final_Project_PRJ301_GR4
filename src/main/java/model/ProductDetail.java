/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Asus
 */
public class ProductDetail {
    private int id;
    private String price;
    private String author;
    private String BookName;
    private String format;
    private int pages;
    private String dimensions;
    private String publication_date;
    private String img;
    private String description;
    private String caterogy;
    public ProductDetail() {
    }

    public ProductDetail(int id, String price, String author, String BookName, String format, int pages, String dimensions, String publication_date, String img, String description, String caterogy) {
        this.id = id;
        this.price = price;
        this.author = author;
        this.BookName = BookName;
        this.format = format;
        this.pages = pages;
        this.dimensions = dimensions;
        this.publication_date = publication_date;
        this.img=img;
        this.description=description;
        this.caterogy=caterogy;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getBookName() {
        return BookName;
    }

    public void setBookName(String BookName) {
        this.BookName = BookName;
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

    public String getPublication_date() {
        return publication_date;
    }

    public void setPublication_date(String publication_date) {
        this.publication_date = publication_date;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCaterogy() {
        return caterogy;
    }

    public void setCaterogy(String caterogy) {
        this.caterogy = caterogy;
    }
    

    @Override
    public String toString() {
        return "ProductDetail{" + "id=" + id + ", price=" + price + ", author=" + author + ", BookName=" + BookName + ", format=" + format + ", pages=" + pages + ", dimensions=" + dimensions + ", publication_date=" + publication_date + ", img=" + img + ", description=" + description + '}';
    }
    
   
}

    

    