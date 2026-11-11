package com.cosmeticstore.controller.auth;

import java.io.IOException;

import com.cosmeticstore.dao.AccountDAO;
import com.cosmeticstore.dao.CustomerDAO;
import entity.Customer;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private AccountDAO accountDAO = new AccountDAO();
    private CustomerDAO customerDAO = new CustomerDAO(); 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); 
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email != null) email = email.trim();
        if (password != null) password = password.trim();

        Customer customer = customerDAO.checkLogin(email, password);
        if (customer != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", customer);
            session.setAttribute("role", "CUSTOMER");
            response.sendRedirect(request.getContextPath() + "/home"); 
            return;
        }
        
        User adminUser = accountDAO.login(email, password);
        if (adminUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", adminUser);
            session.setAttribute("role", "ADMIN");
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        
        request.setAttribute("oldEmail", email);
        request.setAttribute("errorMessage", "Sai email hoặc mật khẩu không đúng");
        request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
    }
}