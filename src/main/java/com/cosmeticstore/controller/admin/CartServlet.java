package com.cosmeticstore.controller.admin;

import java.io.IOException;
import java.util.List;

import com.cosmeticstore.dao.CartDao;
import com.cosmeticstore.dao.CartDetailDao;

import entity.Cart;
import entity.CartDetail;
import entity.Customer;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private CartDao cartDao = new CartDao();
	private CartDetailDao cartDetailDao = new CartDetailDao();

	// Hàm lấy ID khách hàng đang đăng nhập từ Session (giống hệt bên CheckoutServlet)
	private Integer getCustomerIDFromSession(HttpSession session) {
		if (session == null) return null;
		
		Object userObj = session.getAttribute("currentUser");
		if (userObj == null) {
			userObj = session.getAttribute("user");
			if (userObj == null) userObj = session.getAttribute("customer");
		}

		if (userObj == null) {
			return null;
		}

		if (userObj instanceof Customer) {
			return ((Customer) userObj).getCustomerID();
		}

		if (userObj instanceof User) {
			return ((User) userObj).getId(); 
		}

		return null;
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if (action == null) {
			action = "view";
		}

		switch (action) {
		case "add": 
			addProduct(request, response);
			break;

		case "view":
			viewCart(request, response);
			break;

		case "increase":
			increaseQuantity(request, response);
			break;

		case "decrease":
			decreaseQuantity(request, response);
			break;

		case "remove":
			removeProduct(request, response);
			break;

		default:
			viewCart(request, response);
			break;
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if ("add".equals(action)) {
			addProduct(request, response);
		}
	}

	private void viewCart(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		Integer customerID = getCustomerIDFromSession(session);

		if (customerID == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		// Sử dụng getCartByCustomerID để đảm bảo luôn lấy được giỏ hàng chính xác của tài khoản hiện tại
		Cart cart = cartDao.getCartByCustomerID(customerID);

		if (cart != null) {
			List<CartDetail> list = cartDetailDao.findByCartID(cart.getCartID());
			request.setAttribute("list", list);
		}
		request.getRequestDispatcher("/views/customer/cart.jsp").forward(request, response);
	}

	private void addProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {

		HttpSession session = request.getSession();
		Integer customerID = getCustomerIDFromSession(session);

		if (customerID == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		String productIDStr = request.getParameter("productID");

		if (productIDStr != null && !productIDStr.isEmpty()) {
			int productID = Integer.parseInt(productIDStr);

			// Lấy giỏ hàng chuẩn của tài khoản hiện tại (tự động tạo nếu chưa có)
			Cart cart = cartDao.getCartByCustomerID(customerID);

			if (cart != null) {
				CartDetail detail = cartDetailDao.findByCartAndProduct(cart.getCartID(), productID);

				if (detail == null) {
					detail = new CartDetail();
					detail.setCartID(cart.getCartID());
					detail.setProductID(productID);
					detail.setQuantity(1); 

					cartDetailDao.create(detail);
				} else {
					cartDetailDao.increaseQuantity(cart.getCartID(), productID);
				}
			}
		}

		String requestedWith = request.getHeader("X-Requested-With");
		if ("XMLHttpRequest".equals(requestedWith) || request.getHeader("Accept").contains("application/json")) {
			response.setStatus(HttpServletResponse.SC_OK);
		} else {
			response.sendRedirect(request.getContextPath() + "/cart?action=view");
		}
	}

	private void increaseQuantity(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int cartID = Integer.parseInt(request.getParameter("cartID"));
		int productID = Integer.parseInt(request.getParameter("productID"));

		cartDetailDao.increaseQuantity(cartID, productID);

		response.sendRedirect(request.getContextPath() + "/cart?action=view");
	}

	private void decreaseQuantity(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int cartID = Integer.parseInt(request.getParameter("cartID"));
		int productID = Integer.parseInt(request.getParameter("productID"));

		CartDetail detail = cartDetailDao.findByCartAndProduct(cartID, productID);

		if (detail != null) {
			if (detail.getQuantity() > 1) {
				cartDetailDao.updateQuantity(cartID, productID, detail.getQuantity() - 1);
			} else {
				cartDetailDao.delete(detail);
			}
		}

		response.sendRedirect(request.getContextPath() + "/cart?action=view");
	}

	private void removeProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
		CartDetail detail = new CartDetail();

		detail.setCartID(Integer.parseInt(request.getParameter("cartID")));
		detail.setProductID(Integer.parseInt(request.getParameter("productID")));

		cartDetailDao.delete(detail);

		response.sendRedirect(request.getContextPath() + "/cart?action=view");
	}
}