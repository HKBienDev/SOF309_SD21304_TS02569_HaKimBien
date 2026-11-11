package customer;

import java.io.IOException;
import java.util.List;

import com.cosmeticstore.dao.ProductDao;

import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/promotion")
public class PromotionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        ProductDao productDAO = new ProductDao();
        List<Product> listDiscount = productDAO.getDiscountedProducts(); 
        
        // Sửa tên attribute từ "listDiscount" thành "products" để khớp với index.jsp
        request.setAttribute("products", listDiscount);
        request.setAttribute("viewPage", "promotion");
        
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}