package customer;

import java.io.IOException;
import java.util.List;

import com.cosmeticstore.dao.StatisticsDao;

import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/best-sellers")
public class BestSellerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        StatisticsDao dao = new StatisticsDao();
        List<Product> topProducts = dao.getTopSellingProducts();
        
        // Đổi tên thành "products" để khớp với phần hiển thị trong index.jsp
        request.setAttribute("products", topProducts);
        request.setAttribute("viewPage", "best-sellers");
        
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
