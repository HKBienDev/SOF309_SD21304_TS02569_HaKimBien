package com.cosmeticstore.dao;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.cosmeticstore.utils.JdbcUtil;

import entity.Cart;

public class CartDao implements CrudDao<Cart, Integer> {

	@Override
	public int create(Cart entity) {
		String sql = "INSERT INTO Cart(CustomerID) VALUES(?)";

		try {
			// Sử dụng Statement.RETURN_GENERATED_KEYS để lấy về CartID tự tăng vừa chèn
			try (java.sql.Connection conn = JdbcUtil.getConnection();
			     java.sql.PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
				
				ps.setInt(1, entity.getCustomerID());
				int affectedRows = ps.executeUpdate();
				
				if (affectedRows > 0) {
					try (ResultSet rs = ps.getGeneratedKeys()) {
						if (rs.next()) {
							return rs.getInt(1); // Trả về CartID vừa tạo
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	@Override
	public int update(Cart entity) {
		return 0;
	}

	@Override
	public int delete(Cart entity) {
		String sql = "DELETE FROM Cart WHERE CartID=?";

		try {
			return JdbcUtil.executeUpdate(sql, entity.getCartID());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	@Override
	public List<Cart> findAll() {
		return findBySql("SELECT * FROM Cart");
	}

	@Override
	public Cart findById(Integer id) {
		List<Cart> list = findBySql("SELECT * FROM Cart WHERE CartID=?", id);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public List<Cart> findBySql(String sql, Object... value) {
		List<Cart> list = new ArrayList<>();

		try {
			ResultSet rs = JdbcUtil.executeQuery(sql, value);

			while (rs != null && rs.next()) {
				Cart cart = new Cart();

				cart.setCartID(rs.getInt("CartID"));
				cart.setCustomerID(rs.getInt("CustomerID"));

				list.add(cart);
			}

			if (rs != null && rs.getStatement() != null && rs.getStatement().getConnection() != null) {
				rs.getStatement().getConnection().close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public Cart findByCustomerID(int customerID) {
		List<Cart> list = findBySql("SELECT * FROM Cart WHERE CustomerID=?", customerID);
		return list.isEmpty() ? null : list.get(0);
	}

	// Tự động tìm giỏ hàng theo CustomerID, nếu chưa có thì tự tạo mới luôn
	public Cart getCartByCustomerID(int customerID) {
		Cart cart = findByCustomerID(customerID);
		if (cart == null) {
			// Nếu chưa có giỏ hàng, tiến hành tạo mới
			Cart newCart = new Cart();
			newCart.setCustomerID(customerID);
			int newCartId = create(newCart);
			if (newCartId > 0) {
				cart = findById(newCartId); // Lấy lại chính xác giỏ hàng vừa tạo theo CartID
			}
		}
		return cart;
	}
}