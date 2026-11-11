<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, entity.User, entity.Customer" %>
<html>
<head>
    <title>Quản lý người dùng - Cửa hàng WINX</title>
    <style>
        :root {
            --primary-pink: #ff69b4;       /* Hồng đậm chủ đạo */
            --dark-pink: #e04d98;          /* Hồng đậm hơn khi hover */
            --soft-bg: #fff0f5;             /* Nền hồng pastel sáng nhẹ */
            --text-color: #3a3a3a;         /* Màu chữ xám đậm dễ nhìn */
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--soft-bg);
            margin: 0;
            padding: 40px 20px;
            color: var(--text-color);
        }

        .container {
            max-width: 950px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 35px;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(255, 105, 180, 0.2);
        }

        .header-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #ffb6c1;
            padding-bottom: 15px;
            margin-bottom: 25px;
        }

        .header-actions {
            display: flex;
            gap: 10px; /* Khoảng cách giữa 2 nút */
            align-items: center;
        }

        h2 {
            color: #d81b60;                /* Hồng mận đậm cho tiêu đề */
            margin: 0;
            font-size: 24px;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .section-title {
            color: #d81b60;
            font-size: 18px;
            font-weight: 600;
            margin-top: 25px;
            margin-bottom: 10px;
            border-left: 4px solid var(--primary-pink);
            padding-left: 10px;
        }

        /* Nút Quay lại Admin Dashboard */
        .btn-back {
            background-color: #ffffff;
            color: var(--primary-pink);
            border: 2px solid var(--primary-pink);
            text-decoration: none;
            padding: 7px 16px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            background-color: #ffe4e1;
            color: #d81b60;
            border-color: #d81b60;
        }

        .btn-logout {
            background-color: var(--primary-pink);
            color: white;
            text-decoration: none;
            padding: 9px 18px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(255, 105, 180, 0.3);
        }

        .btn-logout:hover {
            background-color: var(--dark-pink);
            transform: translateY(-1px);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            margin-bottom: 20px;
            background-color: #ffffff;
        }

        th, td {
            padding: 14px 14px;
            text-align: left;
            border-bottom: 1px solid #ffe4e1;
            font-size: 15px;
        }

        th {
            background-color: #fff0f5;
            color: #d81b60;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 0.5px;
        }

        tr:hover {
            background-color: #fffafb;     /* Hiệu ứng sáng dòng khi di chuột qua */
        }

        td strong {
            color: #2b2b2b;
        }

        .action-group {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .btn-promote {
            background-color: #e8f5e9;
            color: #2e7d32;
            text-decoration: none;
            font-weight: 600;
            font-size: 13px;
            padding: 6px 10px;
            border-radius: 6px;
            transition: all 0.2s;
            white-space: nowrap;
        }

        .btn-promote:hover {
            background-color: #c8e6c9;
            color: #1b5e20;
        }

        .btn-delete {
            background-color: #ffebee;
            color: #c62828;
            text-decoration: none;
            font-weight: 600;
            font-size: 13px;
            padding: 6px 10px;
            border-radius: 6px;
            transition: all 0.2s;
            white-space: nowrap;
        }

        .btn-delete:hover {
            background-color: #ffcdd2;
            color: #b71c1c;
        }
        
        .badge-role {
            background-color: #ffe4e1;
            color: #d81b60;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header-box">
        <h2>DANH SÁCH NGƯỜI DÙNG TRONG HỆ THỐNG</h2>
        <div class="header-actions">
            <!-- Nút quay lại trang Dashboard Admin -->
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-back">‹ Trang chủ</a>
            <!-- Nút đăng xuất -->
            <a href="${pageContext.request.contextPath}/login" class="btn-logout">Đăng xuất</a>
        </div>
    </div>

    <!-- DANH SÁCH KHÁCH HÀNG -->
    <div class="section-title">DANH SÁCH KHÁCH HÀNG</div>
    <table>
        <thead>
            <tr>
                <th style="width: 8%">ID</th>
                <th style="width: 28%">Tên khách hàng</th>
                <th style="width: 24%">Email</th>
                <th style="width: 15%">Số điện thoại</th>
                <th style="width: 25%">Phép thuật</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Customer> customerList = (List<Customer>) request.getAttribute("customerList");
                if (customerList != null && !customerList.isEmpty()) {
                    for (Customer c : customerList) {
            %>
            <tr>
                <td><%= c.getCustomerID() %></td>
                <td><strong><%= c.getCustomerName() %></strong></td>
                <td><%= c.getEmail() %></td>
                <td><%= c.getPhone() != null ? c.getPhone() : "Chưa có" %></td>
                <td>
                    <div class="action-group">
                        <!-- Nút thăng cấp Admin -->
                        <a href="${pageContext.request.contextPath}/admin/users?action=promote&id=<%= c.getCustomerID() %>" 
                           class="btn-promote"
                           onclick="return confirm('Bạn có chắc chắn muốn cấp quyền Admin cho khách hàng này không?')">Cấp Admin</a>
                        
                        <!-- Nút Xóa -->
                        <a href="${pageContext.request.contextPath}/admin/users?action=delete&id=<%= c.getCustomerID() %>&type=customer" 
                           class="btn-delete"
                           onclick="return confirm('Bạn có chắc chắn muốn xóa khách hàng này?')">Xóa</a>
                    </div>
                </td>
            </tr>
            <% 
                    }
                } else {
            %>
            <tr>
                <td colspan="5" style="text-align: center; color: #888;">Chưa có khách hàng nào đăng ký</td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <!-- DANH SÁCH QUẢN TRỊ / NHÂN VIÊN -->
    <div class="section-title">DANH SÁCH BAN QUẢN TRỊ / NHÂN VIÊN</div>
    <table>
        <thead>
            <tr>
                <th style="width: 8%">ID</th>
                <th style="width: 38%">Tên quản trị viên</th>
                <th style="width: 34%">Email</th>
                <th style="width: 20%">Phép thuật</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<User> userList = (List<User>) request.getAttribute("userList");
                if (userList != null && !userList.isEmpty()) {
                    for (User u : userList) {
            %>
            <tr>
                <td><%= u.getId() %></td>
                <td><strong><%= u.getName() %></strong></td>
                <td><%= u.getEmail() %></td>
                <td>
                    <div class="action-group">
                        <a href="${pageContext.request.contextPath}/admin/users?action=delete&id=<%= u.getId() %>&type=user" 
                           class="btn-delete"
                           onclick="return confirm('Bạn có chắc chắn muốn xóa nhân viên này?')">Xóa</a>
                    </div>
                </td>
            </tr>
            <% 
                    }
                } else {
            %>
            <tr>
                <td colspan="4" style="text-align: center; color: #888;">Không có tài khoản quản trị nào</td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

</body>
</html>