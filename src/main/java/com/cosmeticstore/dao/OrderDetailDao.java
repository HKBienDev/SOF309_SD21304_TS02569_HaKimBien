package com.cosmeticstore.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cosmeticstore.utils.JdbcUtil;
import entity.OrderDetail;

public class OrderDetailDao implements CrudDao<OrderDetail, Integer> {

	@Override
	public int create(OrderDetail entity) {
		String sql = "INSERT INTO OrderDetail(OrderID, ProductID, Quantity, UnitPrice, Status) VALUES(?,?,?,?,?)";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getOrderID(), entity.getProductID(), entity.getQuantity(),
					entity.getUnitPrice(), entity.getStatus());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int update(OrderDetail entity) {
		String sql = "UPDATE OrderDetail SET Quantity=?, UnitPrice=?, Status=? WHERE OrderID=? AND ProductID=?";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getQuantity(), entity.getUnitPrice(), entity.getStatus(), entity.getOrderID(),
					entity.getProductID());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int delete(OrderDetail entity) {
		String sql = "DELETE FROM OrderDetail WHERE OrderID=? AND ProductID=?";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getOrderID(), entity.getProductID());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public List<OrderDetail> findAll() {
		return findBySql("SELECT * FROM OrderDetail");
	}

	@Override
	public OrderDetail findById(Integer id) {
		List<OrderDetail> list = findBySql("SELECT * FROM OrderDetail WHERE OrderID=?", id);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public List<OrderDetail> findBySql(String sql, Object... value) {
		List<OrderDetail> list = new ArrayList<>();
		try {
			ResultSet rs = JdbcUtil.executeQuery(sql, value);

			while (rs != null && rs.next()) {
				OrderDetail od = new OrderDetail();

				od.setOrderID(rs.getInt("OrderID"));
				od.setProductID(rs.getInt("ProductID"));
				od.setQuantity(rs.getInt("Quantity"));
				od.setUnitPrice(rs.getDouble("UnitPrice"));

				try {
					String status = rs.getString("Status");
					od.setStatus(status != null ? status : "Pending");
				} catch (Exception ex) {
					od.setStatus("Pending");
				}

				list.add(od);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public int updateStatus(int orderID, int productID, String status) {
		String sql = "UPDATE OrderDetail SET Status=? WHERE OrderID=? AND ProductID=?";
		try {
			return JdbcUtil.executeUpdate(sql, status, orderID, productID);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public List<OrderDetail> findByOrderID(int orderID) {
	    // JOIN 3 bảng: OrderDetail, Product, [Order] và Customer (hoặc Users)
	    String sql = "SELECT od.*, p.ProductName, c.CustomerName " +
	                 "FROM [OrderDetail] od " +
	                 "JOIN [Product] p ON od.ProductID = p.ProductID " +
	                 "JOIN [Order] o ON od.OrderID = o.OrderID " +
	                 "LEFT JOIN [Customer] c ON o.CustomerID = c.CustomerID " +
	                 "WHERE od.OrderID = ?";
	                 
	    List<OrderDetail> list = new ArrayList<>();
	    try (ResultSet rs = JdbcUtil.executeQuery(sql, orderID)) {
	        while (rs.next()) {
	            OrderDetail detail = new OrderDetail();
	            detail.setOrderID(rs.getInt("OrderID"));
	            detail.setProductID(rs.getInt("ProductID"));
	            detail.setQuantity(rs.getInt("Quantity"));
	            detail.setUnitPrice(rs.getDouble("UnitPrice"));
	            
	            // Gán thêm Tên sản phẩm & Tên khách hàng
	            detail.setProductName(rs.getString("ProductName"));
	            detail.setCustomerName(rs.getString("CustomerName"));
	            
	            list.add(detail);
	        }
	    } catch (Exception e) {
	        System.err.println("Lỗi khi lấy chi tiết đơn hàng: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return list;
	}
}