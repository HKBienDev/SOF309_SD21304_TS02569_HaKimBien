<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng ký - Cửa hàng WINX</title>
    <style>
        :root {
            --primary-pink: #ff69b4;
            --dark-pink: #e04d98;
            --soft-bg: #fff0f5;
            --text-color: #3a3a3a;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--soft-bg);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: var(--text-color);
        }

        .register-container {
            background-color: #ffffff;
            width: 360px;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(255, 105, 180, 0.3);
            box-sizing: border-box;
            text-align: center;
            margin: 20px 0;
        }

        h2 {
            color: #d81b60;
            margin-bottom: 20px;
            font-size: 26px;
            font-weight: 700;
        }

        .message {
            padding: 10px;
            border-radius: 8px;
            font-size: 14px;
            text-align: left;
            margin-bottom: 15px;
        }
        .error { color: #c62828; background-color: #ffebee; border-left: 4px solid #c62828; }
        .success { color: #2e7d32; background-color: #e8f5e9; border-left: 4px solid #2e7d32; }

        .form-group {
            text-align: left;
            margin-bottom: 15px;
        }

        label {
            font-size: 14px;
            font-weight: 600;
            color: #555;
            display: block;
            margin-bottom: 4px;
        }

        input {
            width: 100%;
            padding: 10px 12px;
            border: 1.5px solid #ffb6c1;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            box-sizing: border-box;
            background-color: #fffafb;
        }

        input:focus {
            border-color: var(--primary-pink);
            box-shadow: 0 0 8px rgba(255, 105, 180, 0.25);
        }

        button[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: var(--primary-pink);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 4px 12px rgba(255, 105, 180, 0.4);
            margin-top: 10px;
        }

        button[type="submit"]:hover {
            background-color: var(--dark-pink);
        }

        .footer-links {
            margin-top: 20px;
            font-size: 14px;
            color: #777;
        }

        .footer-links a {
            color: #d81b60;
            text-decoration: none;
            font-weight: 600;
        }
    </style>
</head>
<body>

    <div class="register-container">
        <h2> ĐĂNG KÝ </h2>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="message error"><%= request.getAttribute("error") %></div>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
            <div class="message success"><%= request.getAttribute("success") %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <label>Họ và tên</label>
                <input type="text" name="name" value="${param.name}" required placeholder="Nhập họ tên...">
            </div>

            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" value="${param.email}" required placeholder="Nhập email...">
            </div>
            
            <!-- THÊM Ô NHẬP SỐ ĐIỆN THOẠI -->
            <div class="form-group">
                <label>Số điện thoại</label>
                <input type="tel" name="phone" value="${param.phone}" required placeholder="Nhập số điện thoại...">
            </div>

            <div class="form-group">
                <label>Mật khẩu</label>
                <input type="password" name="password" required placeholder="Nhập mật khẩu...">
            </div>
            
            <button type="submit">Đăng ký tài khoản</button>
        </form>
        
        <div class="footer-links">
            Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập ngay</a>
        </div>
    </div>

</body>
</html>