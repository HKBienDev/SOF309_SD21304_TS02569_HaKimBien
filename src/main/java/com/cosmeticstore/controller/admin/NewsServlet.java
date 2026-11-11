package com.cosmeticstore.controller.admin;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

import com.cosmeticstore.dao.NewsDAO;
import entity.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({
    "/news",
    "/admin/news",
    "/admin/news/add",
    "/admin/news/edit",
    "/admin/news/create",
    "/admin/news/update",
    "/admin/news/delete"
})
public class NewsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final NewsDAO dao = new NewsDAO();

    private Integer parseId(HttpServletRequest req) {
        String idRaw = req.getParameter("id");
        if (idRaw == null || idRaw.trim().isEmpty()) {
            return null;
        }
        try {
            return Integer.valueOf(idRaw.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        // ================= TRANG TIN TỨC KHÁCH HÀNG (PUBLIC) =================
        if (path.equals("/news")) {
            List<News> newsList = dao.findAll();
            req.setAttribute("newsList", newsList);
            
            // Đặt biến cờ báo hiệu cho index.jsp biết cần ẩn sản phẩm & hiện tin tức
            req.setAttribute("viewPage", "news");
            
            // Forward trực tiếp về file index.jsp chính của bạn
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
            return;
        }

        // ================= DANH SÁCH ADMIN =================
        if (path.equals("/admin/news")) {
            String keyword = req.getParameter("keyword");
            List<News> list;

            if (keyword != null && !keyword.trim().isEmpty()) {
                list = dao.findAll(); 
            } else {
                list = dao.findAll();
            }

            req.setAttribute("items", list);
            req.getRequestDispatcher("/views/admin/news.jsp").forward(req, resp);
            return;
        }

        // ================= THÊM (FORM) =================
        if (path.equals("/admin/news/add")) {
            req.getRequestDispatcher("/views/admin/add-news.jsp").forward(req, resp);
            return;
        }

        // ================= SỬA (FORM) =================
        if (path.equals("/admin/news/edit")) {
            Integer id = parseId(req);
            if (id == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/news");
                return;
            }

            News item = dao.findById(id);
            if (item == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/news");
                return;
            }

            req.setAttribute("item", item);
            req.getRequestDispatcher("/views/admin/edit.jsp").forward(req, resp);
            return;
        }

        // ================= XÓA =================
        if (path.equals("/admin/news/delete")) {
            Integer id = parseId(req);
            if (id != null) {
                News n = new News();
                n.setId(id);
                dao.delete(n);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/news");
            return;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        // ================= CREATE =================
        if (path.equals("/admin/news/create")) {
            News n = new News();
            n.setTitle(req.getParameter("title"));
            n.setSummary(req.getParameter("summary"));
            n.setContent(req.getParameter("content"));

            String photoUrl = req.getParameter("photoUrl");
            if (photoUrl != null && !photoUrl.trim().isEmpty()) {
                n.setImage(photoUrl.trim());
            } else {
                n.setImage("https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300");
            }

            n.setCreatedDate(new Timestamp(System.currentTimeMillis()));
            dao.create(n);
            resp.sendRedirect(req.getContextPath() + "/admin/news");
            return;
        }

        // ================= UPDATE =================
        if (path.equals("/admin/news/update")) {
            Integer id = parseId(req);
            if (id == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/news");
                return;
            }

            News old = dao.findById(id);
            if (old == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/news");
                return;
            }

            News n = new News();
            n.setId(id);
            n.setTitle(req.getParameter("title"));
            n.setSummary(req.getParameter("summary"));
            n.setContent(req.getParameter("content"));

            String photoUrl = req.getParameter("photoUrl");
            if (photoUrl != null && !photoUrl.trim().isEmpty()) {
                n.setImage(photoUrl.trim());
            } else {
                n.setImage(old.getImage());
            }

            n.setCreatedDate(old.getCreatedDate());
            dao.update(n);
            resp.sendRedirect(req.getContextPath() + "/admin/news");
        }
    }
}