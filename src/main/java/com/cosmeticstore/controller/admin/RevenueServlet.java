package com.cosmeticstore.controller.admin;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import com.cosmeticstore.dao.RevenueDAO;

import entity.BestSellingProduct;
import entity.RevenueByDay;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/revenue")
public class RevenueServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RevenueDAO dao = new RevenueDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String fromDateString = req.getParameter("fromDate");
		String toDateString = req.getParameter("toDate");

		Date fromDate = null;
		Date toDate = null;

		if (fromDateString != null && !fromDateString.isEmpty()) {
			fromDate = Date.valueOf(fromDateString);
		}

		if (toDateString != null && !toDateString.isEmpty()) {
			toDate = Date.valueOf(toDateString);
		}

		try {
			List<RevenueByDay> revenueList = dao.getRevenueByDay(fromDate, toDate);
			List<BestSellingProduct> topProductList = dao.getTop5BestSellingProducts(fromDate, toDate);

			long totalRevenue = 0;
			int totalBills = 0;

			for (RevenueByDay item : revenueList) {
				totalRevenue += item.getTotalRevenue();
				totalBills += item.getTotalBills();
			}

			req.setAttribute("revenueList", revenueList);
			req.setAttribute("topProductList", topProductList);
			req.setAttribute("totalRevenue", totalRevenue);
			req.setAttribute("totalBills", totalBills);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		req.getRequestDispatcher("/views/admin/revenue.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}