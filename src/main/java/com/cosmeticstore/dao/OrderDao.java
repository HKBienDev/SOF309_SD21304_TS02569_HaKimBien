package com.cosmeticstore.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;

import com.cosmeticstore.utils.JdbcUtil;
import entity.Order;
import entity.OrderDetail;

public class OrderDao implements CrudDao<Order, Integer> {

    @Override
    public int create(Order entity) {
        String sql = "INSERT INTO [Order](OrderDate, CustomerID, EmployeeID, TotalAmount, Status) VALUES(?,?,?,?,?)";
        try {
            Object employeeId = (entity.getEmployeeID() == null || entity.getEmployeeID() <= 0) ? null : entity.getEmployeeID();

            return JdbcUtil.executeUpdate(sql, 
                    entity.getOrderDate(), 
                    entity.getCustomerID(), 
                    employeeId,
                    entity.getTotalAmount(), 
                    entity.getStatus());
        } catch (Exception e) {
            System.err.println("Lỗi khi thêm đơn hàng (create): " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int update(Order entity) {
        String sql = "UPDATE [Order] SET Status=?, EmployeeID=? WHERE OrderID=?";
        try {
            return JdbcUtil.executeUpdate(sql, entity.getStatus(), entity.getEmployeeID(), entity.getOrderID());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int delete(Order entity) {
        String sql = "DELETE FROM [Order] WHERE OrderID=?";
        try {
            return JdbcUtil.executeUpdate(sql, entity.getOrderID());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<Order> findAll() {
        return findBySql("SELECT * FROM [Order] ORDER BY OrderID ASC");
    }

    @Override
    public Order findById(Integer id) {
        List<Order> list = findBySql("SELECT * FROM [Order] WHERE OrderID=?", id);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public List<Order> findBySql(String sql, Object... value) {
        List<Order> list = new ArrayList<>();

        try (ResultSet rs = JdbcUtil.executeQuery(sql, value)) {
            while (rs != null && rs.next()) {
                Order order = new Order();

                order.setOrderID(rs.getInt("OrderID"));
                order.setOrderDate(rs.getDate("OrderDate"));
                order.setCustomerID(rs.getInt("CustomerID"));
                
                int empId = rs.getInt("EmployeeID");
                order.setEmployeeID(rs.wasNull() ? null : empId);

                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setStatus(rs.getString("Status"));
                
                // Gán chi tiết sản phẩm cho từng đơn hàng
                order.setOrderDetails(findDetailsByOrderID(order.getOrderID()));

                list.add(order);
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi truy vấn danh sách Order: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }

    // Hàm dùng cho Client khi Thanh Toán
    public int createOrder(Order order) {
        String sql = "INSERT INTO [Order](OrderDate, CustomerID, EmployeeID, TotalAmount, Status) "
                   + "OUTPUT INSERTED.OrderID "
                   + "VALUES(GETDATE(), ?, NULL, ?, ?)";

        try {
            String status = (order.getStatus() == null || order.getStatus().trim().isEmpty()) 
                          ? "Pending" : order.getStatus();

            try (ResultSet rs = JdbcUtil.executeQuery(sql, order.getCustomerID(), order.getTotalAmount(), status)) {
                if (rs != null && rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            System.err.println("Lỗi nghiêm trọng tại createOrder: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    // HÀM CẬP NHẬT TRẠNG THÁI ĐƠN HÀNG
    public boolean updateStatus(int orderID, String newStatus) {
        String sql = "UPDATE [Order] SET Status = ? WHERE OrderID = ?";
        try {
            int rowsAffected = JdbcUtil.executeUpdate(sql, newStatus, orderID);
            System.out.println("DEBUG DAO - Cập nhật OrderID: " + orderID + " | Trạng thái mới: " + newStatus + " | Số dòng thay đổi: " + rowsAffected);
            return rowsAffected > 0;
        } catch (Exception e) {
            System.err.println("LỖI SQL KHI UPDATE TRẠNG THÁI: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    // BỔ SUNG: Hàm lấy danh sách chi tiết sản phẩm theo OrderID (Join với bảng Product để lấy tên và hình ảnh)
    public List<OrderDetail> findDetailsByOrderID(int orderID) {
        List<OrderDetail> details = new ArrayList<>();
        String sql = "SELECT od.*, p.ProductName, p.Image " +
                     "FROM OrderDetail od " +
                     "JOIN Product p ON od.ProductID = p.ProductID " +
                     "WHERE od.OrderID = ?";
        try (Connection conn = JdbcUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail detail = new OrderDetail();
                    detail.setOrderID(rs.getInt("OrderID"));
                    detail.setProductID(rs.getInt("ProductID"));
                    detail.setQuantity(rs.getInt("Quantity"));
                    detail.setUnitPrice(rs.getDouble("UnitPrice"));
                    
                    // Nếu bảng OrderDetail hoặc entity của bạn có lưu Status riêng cho từng món
                    try {
                        detail.setStatus(rs.getString("Status"));
                    } catch (Exception e) {}

                    // Gán thông tin sản phẩm (Tên, Ảnh) để hiển thị lên giao diện lịch sử
                    entity.Product product = new entity.Product();
                    product.setProductName(rs.getString("ProductName"));
                    product.setImage(rs.getString("Image"));
                    detail.setProduct(product);

                    details.add(detail);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return details;
    }
    
    public List<Order> findByCustomerID(int customerID) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM [Order] WHERE CustomerID = ?";
        try (Connection conn = JdbcUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderID(rs.getInt("OrderID"));
                    order.setCustomerID(rs.getInt("CustomerID"));
                    order.setOrderDate(rs.getTimestamp("OrderDate"));
                    order.setTotalAmount(rs.getDouble("TotalAmount"));
                    order.setStatus(rs.getString("Status"));
                    
                    // GỌI HÀM LẤY CHI TIẾT ĐỂ GÁN VÀO ĐƠN HÀNG
                    order.setOrderDetails(findDetailsByOrderID(order.getOrderID()));
                    
                    list.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}