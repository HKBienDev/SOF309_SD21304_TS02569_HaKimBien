package com.cosmeticstore.controller.auth;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy Session hiện tại (nếu không có thì không tạo mới)
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Cách 1: Hủy toàn bộ Session (Xóa sạch mọi thông tin đăng nhập, giỏ hàng tạm...)
            session.invalidate();
            
            // Cách 2: Hoặc chỉ xóa thuộc tính người dùng nếu muốn giữ session:
            // session.removeAttribute("currentUser");
        }

        // Chuyển hướng người dùng về trang chủ hoặc trang đăng nhập
        response.sendRedirect(request.getContextPath() + "/login");
        
        // Hoặc đẩy về trang chủ:
        // response.sendRedirect(request.getContextPath() + "/home");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Cho phép xử lý Đăng xuất bằng cả phương thức POST
        doGet(request, response);
    }
}