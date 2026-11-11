package com.cosmeticstore.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.cosmeticstore.utils.DateUtil;
import com.cosmeticstore.utils.JdbcUtil;

import entity.BestSellingProduct;
import entity.RevenueByDay;

public class RevenueDAO {

    public List<BestSellingProduct> getTop5BestSellingProducts(Date fromDate, Date toDate) throws SQLException {
        List<BestSellingProduct> result = new ArrayList<>();
        String sql = "{CALL sp_top_5_best_selling_products(?,?)}";

        // Xử lý nếu từ ngày/đến ngày bị null -> Mặc định lấy từ 30 ngày trước đến hiện tại
        if (fromDate == null || toDate == null) {
            Calendar cal = Calendar.getInstance();
            if (toDate == null) toDate = cal.getTime();
            if (fromDate == null) {
                cal.add(Calendar.DAY_OF_MONTH, -30);
                fromDate = cal.getTime();
            }
        }

        String fromDateString = DateUtil.toString(fromDate, "yyyy-MM-dd");
        String toDateString = DateUtil.toString(toDate, "yyyy-MM-dd");

        try (ResultSet rs = JdbcUtil.executeQuery(sql, fromDateString, toDateString)) {
            if (rs != null) {
                while (rs.next()) {
                    BestSellingProduct dto = new BestSellingProduct();
                    dto.setProductID(rs.getInt("product_id"));
                    dto.setProductName(rs.getString("product_name"));
                    dto.settotalQuantitySold(rs.getInt("total_quantity_sold"));
                    dto.setTotalRevenue(rs.getLong("total_revenue"));

                    result.add(dto);
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi tại getTop5BestSellingProducts: " + e.getMessage());
            e.printStackTrace();
        }

        return result;
    }

    public List<RevenueByDay> getRevenueByDay(Date fromDate, Date toDate) throws SQLException {
        List<RevenueByDay> result = new ArrayList<>();
        String sql = "{CALL sp_revenue_by_day(?,?)}";

        // Xử lý nếu từ ngày/đến ngày bị null -> Mặc định lấy từ 30 ngày trước đến hiện tại
        if (fromDate == null || toDate == null) {
            Calendar cal = Calendar.getInstance();
            if (toDate == null) toDate = cal.getTime();
            if (fromDate == null) {
                cal.add(Calendar.DAY_OF_MONTH, -30);
                fromDate = cal.getTime();
            }
        }

        String fromDateString = DateUtil.toString(fromDate, "yyyy-MM-dd");
        String toDateString = DateUtil.toString(toDate, "yyyy-MM-dd");

        try (ResultSet rs = JdbcUtil.executeQuery(sql, fromDateString, toDateString)) {
            if (rs != null) {
                while (rs.next()) {
                    RevenueByDay dto = new RevenueByDay();
                    dto.setRevenueDate(rs.getDate("revenue_date"));
                    dto.setTotalBills(rs.getInt("total_bills"));
                    dto.setTotalRevenue(rs.getLong("total_revenue"));

                    result.add(dto);
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi tại getRevenueByDay: " + e.getMessage());
            e.printStackTrace();
        }

        return result;
    }
}