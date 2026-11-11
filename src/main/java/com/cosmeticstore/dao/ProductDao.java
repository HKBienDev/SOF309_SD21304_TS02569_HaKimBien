package com.cosmeticstore.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.cosmeticstore.utils.JdbcUtil;
import entity.Product;

public class ProductDao implements CrudDao<Product, Integer> {

	private static final String INSERT_SQL = "INSERT INTO Product(ProductName, Price, DiscountPrice, StockQuantity, CategoryID, Image, Description) VALUES (?, ?, ?, ?, ?, ?, ?)";
	private static final String UPDATE_SQL = "UPDATE Product SET ProductName=?, Price=?, DiscountPrice=?, StockQuantity=?, CategoryID=?, Image=?, Description=? WHERE ProductID=?";
	private static final String DELETE_SQL = "DELETE FROM Product WHERE ProductID=?";
	private static final String SELECT_ALL_SQL = "SELECT * FROM Product";
	private static final String SELECT_BY_ID_SQL = "SELECT * FROM Product WHERE ProductID=?";
	private static final String SELECT_BY_CATEGORY_SQL = "SELECT * FROM Product WHERE CategoryID=?";
	private static final String SELECT_BY_NAME_SQL = "SELECT * FROM Product WHERE ProductName LIKE ?";

