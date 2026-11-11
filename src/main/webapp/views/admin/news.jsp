<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Quản lý Tin tức - WINX ENCHANTIX</title>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

                <style>
                    :root {
                        --primary-pink: #ff66a3;
                        --light-pink: #fff0f5;
                        --dark-pink: #d11a5b;
                        --soft-white: #ffffff;
                        --gray-text: #757575;
                        --border-color: #ffe4e1;
                        --shadow: 0 4px 15px rgba(255, 102, 163, 0.15);
                    }

                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    }

                    body {
                        background-color: var(--light-pink);
                        min-height: 100vh;
                    }

                    /* --- MAIN CONTENT STYLE --- */
                    .main {
                        flex: 1;
                        padding: 40px;
                    }

                    .topbar {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 30px;
                    }

                    .topbar h1 {
                        color: var(--dark-pink);
                        font-size: 28px;
                        font-weight: 700;
                    }

                    .topbar p {
                        color: var(--gray-text);
                        font-size: 14px;
                        margin-top: 5px;
                    }

                    .topbar-actions {
                        display: flex;
                        gap: 12px;
                        align-items: center;
                    }

                    /* Nút quay lại trang chủ */
                    .btn-home {
                        background-color: #fce4ec;
                        color: #c2185b;
                        text-decoration: none;
                        padding: 12px 20px;
                        border-radius: 25px;
                        font-weight: 600;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        transition: all 0.3s ease;
                    }

                    .btn-home:hover {
                        background-color: #f8bbd0;
                        color: #880e4f;
                        transform: translateY(-2px);
                    }

                    .btn-add {
                        background-color: var(--primary-pink);
                        color: var(--soft-white);
                        text-decoration: none;
                        padding: 12px 24px;
                        border-radius: 25px;
                        font-weight: 600;
                        display: inline-flex;
                        align-items: center;
                        gap: 8px;
                        box-shadow: var(--shadow);
                        transition: all 0.3s ease;
                    }

                    .btn-add:hover {
                        background-color: var(--dark-pink);
                        transform: translateY(-2px);
                    }

                    /* --- CARD & TABLE STYLE --- */
                    .card {
                        background-color: var(--soft-white);
                        border-radius: 15px;
                        padding: 30px;
                        box-shadow: var(--shadow);
                    }

                    .search-box {
                        display: flex;
                        gap: 10px;
                        margin-bottom: 25px;
                        justify-content: flex-end;
                    }

                    .search-box input {
                        padding: 10px 20px;
                        width: 300px;
                        border: 1px solid var(--border-color);
                        border-radius: 20px;
                        outline: none;
                        background-color: var(--light-pink);
                        transition: all 0.3s;
                    }

                    .search-box input:focus {
                        border-color: var(--primary-pink);
                        box-shadow: 0 0 5px rgba(255, 102, 163, 0.3);
                    }

                    .search-box button {
                        background-color: var(--dark-pink);
                        color: var(--soft-white);
                        border: none;
                        padding: 10px 20px;
                        border-radius: 20px;
                        cursor: pointer;
                        font-weight: 600;
                        display: flex;
                        align-items: center;
                        gap: 6px;
                        transition: background 0.3s;
                    }

                    .search-box button:hover {
                        background-color: var(--primary-pink);
                    }

                    table {
                        width: 100%;
                        border-collapse: collapse;
                        margin-top: 10px;
                    }

                    table th {
                        background-color: var(--light-pink);
                        color: var(--dark-pink);
                        padding: 15px;
                        text-align: left;
                        font-weight: 600;
                        border-bottom: 2px solid var(--border-color);
                    }

                    table td {
                        padding: 15px;
                        border-bottom: 1px solid var(--border-color);
                        color: #444;
                        font-size: 14px;
                        vertical-align: middle;
                    }

                    table tr:hover {
                        background-color: rgba(255, 240, 245, 0.5);
                    }

                    table .image {
                        width: 80px;
                        height: 55px;
                        object-fit: cover;
                        border-radius: 8px;
                        border: 2px solid var(--border-color);
                    }

                    /* --- ACTION BUTTONS --- */
                    .btn-edit,
                    .btn-delete {
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        width: 35px;
                        height: 35px;
                        border-radius: 50%;
                        text-decoration: none;
                        margin-right: 5px;
                        transition: all 0.3s;
                    }

                    .btn-edit {
                        background-color: #ffe6f0;
                        color: var(--primary-pink);
                    }

                    .btn-edit:hover {
                        background-color: var(--primary-pink);
                        color: var(--soft-white);
                    }

                    .btn-delete {
                        background-color: #fff0f0;
                        color: #ff4d4d;
                    }

                    .btn-delete:hover {
                        background-color: #ff4d4d;
                        color: var(--soft-white);
                    }
                </style>
            </head>

            <body>

                <!-- MAIN -->
                <div class="main">
                    <div class="topbar">
                        <div>
                            <h1>Quản lý Tin tức</h1>
                            <p>WINX ENCHANTIX Cosmetics Admin</p>
                        </div>

                        <div class="topbar-actions">
                            <!-- Nút Trang Chủ chỉ hiển thị chữ Trang chủ (Đã bỏ icon) -->
                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-home">
                                Trang chủ
                            </a>

                            <a href="${pageContext.request.contextPath}/admin/news/add" class="btn-add">
                                <i class="fa fa-plus"></i> Thêm bài viết
                            </a>
                        </div>
                    </div>

                    <!-- CARD -->
                    <div class="card">
                        <form class="search-box" action="${pageContext.request.contextPath}/admin/news" method="get">
                            <input type="text" name="keyword" value="${param.keyword}"
                                placeholder="Tìm kiếm tiêu đề tin tức...">
                            <button type="submit">
                                <i class="fa fa-search"></i> Tìm kiếm
                            </button>
                        </form>

                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Hình ảnh</th>
                                    <th>Tiêu đề</th>
                                    <th>Tóm tắt</th>
                                    <th>Ngày đăng</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty items}">
                                        <tr>
                                            <td colspan="6" style="text-align: center; color: var(--gray-text);">
                                                Không có dữ liệu.
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${items}" var="n">
                                            <tr>
                                                <td>${n.id}</td>
                                                <td>
                                                    <img class="image" src="${n.image}"
                                                        onerror="this.src='https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300'"
                                                        alt="news image">
                                                </td>
                                                <td>
                                                    <b>${n.title}</b>
                                                </td>
                                                <td>${n.summary}</td>
                                                <td>
                                                    <fmt:formatDate value="${n.createdDate}" pattern="dd/MM/yyyy" />
                                                </td>
                                                <td>
                                                    <a class="btn-edit"
                                                        href="${pageContext.request.contextPath}/admin/news/edit?id=${n.id}"
                                                        title="Sửa">
                                                        <i class="fa fa-pen"></i>
                                                    </a>
                                                    <a class="btn-delete"
                                                        onclick="return confirm('Bạn có chắc muốn xóa bài viết này?')"
                                                        href="${pageContext.request.contextPath}/admin/news/delete?id=${n.id}"
                                                        title="Xóa">
                                                        <i class="fa fa-trash"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>

            </body>

            </html>