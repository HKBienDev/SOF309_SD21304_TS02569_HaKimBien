package com.cosmeticstore.controller.admin;

import java.io.IOException;
import java.util.List;

import com.cosmeticstore.dao.AccountDAO;
import com.cosmeticstore.dao.CustomerDAO;

import entity.Customer;
import entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/users")
public class UserController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private AccountDAO accountDAO = new AccountDAO();
    private CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "list";
        
        if (action.equals("list")) {
            // 1. Lấy danh sách Admin/Staff từ bảng User/Account
            List<User> userList = accountDAO.findAll();
            
            // 2. Lấy danh sách Khách hàng từ bảng Customer
            List<Customer> customerList = customerDAO.findAll();
            
            // 3. Đẩy cả 2 danh sách sang JSP
            request.setAttribute("userList", userList);
            request.setAttribute("customerList", customerList);
            
            request.getRequestDispatcher("/views/admin/manage-users.jsp").forward(request, response);
            
        } else if (action.equals("delete")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String type = request.getParameter("type");

                if ("customer".equals(type)) {
                    // Xóa Khách hàng
                    Customer customerToDelete = customerDAO.findById(id);
                    if (customerToDelete != null) {
                        customerDAO.delete(customerToDelete);
                    }
                } else {
                    // Xóa Admin/Staff
                    User userToDelete = accountDAO.findById(id);
                    if (userToDelete != null) {
                        accountDAO.delete(userToDelete);
                    }
                }
            } catch (NumberFormatException e) {
                e.printStackTrace(); 
            }
            response.sendRedirect(request.getContextPath() + "/admin/users");
            
        } else if (action.equals("promote")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                // Gọi phương thức thăng cấp customer thành admin/employee trong CustomerDAO hoặc AccountDAO
                boolean success = customerDAO.promoteToAdmin(id);
                
                if (success) {
                    request.getSession().setAttribute("message", "Cấp quyền Admin thành công!");
                } else {
                    request.getSession().setAttribute("error", "Cấp quyền thất bại!");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
}