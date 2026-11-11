package customer;

import java.io.IOException;
import java.util.List;

import com.cosmeticstore.dao.OrderDao;
import entity.Customer;
import entity.Order;
import entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/order-history")
public class OrderHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private OrderDao orderDao = new OrderDao();

 // Hàm lấy CustomerID đồng bộ với CheckoutServlet của bạn
    private Integer getCustomerIDFromSession(HttpSession session) {
        if (session == null) return null;
        
        Object userObj = session.getAttribute("currentUser");
        if (userObj == null) {
            userObj = session.getAttribute("user");
            if (userObj == null) userObj = session.getAttribute("customer");
        }

        if (userObj == null) {
            return null;
        }

        if (userObj instanceof Customer) {
            return ((Customer) userObj).getCustomerID();
        }

        if (userObj instanceof User) {
            User u = (User) userObj;
            // Thử lấy ID từ các tên hàm phổ biến trong class User
            // Bạn có thể đổi trực tiếp thành hàm đúng trong class User của bạn (Ví dụ: u.getUserID())
            return u.getId(); 
        }

        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer customerID = getCustomerIDFromSession(session);
        
        // Nếu chưa đăng nhập hoặc không tìm thấy ID, chuyển hướng về trang đăng nhập
        if (customerID == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Gọi DAO lấy danh sách đơn hàng của khách hàng này từ CSDL
        List<Order> orderList = orderDao.findByCustomerID(customerID);
        request.setAttribute("orderList", orderList);

        // Đánh dấu viewPage để hiển thị khung nội dung lịch sử đơn hàng trong index.jsp
        request.setAttribute("viewPage", "order-history");
        
        // Forward về index.jsp để giữ nguyên khung layout giao diện website
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}