<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WINX ENCHANTIX - ADMIN</title>

<!-- FontAwesome & Google Fonts -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
    :root {
        --primary-pink: #ff69b4;       /* Hot Pink */
        --dark-pink: #e04d98;          /* Hồng đậm hover */
        --light-pink: #fff0f5;         /* Lavender Blush - Nền nhẹ */
        --sidebar-bg: #fff5f8;         /* Nền sidebar hồng nhạt */
        --card-bg: #ffffff;            /* Nền thẻ trắng */
        --text-main: #4a4a4a;          /* Màu chữ chính */
        --accent-pink: #ff1493;        /* Deep Pink */
        --shadow-color: rgba(255, 105, 180, 0.15);
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', 'Segoe UI', sans-serif;
    }

    body {
        background-color: var(--light-pink);
        color: var(--text-main);
        display: flex;
        min-height: 100vh;
    }

    a { 
        text-decoration: none; 
        color: inherit; 
        display: block; 
    }
    
    li { 
        list-style: none; 
    }

    /* ================= SIDEBAR ================= */
    .sidebar {
        width: 260px;
        background-color: var(--sidebar-bg);
        border-right: 2px solid #ffe1ec;
        padding: 25px 15px;
        display: flex;
        flex-direction: column;
        box-shadow: 4px 0 15px var(--shadow-color);
        z-index: 10;
    }

    .sidebar .logo {
        text-align: center;
        padding-bottom: 25px;
        border-bottom: 2px dashed #ffb6c1;
        margin-bottom: 25px;
    }

    .sidebar .logo h2 {
        color: var(--accent-pink);
        font-size: 28px;
        font-weight: 700;
        letter-spacing: 2px;
        text-shadow: 1px 1px 2px rgba(255, 20, 147, 0.2);
    }

    .sidebar .logo span {
        color: var(--primary-pink);
        font-size: 13px;
        font-weight: 600;
        letter-spacing: 3px;
    }

    .sidebar ul li {
        margin-bottom: 8px;
    }

    .sidebar ul li a {
        display: flex;
        align-items: center;
        padding: 12px 18px;
        color: #666;
        font-weight: 500;
        border-radius: 12px;
        transition: all 0.3s ease;
    }

    .sidebar ul li a i {
        margin-right: 14px;
        font-size: 18px;
        color: var(--primary-pink);
        transition: all 0.3s ease;
    }

    .sidebar ul li a:hover,
    .sidebar ul li.active a {
        background-color: var(--primary-pink);
        color: #ffffff;
        box-shadow: 0 4px 12px rgba(255, 105, 180, 0.4);
        transform: translateX(4px);
    }

    .sidebar ul li a:hover i,
    .sidebar ul li.active a i {
        color: #ffffff;
    }

    /* Nút Đăng xuất nổi bật */
    .sidebar ul li:last-child a:hover {
        background-color: #ff4d4d;
        box-shadow: 0 4px 12px rgba(255, 77, 77, 0.4);
    }

    /* ================= MAIN CONTENT ================= */
    .main {
        flex: 1;
        padding: 30px;
        display: flex;
        flex-direction: column;
        gap: 30px;
    }

    /* TOPBAR */
    .topbar {
        background: linear-gradient(135deg, #ffffff 0%, #fff0f5 100%);
        padding: 20px 30px;
        border-radius: 16px;
        border: 1px solid #ffe1ec;
        box-shadow: 0 4px 15px var(--shadow-color);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .topbar h1 {
        color: #d81b60;
        font-size: 26px;
        font-weight: 700;
    }

    .topbar p {
        color: #888;
        font-size: 13px;
        margin-top: 2px;
        letter-spacing: 0.5px;
    }

    /* DASHBOARD CARDS */
    .dashboard {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        gap: 25px;
    }

    .dashboard .box {
        background-color: var(--card-bg);
        padding: 25px 20px;
        border-radius: 20px;
        border: 1px solid #ffe1ec;
        box-shadow: 0 8px 20px var(--shadow-color);
        display: flex;
        align-items: center;
        gap: 20px;
        position: relative;
        overflow: hidden;
        transition: all 0.3s ease;
    }

    .dashboard .box:hover {
        transform: translateY(-5px);
        box-shadow: 0 12px 25px rgba(255, 105, 180, 0.25);
    }

    /* Thêm viền gradient trang trí góc card */
    .dashboard .box::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 6px;
        height: 100%;
        background: linear-gradient(to bottom, var(--primary-pink), var(--accent-pink));
    }

    .dashboard .box .icon-box {
        width: 60px;
        height: 60px;
        background-color: #fff0f5;
        border-radius: 15px;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 24px;
        color: var(--accent-pink);
    }

    .dashboard .box .info h2 {
        color: var(--accent-pink);
        font-size: 32px;
        font-weight: 700;
        line-height: 1;
    }

    .dashboard .box .info p {
        color: #777;
        font-size: 15px;
        font-weight: 500;
        margin-top: 6px;
    }
</style>

</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">

    <div class="logo">
        <h2>WINX</h2>
        <span>ENCHANTIX</span>
    </div>

    <ul>

        <li class="active">
            <a href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fa fa-home"></i> Trang chủ
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/admin/products">
                <i class="fa fa-boxes-packing"></i> Sản phẩm
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/admin/order">
                <i class="fa fa-layer-group"></i> Đơn hàng
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/admin/users">
                <i class="fa fa-users"></i> Khách hàng
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/admin/news">
                <i class="fa fa-newspaper"></i> Tin tức
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/admin/revenue">
                <i class="fa fa-chart-simple"></i> Thống kê
            </a>
        </li>

        <li>
				<a href="${pageContext.request.contextPath}/logout">
				    <i class="fa fa-right-from-bracket"></i> Đăng xuất
				</a>
        </li>

    </ul>

</div>

<!-- MAIN CONTENT -->
<div class="main">

    <div class="topbar">
        <div>
            <h1>Trang chủ Admin</h1>
            <p>WINX ENCHANTIX ADMIN</p>
        </div>
    </div>

    <div class="dashboard">

        <div class="box">
            <div class="icon-box">
                <i class="fa fa-boxes-packing"></i>
            </div>
            <div class="info">
                <h2>120</h2>
                <p>Sản phẩm</p>
            </div>
        </div>

        <div class="box">
            <div class="icon-box">
                <i class="fa fa-layer-group"></i>
            </div>
            <div class="info">
                <h2>45</h2>
                <p>Đơn hàng</p>
            </div>
        </div>

        <div class="box">
            <div class="icon-box">
                <i class="fa fa-users"></i>
            </div>
            <div class="info">
                <h2>30</h2>
                <p>Khách hàng</p>
            </div>
        </div>

    </div>

</div>

</body>
</html>