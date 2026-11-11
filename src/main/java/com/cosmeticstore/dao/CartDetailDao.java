package com.cosmeticstore.dao;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cosmeticstore.utils.JdbcUtil;

import entity.CartDetail;

public class CartDetailDao implements CrudDao<CartDetail, Integer> {

	@Override
	public int create(CartDetail entity) {
		String sql = "INSERT INTO CartDetail(CartID, ProductID, Quantity) VALUES(?,?,?)";

		try {
			return JdbcUtil.executeUpdate(sql, entity.getCartID(), entity.getProductID(), entity.getQuantity());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	@Override
	public int update(CartDetail entity) {
		String sql = "UPDATE CartDetail SET Quantity=? WHERE CartID=? AND ProductID=?";

		try {
			return JdbcUtil.executeUpdate(sql, entity.getQuantity(), entity.getCartID(), entity.getProductID());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	@Override
	public int delete(CartDetail entity) {
		String sql = "DELETE FROM CartDetail WHERE CartID=? AND ProductID=?";

		try {
			return JdbcUtil.executeUpdate(sql, entity.getCartID(), entity.getProductID());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	@Override
	public List<CartDetail> findAll() {
		return findBySql("SELECT cd.*, p.ProductName, p.Price " + "FROM CartDetail cd "
				+ "JOIN Product p ON cd.ProductID = p.ProductID");
	}

	@Override
	public CartDetail findById(Integer id) {
		return null;
	}

	@Override
	public List<CartDetail> findBySql(String sql, Object... value) {

		List<CartDetail> list = new ArrayList<>();

		try {

			ResultSet rs = JdbcUtil.executeQuery(sql, value);

			while (rs.next()) {

				CartDetail cartDetail = new CartDetail();

				cartDetail.setCartID(rs.getInt("CartID"));
				cartDetail.setProductID(rs.getInt("ProductID"));
				cartDetail.setQuantity(rs.getInt("Quantity"));

				// Thông tin lấy từ Product
				cartDetail.setProductName(rs.getString("ProductName"));
				cartDetail.setPrice(rs.getDouble("Price"));

				list.add(cartDetail);
			}

			rs.getStatement().getConnection().close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<CartDetail> findByCartID(int cartID) {

		String sql = "SELECT cd.*, p.ProductName, p.Price " + "FROM CartDetail cd "
				+ "JOIN Product p ON cd.ProductID = p.ProductID " + "WHERE cd.CartID=?";

		return findBySql(sql, cartID);
	}

	public CartDetail findByCartAndProduct(int cartID, int productID) {

		String sql = "SELECT cd.*, p.ProductName, p.Price " + "FROM CartDetail cd "
				+ "JOIN Product p ON cd.ProductID = p.ProductID " + "WHERE cd.CartID=? AND cd.ProductID=?";

		List<CartDetail> list = findBySql(sql, cartID, productID);

		return list.isEmpty() ? null : list.get(0);
	}

	public int deleteByCartID(int cartID) {

		String sql = "DELETE FROM CartDetail WHERE CartID=?";

		try {
			return JdbcUtil.executeUpdate(sql, cartID);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}
public int updateQuantity(int cartID, int productID, int quantity) {

		String sql = "UPDATE CartDetail SET Quantity=? WHERE CartID=? AND ProductID=?";

		try {
			return JdbcUtil.executeUpdate(sql, quantity, cartID, productID);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	public int increaseQuantity(int cartID, int productID) {

		String sql = "UPDATE CartDetail SET Quantity = Quantity + 1 WHERE CartID=? AND ProductID=?";

		try {
			return JdbcUtil.executeUpdate(sql, cartID, productID);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}
}
