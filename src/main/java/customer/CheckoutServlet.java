package customer;

import java.io.IOException;
import java.util.List;

import com.cosmeticstore.dao.CartDao;
import com.cosmeticstore.dao.CartDetailDao;
import com.cosmeticstore.dao.OrderDao;
import com.cosmeticstore.dao.OrderDetailDao;

import entity.Cart;
import entity.CartDetail;
import entity.Customer;
import entity.Order;
import entity.OrderDetail;
import entity.User; 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartDao cartDao = new CartDao();
    private CartDetailDao cartDetailDao = new CartDetailDao();
    private OrderDao orderDao = new OrderDao();
    private OrderDetailDao orderDetailDao = new OrderDetailDao();

    private Integer getCustomerIDFromSession(HttpSession session) {
        if (session == null) return null;
        
        Object userObj = session.getAttribute("currentUser");
        if (userObj == null) {
            userObj = session.getAttribute("user");
            if (userObj == null) userObj = session.getAttribute("customer");
        }

        if (userObj == null) {
            System.out.println("DEBUG: [Checkout] Không tìm thấy User/Customer trong Session!");
            return null;
        }

        if (userObj instanceof Customer) {
            return ((Customer) userObj).getCustomerID();
        }

        if (userObj instanceof User) {
            return ((User) userObj).getId(); 
        }

        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer customerID = getCustomerIDFromSession(session);

        System.out.println("DEBUG: [Checkout doGet] CustomerID = " + customerID);

        if (customerID == null) {
            System.out.println("DEBUG: Chưa đăng nhập, chuyển hướng tới /login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Cart cart = cartDao.getCartByCustomerID(customerID);
        if (cart == null) {
            System.out.println("DEBUG: Không tìm thấy Cart trong CSDL cho CustomerID = " + customerID);
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<script>alert('Giỏ hàng của bạn đang trống!'); window.location.href='" 
                                          + request.getContextPath() + "/';</script>");
            return;
        }

        List<CartDetail> list = cartDetailDao.findByCartID(cart.getCartID());
        if (list == null || list.isEmpty()) {
            System.out.println("DEBUG: Giỏ hàng bị rỗng (CartID = " + cart.getCartID() + ")");
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<script>alert('Giỏ hàng chưa có sản phẩm nào!'); window.location.href='" 
                                          + request.getContextPath() + "/';</script>");
            return;
        }

        double totalAmount = 0;
        for (CartDetail item : list) {
            totalAmount += item.getPrice() * item.getQuantity();
        }

        request.setAttribute("cartList", list);
        request.setAttribute("totalAmount", totalAmount);

        System.out.println("DEBUG: Forwarding tới /views/customer/checkout.jsp");
        request.getRequestDispatcher("/views/customer/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Integer customerID = getCustomerIDFromSession(session);

        if (customerID == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // 1. Lấy thông tin giỏ hàng của khách
        	Cart cart = cartDao.getCartByCustomerID(customerID);
            if (cart == null) {
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            List<CartDetail> cartItems = cartDetailDao.findByCartID(cart.getCartID());
            if (cartItems == null || cartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            // 2. Tính tổng tiền đơn hàng
            double totalAmount = 0;
            for (CartDetail item : cartItems) {
                totalAmount += item.getPrice() * item.getQuantity();
            }

            // 3. Khởi tạo đối tượng Order và gán giá trị
            Order order = new Order();
            order.setCustomerID(customerID);
            order.setTotalAmount(totalAmount);
            order.setStatus("Pending"); // Trạng thái 'Chờ duyệt' cho Admin thấy

            // 4. Lưu đơn hàng vào DB bằng hàm createOrder và lấy OrderID
            int orderID = orderDao.createOrder(order);

            if (orderID > 0) {
                // 5. Lưu từng chi tiết sản phẩm vào bảng OrderDetail
                for (CartDetail item : cartItems) {
                    OrderDetail detail = new OrderDetail();
                    detail.setOrderID(orderID);
                    detail.setProductID(item.getProductID());
                    detail.setQuantity(item.getQuantity());
                    detail.setUnitPrice(item.getPrice()); // Đã sửa đúng setUnitPrice
                    detail.setStatus("Pending");

                    orderDetailDao.create(detail); // Đã sửa đúng hàm create
                }

                // 6. Xóa giỏ hàng sau khi đặt thành công
                cartDetailDao.deleteByCartID(cart.getCartID());

                // 7. Chuyển hướng tới trang thông báo Cảm ơn
                request.setAttribute("orderID", orderID);
                request.getRequestDispatcher("/views/customer/order-success.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Không thể tạo đơn hàng, vui lòng thử lại!");
                doGet(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình đặt hàng: " + e.getMessage());
            doGet(request, response);
        }
    }
}