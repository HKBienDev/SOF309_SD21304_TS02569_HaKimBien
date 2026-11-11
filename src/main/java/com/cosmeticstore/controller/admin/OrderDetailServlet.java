package com.cosmeticstore.controller.admin;

import java.io.IOException;
import java.util.List;

import com.cosmeticstore.dao.OrderDetailDao;
import entity.OrderDetail;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/orderdetail")
public class OrderDetailServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private OrderDetailDao dao = new OrderDetailDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "updateItemStatus":
                updateItemStatus(request, response);
                break;
            case "delete":
                deleteOrderDetail(request, response);
                break;
            case "list":
            default:
                listOrderDetail(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addOrderDetail(request, response);
        } else if ("update".equals(action)) {
            updateOrderDetail(request, response);
        } else {
            listOrderDetail(request, response);
        }
    }

    private void listOrderDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String orderIDParam = request.getParameter("orderID");
            List<OrderDetail> list;

            if (orderIDParam != null && !orderIDParam.trim().isEmpty()) {
                int orderID = Integer.parseInt(orderIDParam);
                
                // Dùng hàm findByOrderID đã có JOIN lấy tên sản phẩm & tên khách hàng
                list = dao.findByOrderID(orderID);
                
                // Đẩy orderID ra JSP để hiển thị tiêu đề "CHI TIẾT ĐƠN HÀNG #1"
                request.setAttribute("orderID", orderID);
            } else {
                list = dao.findAll();
            }

            request.setAttribute("list", list);
            request.getRequestDispatcher("/views/admin/orderdetail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void updateItemStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            int productID = Integer.parseInt(request.getParameter("productID"));
            String status = request.getParameter("status"); 

            int rowsUpdated = dao.updateStatus(orderID, productID, status);
            
            if (rowsUpdated > 0) {
                System.out.println("Cập nhật trạng thái thành công #" + orderID + ", ProductID: " + productID);
            } else {
                System.out.println("Cập nhật thất bại");
            }

        } catch (Exception e) {
            System.err.println("Lỗi tại updateItemStatus: " + e.getMessage());
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/admin/orderdetail");
    }

    private void addOrderDetail(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            OrderDetail od = new OrderDetail();
            od.setOrderID(Integer.parseInt(request.getParameter("orderID")));
            od.setProductID(Integer.parseInt(request.getParameter("productID")));
            od.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            od.setUnitPrice(Double.parseDouble(request.getParameter("unitPrice")));

            dao.create(od);
            response.sendRedirect(request.getContextPath() + "/admin/orderdetail?orderID=" + od.getOrderID());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/orderdetail");
        }
    }

    private void updateOrderDetail(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            OrderDetail od = new OrderDetail();
            od.setOrderID(Integer.parseInt(request.getParameter("orderID")));
            od.setProductID(Integer.parseInt(request.getParameter("productID")));
            od.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            od.setUnitPrice(Double.parseDouble(request.getParameter("unitPrice")));

            dao.update(od);
            response.sendRedirect(request.getContextPath() + "/admin/orderdetail?orderID=" + od.getOrderID());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/orderdetail");
        }
    }

    private void deleteOrderDetail(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String orderIDParam = request.getParameter("orderID");
        try {
            OrderDetail od = new OrderDetail();
            od.setOrderID(Integer.parseInt(orderIDParam));
            od.setProductID(Integer.parseInt(request.getParameter("productID")));

            dao.delete(od);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        if (orderIDParam != null) {
            response.sendRedirect(request.getContextPath() + "/admin/orderdetail?orderID=" + orderIDParam);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/orderdetail");
        }
    }
}