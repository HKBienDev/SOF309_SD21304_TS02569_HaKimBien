package entity;

import java.math.BigDecimal;

public class Product {

    private int productID;
    private String productName;
    private BigDecimal price;
    private int stockQuantity;
    private int categoryID;
    private String image;
    private BigDecimal discountPrice;
    private String description;

    public Product() {
    }

    public Product(int productID, String productName, BigDecimal price,
            int stockQuantity, int categoryID, String image) {
        this.productID = productID;
        this.productName = productName;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.categoryID = categoryID;
        this.image = image;
    }

    public Product(int productID, String productName, BigDecimal price,
            int stockQuantity, int categoryID, String image, BigDecimal discountPrice, String description) {
        this.productID = productID;
        this.productName = productName;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.categoryID = categoryID;
        this.image = image;
        this.discountPrice = discountPrice;
        this.description = description;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public BigDecimal getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(BigDecimal discountPrice) {
        this.discountPrice = discountPrice;
    }

    // BỔ SUNG ĐẦY ĐỦ GETTER VÀ SETTER CHO DESCRIPTION TẠI ĐÂY
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}