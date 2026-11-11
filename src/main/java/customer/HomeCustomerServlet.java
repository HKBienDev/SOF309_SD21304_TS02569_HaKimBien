package customer;

import java.io.IOException;
import java.util.List;

import com.cosmeticstore.dao.CategoryDao;
import com.cosmeticstore.dao.NewsDAO;
import com.cosmeticstore.dao.ProductDao;

import entity.Category;
import entity.News;
import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({"/home", ""})
public class HomeCustomerServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private ProductDao productDao = new ProductDao();
	private CategoryDao categoryDao = new CategoryDao();
	private NewsDAO newsDAO = new NewsDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<Product> products = productDao.findAll();
		List<Category> categories = categoryDao.findAll();
		
		List<News> newsList = null;
		try {
			newsList = newsDAO.findAll();
		} catch (Exception e) {
			System.err.println("Chưa có bảng News trong DB, bỏ qua tin tức!");
		}

		// Đánh dấu đang ở trang chủ
		request.setAttribute("viewPage", "home");

		request.setAttribute("products", products);
		request.setAttribute("categories", categories);
		request.setAttribute("newsList", newsList);

		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}