package com.cosmeticstore.controller.admin;

import java.io.IOException;
import java.util.List;

import com.cosmeticstore.dao.OrderDao;
import com.cosmeticstore.dao.OrderDetailDao; // Nhớ import OrderDetailDao

import entity.Order;
import entity.OrderDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/order")
public class OrderServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	OrderDao dao = new OrderDao();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if (action == null) {
			action = "list";
		}

		switch (action) {

		case "list":
			listOrder(request, response);
			break;

		case "detail":
			viewOrderDetail(request, response);
			break;

		case "approve":
			approveOrder(request, response);
			break;

		case "cancel":
			cancelOrder(request, response);
			break;

		case "delete":
			deleteOrder(request, response);
			break;

		default:
			listOrder(request, response);
			break;
		}

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if ("add".equals(action)) {
			addOrder(request, response);
		} else if ("update".equals(action)) {
			updateOrder(request, response);
		}

	}

	// 1. Hàm hiển thị DANH SÁCH ĐƠN HÀNG (Chuyển sang orders.jsp)
	private void listOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			List<Order> list = dao.findAll();
			request.setAttribute("list", list);
			
			// ĐÃ SỬA: Chuyển hướng sang orders.jsp (không phải orderdetail.jsp)
			request.getRequestDispatcher("/views/admin/orders.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			// Chống trắng trang: Hiển thị thông báo lỗi ra trình duyệt nếu có Exception
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().println("<h3>Lỗi khi tải danh sách đơn hàng: " + e.getMessage() + "</h3>");
		}

	}

	// 2. Hàm hiển thị CHI TIẾT CỦA 1 ĐƠN HÀNG (Chuyển sang orderdetail.jsp)
	private void viewOrderDetail(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			int orderID = Integer.parseInt(request.getParameter("orderID"));

			// Lấy thông tin đơn hàng
			Order order = dao.findById(orderID);

			// Lấy danh sách sản phẩm trong đơn hàng
			OrderDetailDao detailDao = new OrderDetailDao();
			List<OrderDetail> list = detailDao.findByOrderID(orderID); // Hoặc hàm lấy chi tiết trong DAO của bạn

			request.setAttribute("order", order);
			request.setAttribute("orderID", orderID);
			request.setAttribute("list", list);

			request.getRequestDispatcher("/views/admin/orderdetail.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().println("<h3>Lỗi khi tải chi tiết đơn hàng: " + e.getMessage() + "</h3>");
		}

	}

	private void approveOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    try {
	        String idStr = request.getParameter("orderID");
	        if (idStr != null && !idStr.isEmpty()) {
	            int orderID = Integer.parseInt(idStr);
	            // Đổi thành "Approved" cho đúng CHECK constraint của Database
	            dao.updateStatus(orderID, "Approved");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    response.sendRedirect(request.getContextPath() + "/admin/order?action=list");
	}

	private void cancelOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    try {
	        String idStr = request.getParameter("orderID");
	        if (idStr != null && !idStr.isEmpty()) {
	            int orderID = Integer.parseInt(idStr);
	            // Đổi thành "Cancelled" cho đúng CHECK constraint của Database
	            dao.updateStatus(orderID, "Cancelled");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    response.sendRedirect(request.getContextPath() + "/admin/order?action=list");
	}

	private void addOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {

		Order order = new Order();

		order.setCustomerID(Integer.parseInt(request.getParameter("customerID")));
		order.setEmployeeID(Integer.parseInt(request.getParameter("employeeID")));
		order.setTotalAmount(Double.parseDouble(request.getParameter("totalAmount")));
		order.setStatus(request.getParameter("status"));

		dao.create(order);
		response.sendRedirect(request.getContextPath() + "/admin/order?action=list");

	}

	private void updateOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {

		Order order = new Order();

		order.setOrderID(Integer.parseInt(request.getParameter("orderID")));
		order.setStatus(request.getParameter("status"));

		dao.update(order);

		response.sendRedirect(request.getContextPath() + "/admin/order?action=list");

	}

	private void deleteOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {

		Order order = new Order();

		order.setOrderID(Integer.parseInt(request.getParameter("orderID")));

		dao.delete(order);

		response.sendRedirect(request.getContextPath() + "/admin/order?action=list");

	}

}