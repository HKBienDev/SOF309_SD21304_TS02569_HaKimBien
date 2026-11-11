package com.cosmeticstore.controller.admin; // Hoặc package hiện tại của bạn

import java.io.IOException;
import java.math.BigDecimal;
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

@WebServlet({
    "/product",
    "/products",
    "/admin/product",
    "/admin/products",
    "/admin/product/new",
    "/admin/product/edit",
    "/admin/product/delete"
})
public class ProductServlet extends HttpServlet {

    private ProductDao productDao = new ProductDao();
    private CategoryDao categoryDao = new CategoryDao();
    private NewsDAO newsDao = new NewsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String servletPath = request.getServletPath();
        String action = request.getParameter("action");

        // 1. NẾU ĐƯỜNG DẪN BẮT ĐẦU BẰNG /admin/ -> ĐIỀU HƯỚNG VỀ PHÍA ADMIN
        if (servletPath != null && servletPath.startsWith("/admin")) {
            if (action == null) {
                action = "list";
            }

            switch (action) {
                case "new":
                    showForm(request, response);
                    break;
                case "edit":
                    editProduct(request, response);
                    break;
                case "delete":
                    deleteProduct(request, response);
                    break;
                default:
                    showList(request, response);
                    break;
            }
            return; // Dừng lại ở đây, không chạy xuống phần khách hàng
        }

        // 2. NẾU LÀ CÁC ĐƯỜNG DẪN CÒN LẠI (/product, /products) -> ĐIỀU HƯỚNG VỀ PHÍA KHÁCH HÀNG
        showCustomerPage(request, response);
    }

    /**
     * Xử lý hiển thị cho trang Khách hàng
     */
    private void showCustomerPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String categoryParam = request.getParameter("category");
        String keywordParam = request.getParameter("keyword");
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");
        String servletPath = request.getServletPath();

        // Xem chi tiết sản phẩm
        if ("detail".equals(action) && idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                Product detailProduct = productDao.findById(id);
                if (detailProduct != null) {
                    request.setAttribute("detailProduct", detailProduct);
                    request.setAttribute("viewPage", "product-detail");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } 
        
        // Lọc hoặc tìm kiếm
        if (viewPageNotSet(request) && categoryParam != null && !categoryParam.trim().isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryParam);
                List<Product> products = productDao.findByCategoryId(categoryId);
                request.setAttribute("products", products);
                request.setAttribute("viewPage", "products");
            } catch (NumberFormatException e) {
                List<Product> products = productDao.findAll();
                request.setAttribute("products", products);
                request.setAttribute("viewPage", "products");
            }
        } else if (viewPageNotSet(request) && keywordParam != null && !keywordParam.trim().isEmpty()) {
            List<Product> products = productDao.searchByName(keywordParam.trim());
            request.setAttribute("products", products);
            request.setAttribute("viewPage", "products");
        } else if (viewPageNotSet(request) && "/products".equals(servletPath)) {
            List<Product> products = productDao.findAll();
            request.setAttribute("products", products);
            request.setAttribute("viewPage", "products");
        } else if (viewPageNotSet(request)) {
            List<Product> products = productDao.findAll();
            request.setAttribute("products", products);
            request.setAttribute("viewPage", "home");
        }

        List<Category> categories = categoryDao.findAll();
        List<News> newsList = newsDao.findAll();

        request.setAttribute("categories", categories);
        request.setAttribute("newsList", newsList);

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    private boolean viewPageNotSet(HttpServletRequest request) {
        return request.getAttribute("viewPage") == null;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("productID");
        String productName = request.getParameter("productName");
        String price = request.getParameter("price");
        String discountPriceStr = request.getParameter("discountPrice"); 
        String stock = request.getParameter("stockQuantity");
        String category = request.getParameter("categoryID");
        String image = request.getParameter("image");  
        String description = request.getParameter("description");

        Product p = new Product();
        p.setProductName(productName);
        p.setImage(image);
        p.setDescription(description);

        try {
            if (productName == null || productName.trim().isEmpty()) {
                throw new Exception("Tên sản phẩm không được để trống.");
            }
            if (price == null || price.trim().isEmpty()) {
                throw new Exception("Vui lòng nhập giá.");
            }

            BigDecimal priceVal = new BigDecimal(price);
            p.setPrice(priceVal);

            if (p.getPrice().compareTo(BigDecimal.ZERO) <= 0) {
                throw new Exception("Giá phải lớn hơn 0.");
            }

            if (discountPriceStr != null && !discountPriceStr.trim().isEmpty()) {
                BigDecimal discountVal = new BigDecimal(discountPriceStr);
                p.setDiscountPrice(discountVal.compareTo(BigDecimal.ZERO) > 0 ? discountVal : null);
            } else {
                p.setDiscountPrice(null);
            }

            if (stock == null || stock.trim().isEmpty()) {
                throw new Exception("Vui lòng nhập số lượng.");
            }

            p.setStockQuantity(Integer.parseInt(stock));

            if (p.getStockQuantity() < 0) {
                throw new Exception("Số lượng không được âm.");
            }

            if (category == null || category.trim().isEmpty()) {
                throw new Exception("Vui lòng chọn loại sản phẩm.");
            }

            p.setCategoryID(Integer.parseInt(category));

            if (id == null || id.isBlank()) {
                productDao.create(p);
            } else {
                p.setProductID(Integer.parseInt(id));
                productDao.update(p);
            }

            response.sendRedirect(request.getContextPath() + "/admin/product");

        } catch (NumberFormatException e) {
            forwardWithError(request, response, "Dữ liệu số không hợp lệ.", p);
        } catch (Exception e) {
            forwardWithError(request, response, e.getMessage(), p);
        }
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String errorMsg, Product p)
            throws ServletException, IOException {
        request.setAttribute("error", errorMsg);
        List<Category> categories = categoryDao.findAll();
        request.setAttribute("categories", categories);
        request.setAttribute("product", p);
        request.getRequestDispatcher("/views/admin/products/form.jsp").forward(request, response);
    }

    private void showList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> list = productDao.findAll();
        request.setAttribute("list", list);
        request.getRequestDispatcher("/views/admin/products/list-sp.jsp").forward(request, response);
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> categories = categoryDao.findAll();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/views/admin/products/form.jsp").forward(request, response);
    }

    private void editProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productDao.findById(id);
            List<Category> categories = categoryDao.findAll();

            request.setAttribute("product", product);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/views/admin/products/form.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin/product");
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productDao.findById(id);
            if (product != null) {
                productDao.delete(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/admin/product");
    }
}