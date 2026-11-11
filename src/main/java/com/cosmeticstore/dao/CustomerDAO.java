package com.cosmeticstore.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cosmeticstore.utils.JdbcUtil;
import entity.Customer;

public class CustomerDAO implements CrudDao<Customer, Integer> {

    // 1. Kiểm tra đăng nhập
    public Customer checkLogin(String email, String password) {
        if (email == null || password == null) return null;
        
        String sql = "SELECT * FROM Customer WHERE LOWER(Email) = LOWER(?) AND Password = ?";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, email.trim(), password.trim());
            if (rs.next()) {
                Customer c = new Customer();
                c.setCustomerID(rs.getInt("CustomerID"));
                c.setCustomerName(rs.getString("CustomerName"));
                c.setPhone(rs.getString("Phone"));
                c.setAddress(rs.getString("Address"));
                c.setEmail(rs.getString("Email"));
                c.setPassword(rs.getString("Password"));
                
                rs.getStatement().getConnection().close();
                return c;
            }
            rs.getStatement().getConnection().close();
        } catch (Exception e) {
            System.err.println(">>> Lỗi truy vấn bảng Customer:");
            e.printStackTrace();
        }
        return null;
    }

    // 2. Lấy tất cả khách hàng
    @Override
    public List<Customer> findAll() {
        return findBySql("SELECT * FROM Customer");
    }

    // 3. Tìm khách hàng theo ID
    @Override
    public Customer findById(Integer id) {
        List<Customer> list = findBySql("SELECT * FROM Customer WHERE CustomerID = ?", id);
        return list.isEmpty() ? null : list.get(0);
    }

    // 4. Xóa khách hàng
    @Override
    public int delete(Customer entity) {
        String sql = "DELETE FROM Customer WHERE CustomerID = ?";
        try {
            return JdbcUtil.executeUpdate(sql, entity.getCustomerID());
        } catch (Exception e) {
            System.err.println("Lỗi khi xóa Customer: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    // 5. Thêm khách hàng mới
 // 5. Thêm khách hàng mới và tự động tạo giỏ hàng (Cart)
    @Override
    public int create(Customer entity) {
        String sqlCustomer = "INSERT INTO Customer(CustomerName, Phone, Address, Email, Password) VALUES(?,?,?,?,?)";
        String sqlCart = "INSERT INTO Cart(CustomerID) VALUES(?)";
        
        try (Connection conn = JdbcUtil.getConnection()) {
            conn.setAutoCommit(false); // Bắt đầu Transaction để đảm bảo tính toàn vẹn
            
            int customerId = 0;
            // 1. Thêm khách hàng mới và lấy ra CustomerID vừa được sinh tự động
            try (PreparedStatement ps = conn.prepareStatement(sqlCustomer, PreparedStatement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, entity.getCustomerName());
                ps.setString(2, entity.getPhone());
                ps.setString(3, entity.getAddress());
                ps.setString(4, entity.getEmail());
                ps.setString(5, entity.getPassword());
                ps.executeUpdate();
                
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        customerId = rs.getInt(1);
                    }
                }
            }
            
            // 2. Tự động tạo giỏ hàng trống cho khách hàng mới này
            if (customerId > 0) {
                try (PreparedStatement psCart = conn.prepareStatement(sqlCart)) {
                    psCart.setInt(1, customerId);
                    psCart.executeUpdate();
                }
            }
            
            conn.commit(); // Xác nhận hoàn tất cả 2 bước
            return customerId;
        } catch (Exception e) {
            System.err.println(">>> Lỗi khi tạo Customer và Cart mới:");
            e.printStackTrace();
        }
        return 0;
    }

    // 6. Cập nhật thông tin
    @Override
    public int update(Customer entity) {
        String sql = "UPDATE Customer SET CustomerName=?, Phone=?, Address=?, Email=?, Password=? WHERE CustomerID=?";
        try {
            return JdbcUtil.executeUpdate(sql, entity.getCustomerName(), entity.getPhone(), 
                                                entity.getAddress(), entity.getEmail(), entity.getPassword(), entity.getCustomerID());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 7. Thực thi SQL dùng chung
    @Override
    public List<Customer> findBySql(String sql, Object... value) {
        List<Customer> list = new ArrayList<>();
        try (ResultSet rs = JdbcUtil.executeQuery(sql, value)) {
            while (rs != null && rs.next()) {
                Customer c = new Customer();
                c.setCustomerID(rs.getInt("CustomerID"));
                c.setCustomerName(rs.getString("CustomerName"));
                c.setPhone(rs.getString("Phone"));
                c.setAddress(rs.getString("Address"));
                c.setEmail(rs.getString("Email"));
                c.setPassword(rs.getString("Password"));
                list.add(c);
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi query Customer: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

 // 8. Cấp quyền Customer thành Admin/Employee
    public boolean promoteToAdmin(int customerId) {
        Customer c = findById(customerId);
        if (c == null) return false;

        // Thêm vào bảng Employee (vì hệ thống của bạn quản lý admin/nhân viên ở bảng Employee)
        // Các giá trị mặc định cho nhân viên mới được cấp quyền: Gender = true, Position = 'Quản lý'
        String sqlInsert = "INSERT INTO Employee (EmployeeName, Gender, Phone, Address, Position, Email, Password) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String sqlDelete = "DELETE FROM Customer WHERE CustomerID = ?";

        try (Connection conn = JdbcUtil.getConnection()) {
            conn.setAutoCommit(false); // Bắt đầu Transaction

            // 1. Thêm thông tin sang bảng Employee
            try (PreparedStatement ps1 = conn.prepareStatement(sqlInsert)) {
                ps1.setString(1, c.getCustomerName());
                ps1.setBoolean(2, true); // Giới tính mặc định
                ps1.setString(3, c.getPhone() != null ? c.getPhone() : "0900000000"); // Phone không được NULL theo cấu trúc bảng
                ps1.setString(4, c.getAddress() != null ? c.getAddress() : "Chưa cập nhật"); // Address không được NULL
                ps1.setString(5, "Quản lý"); // Chức vụ mặc định
                ps1.setString(6, c.getEmail());
                ps1.setString(7, c.getPassword() != null ? c.getPassword() : "123456");
                ps1.executeUpdate();
            }

            // 2. Xóa khỏi bảng Customer
            try (PreparedStatement ps2 = conn.prepareStatement(sqlDelete)) {
                ps2.setInt(1, customerId);
                ps2.executeUpdate();
            }

            conn.commit(); // Xác nhận thành công
            return true;
        } catch (Exception e) {
            System.err.println(">>> LỖI KHI CẤP QUYỀN ADMIN:");
            e.printStackTrace(); // In lỗi chi tiết ra console nếu có vấn đề phát sinh
        }
        return false;
    }
}