	@Override
	public int create(Product entity) {
		try {
			return JdbcUtil.executeUpdate(INSERT_SQL, entity.getProductName(), entity.getPrice(),
					entity.getDiscountPrice(), entity.getStockQuantity(), entity.getCategoryID(), entity.getImage(), entity.getDescription());
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int update(Product entity) {
		try {
			return JdbcUtil.executeUpdate(UPDATE_SQL, entity.getProductName(), entity.getPrice(),
					entity.getDiscountPrice(), entity.getStockQuantity(), entity.getCategoryID(), entity.getImage(), entity.getDescription(), entity.getProductID());
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int delete(Product entity) {
		try {
			return JdbcUtil.executeUpdate(DELETE_SQL, entity.getProductID());
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public List<Product> findAll() {
		return findBySql(SELECT_ALL_SQL);
	}

	@Override
	public Product findById(Integer id) {
		List<Product> list = findBySql(SELECT_BY_ID_SQL, id);
		if (list.isEmpty()) {
			return null;
		}
		return list.get(0);
	}

	@Override
	public List<Product> findBySql(String sql, Object... args) {
		List<Product> list = new ArrayList<>();
		ResultSet rs = null;
		Statement st = null;
		Connection con = null;

		try {
			rs = JdbcUtil.executeQuery(sql, args);
			while (rs.next()) {
				Product p = new Product();
				p.setProductID(rs.getInt("ProductID"));
				p.setProductName(rs.getString("ProductName"));
				p.setPrice(rs.getBigDecimal("Price"));
				
				try {
					p.setDiscountPrice(rs.getBigDecimal("DiscountPrice"));
				} catch (Exception e) {
					p.setDiscountPrice(null);
				}

				p.setStockQuantity(rs.getInt("StockQuantity"));
				p.setCategoryID(rs.getInt("CategoryID"));

				try {
					p.setImage(rs.getString("Image"));
				} catch (Exception e) {
					p.setImage(null);
				}

				try {
					p.setDescription(rs.getString("Description"));
				} catch (Exception e) {
					p.setDescription(null);
				}

				list.add(p);
			}
			st = rs.getStatement();
			con = st.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if (rs != null) rs.close(); } catch (Exception e) {}
			try { if (st != null) st.close(); } catch (Exception e) {}
			try { if (con != null) con.close(); } catch (Exception e) {}
		}
		return list;
	}

	public List<Product> findByCategoryId(int categoryId) {
		List<Product> list = new ArrayList<>();
		try {
			ResultSet rs = JdbcUtil.executeQuery(SELECT_BY_CATEGORY_SQL, categoryId);
			while (rs.next()) {
				Product p = new Product();
				p.setProductID(rs.getInt("ProductID"));
				p.setProductName(rs.getString("ProductName"));
				p.setPrice(rs.getBigDecimal("Price"));
				
				try {
					p.setDiscountPrice(rs.getBigDecimal("DiscountPrice"));
				} catch (Exception e) {
					p.setDiscountPrice(null);
				}

				p.setStockQuantity(rs.getInt("StockQuantity"));
				p.setCategoryID(rs.getInt("CategoryID"));
				p.setImage(rs.getString("Image"));
				
				try {
					p.setDescription(rs.getString("Description"));
				} catch (Exception e) {
					p.setDescription(null);
				}

				list.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Product> searchByName(String keyword) {
		return findBySql(SELECT_BY_NAME_SQL, "%" + keyword + "%");
	}

	public List<Product> getDiscountedProducts() {
		List<Product> list = new ArrayList<>();
		String sql = "{CALL usp_GetDiscountedProducts()}";
		
		try (Connection conn = JdbcUtil.getConnection();
			 CallableStatement cs = conn.prepareCall(sql);
			 ResultSet rs = cs.executeQuery()) {
			
			while (rs.next()) {
				Product p = new Product();
				try { p.setProductID(rs.getInt("product_id")); } catch (Exception e) { p.setProductID(rs.getInt("ProductID")); }
				try { p.setProductName(rs.getString("product_name")); } catch (Exception e) { p.setProductName(rs.getString("ProductName")); }
				try { p.setPrice(rs.getBigDecimal("price")); } catch (Exception e) { p.setPrice(rs.getBigDecimal("Price")); }
				
				try {
					p.setDiscountPrice(rs.getBigDecimal("discount_price"));
				} catch (Exception e) {
					try { p.setDiscountPrice(rs.getBigDecimal("DiscountPrice")); } catch (Exception ex) { p.setDiscountPrice(null); }
				}
				
				try { p.setImage(rs.getString("image")); } catch (Exception e) { p.setImage(rs.getString("Image")); }
				
				String desc = null;
				try { desc = rs.getString("description"); } catch (Exception e1) {
					try { desc = rs.getString("Description"); } catch (Exception e2) { }
				}
				p.setDescription(desc);
				
				list.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Product> getBestSellerProducts() {
		List<Product> list = new ArrayList<>();
		String sql = "{CALL usp_Top5BestSellingProducts()}";
		
		try (Connection conn = JdbcUtil.getConnection();
			 CallableStatement cs = conn.prepareCall(sql);
			 ResultSet rs = cs.executeQuery()) {
			
			while (rs.next()) {
				Product p = new Product();
				try { p.setProductID(rs.getInt("product_id")); } catch (Exception e1) { 
					try { p.setProductID(rs.getInt("ProductID")); } catch (Exception e2) { }
				}
				
				try { p.setProductName(rs.getString("product_name")); } catch (Exception e1) { 
					try { p.setProductName(rs.getString("ProductName")); } catch (Exception e2) { }
				}
				
				try { p.setPrice(rs.getBigDecimal("price")); } catch (Exception e1) { 
					try { p.setPrice(rs.getBigDecimal("Price")); } catch (Exception e2) { }
				}
				
				try {
					p.setDiscountPrice(rs.getBigDecimal("discount_price"));
				} catch (Exception e1) {
					try { 
						p.setDiscountPrice(rs.getBigDecimal("DiscountPrice")); 
					} catch (Exception e2) { 
						p.setDiscountPrice(null);
					}
				}
				
				try { p.setImage(rs.getString("image")); } catch (Exception e1) { 
					try { p.setImage(rs.getString("Image")); } catch (Exception e2) { }
				}
				
				// Lấy mô tả an toàn cho cả chữ thường lẫn chữ hoa từ Stored Procedure
				String desc = null;
				try { 
					desc = rs.getString("description"); 
				} catch (Exception e1) {
					try { 
						desc = rs.getString("Description"); 
					} catch (Exception e2) { }
				}
				p.setDescription(desc);
				
				list.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}