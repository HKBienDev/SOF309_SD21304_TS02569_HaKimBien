<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng nhập - Cửa hàng WINX</title>
    <style>
        :root {
            --primary-pink: #ff69b4;       /* Hot Pink - Hồng đậm nổi bật */
            --dark-pink: #e04d98;          /* Hồng đậm hơn nữa khi hover chuột */
            --soft-bg: #fff0f5;             /* Lavender Blush - Nền hồng sáng nhẹ nhàng */
            --text-color: #3a3a3a;         /* Màu chữ dễ đọc */
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--soft-bg);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: var(--text-color);
        }

        .login-container {
            background-color: #ffffff;
            width: 360px;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(255, 105, 180, 0.3);
            box-sizing: border-box;
            text-align: center;
        }

        h2 {
            color: #d81b60;                /* Màu tiêu đề hồng đậm sắc sảo */
            margin-bottom: 25px;
            font-size: 26px;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .error-message {
            color: #c62828;
            background-color: #ffebee;
            padding: 10px;
            border-radius: 8px;
            border-left: 4px solid #c62828;
            font-size: 14px;
            text-align: left;
            margin-bottom: 20px;
        }

        .form-group {
            text-align: left;
            margin-bottom: 20px;
        }

        label {
            font-size: 14px;
            font-weight: 600;
            color: #555;
            display: block;
            margin-bottom: 6px;
        }

        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            border: 1.5px solid #ffb6c1;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s ease;
            outline: none;
            box-sizing: border-box;
            background-color: #fffafb;
        }

        input[type="email"]:focus,
        input[type="password"]:focus {
            border-color: var(--primary-pink);
            box-shadow: 0 0 8px rgba(255, 105, 180, 0.25);
            background-color: #fff;
        }

        button[type="submit"] {
            width: 100%;
            padding: 13px;
            background-color: var(--primary-pink);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(255, 105, 180, 0.4);
            margin-top: 10px;
        }

        button[type="submit"]:hover {
            background-color: var(--dark-pink);
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(224, 77, 152, 0.5);
        }

        button[type="submit"]:active {
            transform: translateY(1px);
        }

        .footer-links {
            margin-top: 25px;
            font-size: 14px;
            color: #777;
        }

        .footer-links a {
            color: #d81b60;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s;
        }

        .footer-links a:hover {
            color: var(--dark-pink);
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h2>ĐĂNG NHẬP</h2>
        
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" value="<%= request.getAttribute("oldEmail") != null ? request.getAttribute("oldEmail") : "" %>" placeholder="Nhập địa chỉ email..." required>
            </div>
            
            <div class="form-group">
                <label>Mật khẩu</label>
                <input type="password" name="password" placeholder="Nhập mật khẩu..." required>
            </div>
            
            <button type="submit">Đăng nhập</button>
        </form>
        
        <div class="footer-links">
            Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
        </div>
    </div>

</body>
</html>