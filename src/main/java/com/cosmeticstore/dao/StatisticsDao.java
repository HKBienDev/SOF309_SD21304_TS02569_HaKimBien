package com.cosmeticstore.dao;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cosmeticstore.utils.JdbcUtil;

import entity.Product;

public class StatisticsDao {
	public List<Product> getTopSellingProducts() {
	    List<Product> list = new ArrayList<>();
	    String sql = "{CALL usp_Top5BestSellingProducts(NULL, NULL)}";
	    
	    try (Connection conn = JdbcUtil.getConnection();
	         CallableStatement cs = conn.prepareCall(sql);
	         ResultSet rs = cs.executeQuery()) {
	        
	    	while (rs.next()) {
	    	    Product p = new Product();
	    	    
	    	    try { p.setProductID(rs.getInt("product_id")); } catch (Exception e) { p.setProductID(rs.getInt("productID")); }
	    	    try { p.setProductName(rs.getString("product_name")); } catch (Exception e) { p.setProductName(rs.getString("productName")); }
	    	    
	    	    // IN RA CONSOLE ĐỂ KIỂM TRA
	    	    String img = rs.getString("image");
	    	    System.out.println("DEBUG - Tên sản phẩm: " + p.getProductName() + " | Ảnh lấy từ DB: " + img);
	    	    p.setImage(img);
	    	    
	    	    // Gán giá gốc
	    	    BigDecimal priceVal = null;
	    	    try { 
	    	        priceVal = rs.getBigDecimal("price");
	    	        p.setPrice(priceVal); 
	    	    } catch (Exception e) {}
	    	    
	    	    // Gán giá giảm (discount_price) chuẩn kiểu BigDecimal
	    	    try { 
	    	        BigDecimal discVal = rs.getBigDecimal("discount_price");
	    	        if (discVal != null && discVal.compareTo(BigDecimal.ZERO) > 0) {
	    	            p.setDiscountPrice(discVal);
	    	        } else {
	    	            p.setDiscountPrice(priceVal);
	    	        }
	    	    } catch (Exception e) {
	    	        try {
	    	            BigDecimal discVal = rs.getBigDecimal("DiscountPrice");
	    	            if (discVal != null && discVal.compareTo(BigDecimal.ZERO) > 0) {
	    	                p.setDiscountPrice(discVal);
	    	            } else {
	    	                p.setDiscountPrice(priceVal);
	    	            }
	    	        } catch (Exception ex) {
	    	            p.setDiscountPrice(priceVal);
	    	        }
	    	    }
	    	    
	    	    list.add(p);
	    	}
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
}