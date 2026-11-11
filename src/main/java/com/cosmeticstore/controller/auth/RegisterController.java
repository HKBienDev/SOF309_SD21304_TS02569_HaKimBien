package com.cosmeticstore.controller.auth;

import java.io.IOException;
import java.sql.ResultSet;

import com.cosmeticstore.utils.JdbcUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone"); // Lấy số điện thoại từ form
        String password = request.getParameter("password"); 

        try {
            // 1. Kiểm tra Email đã tồn tại chưa
            String checkSql = "SELECT CustomerID FROM Customer WHERE Email = ?";
            ResultSet rs = JdbcUtil.executeQuery(checkSql, email);
            
            if (rs.next()) {
                rs.getStatement().getConnection().close(); 
                request.setAttribute("error", "Email này đã được sử dụng");
                request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
                return;
            }
            rs.getStatement().getConnection().close();

            // 2. Thêm vào CSDL bao gồm cả số điện thoại (Phone)
            String insertSql = "INSERT INTO Customer (CustomerName, Phone, Address, Email, Password) VALUES (?, ?, N'Chưa cập nhật', ?, ?)";
            
            // Truyền đủ 4 tham số: name, phone, email, password
            int rowsAffected = JdbcUtil.executeUpdate(insertSql, name, phone, email, password);

            if (rowsAffected > 0) {
                // ĐĂNG KÝ THÀNH CÔNG: Chuyển hướng thẳng sang trang đăng nhập
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            } else {
                request.setAttribute("error", "Đăng ký thất bại, vui lòng thử lại");
                request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
        }
    }
}