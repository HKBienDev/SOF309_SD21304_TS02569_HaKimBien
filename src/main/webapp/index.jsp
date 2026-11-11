<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WINX Cosmetics | Mỹ Phẩm Cao Cấp</title>

<!-- Google Fonts & FontAwesome -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<style>
:root {
	--pink-gradient: linear-gradient(135deg, #ff758c 0%, #ff7eb3 100%);
	--pink-soft: #fff0f5;
	--pink-light: #ffe3ec;
	--pink-main: #ff5277;
	--pink-dark: #d81b60;
	--text-color: #4a4a4a;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

body {
	background-color: #fff8fa;
	color: var(--text-color);
}

.container {
	width: 90%;
	max-width: 1200px;
	margin: 0 auto;
}

/* 1. Top Bar */
.top-bar {
	background: var(--pink-soft);
	border-bottom: 1px solid var(--pink-light);
	font-size: 13px;
	padding: 8px 0;
}

.top-bar .container {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.top-left, .top-right {
	color: var(--pink-dark);
	font-weight: 500;
}

.top-left i, .top-right i {
	margin-right: 6px;
}

/* 2. Header */
.header {
	background: #ffffff;
	padding: 20px 0;
	box-shadow: 0 4px 15px rgba(255, 117, 140, 0.08);
}

.header-content {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.logo a {
	font-size: 28px;
	font-weight: 700;
	color: var(--pink-dark);
	text-decoration: none;
	letter-spacing: 1px;
}

.search-box form {
	display: flex;
	align-items: center;
	background: var(--pink-soft);
	border: 1px solid var(--pink-light);
	border-radius: 25px;
	padding: 6px 8px 6px 20px;
	width: 520px;
	transition: all 0.3s ease;
}

.search-box form:focus-within {
	border-color: var(--pink-main);
	box-shadow: 0 0 10px rgba(255, 82, 119, 0.15);
}

.search-box input {
	border: none;
	background: transparent;
	outline: none;
	width: 100%;
	font-size: 14px;
	color: var(--text-color);
}

.search-box button {
	background: var(--pink-gradient);
	border: none;
	color: #fff;
	width: 36px;
	height: 36px;
	border-radius: 50%;
	cursor: pointer;
	transition: transform 0.2s;
	flex-shrink: 0;
}

.search-box button:hover {
	transform: scale(1.05);
}

.header-actions {
	display: flex;
	align-items: center;
	gap: 10px;
}

.btn-action {
	color: var(--pink-dark);
	text-decoration: none;
	font-weight: 600;
	font-size: 14px;
	display: flex;
	align-items: center;
	gap: 6px;
	background: var(--pink-soft);
	padding: 8px 14px;
	border-radius: 20px;
	border: 1px solid var(--pink-light);
	transition: all 0.3s ease;
	white-space: nowrap;
}

.btn-action:hover {
	background: var(--pink-gradient);
	color: #fff;
	border-color: transparent;
}

.btn-action.btn-primary {
	background: var(--pink-gradient);
	color: #ffffff;
	border: none;
}

.btn-action.btn-primary:hover {
	opacity: 0.9;
}

.user-dropdown {
	display: flex;
	align-items: center;
	gap: 8px;
	background: var(--pink-soft);
	padding: 8px 14px;
	border-radius: 20px;
	border: 1px solid var(--pink-light);
}

.user-info {
	color: var(--pink-dark);
	font-weight: 600;
	font-size: 14px;
}

.btn-logout {
	color: var(--pink-dark);
	text-decoration: none;
	margin-left: 5px;
}

/* 3. Navbar */
.navbar {
	background: var(--pink-gradient);
	box-shadow: 0 4px 10px rgba(255, 117, 140, 0.2);
	position: sticky;
	top: 0;
	z-index: 1000;
}

.navbar .container {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.navbar ul {
	list-style: none;
	display: flex;
	align-items: center;
	gap: 2px;
}

.navbar li a {
	display: flex;
	align-items: center;
	gap: 6px;
	padding: 12px 14px;
	color: #ffffff;
	text-decoration: none;
	font-weight: 500;
	font-size: 14px;
	white-space: nowrap;
	transition: background 0.3s;
	border-radius: 6px;
}

.navbar li a:hover, .navbar li a.active {
	background: rgba(255, 255, 255, 0.2);
}

.navbar-hotline {
	color: #fff;
	font-weight: 600;
	font-size: 13.5px;
	display: flex;
	align-items: center;
	gap: 6px;
	background: rgba(0, 0, 0, 0.12);
	padding: 6px 14px;
	border-radius: 20px;
	white-space: nowrap;
	flex-shrink: 0;
}

/* 4. Banner & Intro Section */
.hero-section {
	margin: 25px auto;
	display: grid;
	grid-template-columns: 2fr 1fr;
	gap: 20px;
}

.banner-slider {
	width: 100%;
	height: 280px;
	border-radius: 16px;
	overflow: hidden;
	box-shadow: 0 8px 20px rgba(255, 117, 140, 0.15);
	background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%);
	position: relative;
	display: flex;
	align-items: center;
	justify-content: center;
}

.banner-slider img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.banner-fallback {
	position: absolute;
	text-align: center;
	color: #fff;
	padding: 20px;
	text-shadow: 0 2px 4px rgba(0,0,0,0.15);
}

.banner-fallback h2 {
	font-size: 24px;
	font-weight: 700;
	margin-bottom: 8px;
}

.store-intro {
	background: #ffffff;
	border-radius: 16px;
	padding: 24px;
	border: 1px solid var(--pink-light);
	box-shadow: 0 8px 20px rgba(255, 117, 140, 0.08);
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.store-intro h3 {
	color: var(--pink-dark);
	font-size: 18px;
	margin-bottom: 12px;
	font-weight: 700;
}

.store-intro p {
	font-size: 13px;
	line-height: 1.6;
	color: #666;
	margin-bottom: 16px;
}

.intro-features {
	list-style: none;
}

.intro-features li {
	font-size: 13px;
	color: var(--text-color);
	margin-bottom: 8px;
	display: flex;
	align-items: center;
	gap: 8px;
}

.intro-features i {
	color: var(--pink-main);
}

/* 5. Main Layout */
.main-content {
	display: flex;
	gap: 30px;
	margin-bottom: 50px;
}

/* Sidebar */
.sidebar {
	width: 260px;
	flex-shrink: 0;
	background: #ffffff;
	padding: 20px;
	border-radius: 16px;
	border: 1px solid var(--pink-light);
	box-shadow: 0 6px 18px rgba(255, 117, 140, 0.06);
	height: fit-content;
}

.sidebar h3 {
	color: var(--pink-dark);
	font-size: 18px;
	margin-bottom: 15px;
	padding-bottom: 10px;
	border-bottom: 2px solid var(--pink-soft);
	font-weight: 700;
}

.sidebar ul {
	list-style: none;
}

.sidebar li a {
	display: block;
	padding: 10px 12px;
	color: var(--text-color);
	text-decoration: none;
	border-radius: 8px;
	font-size: 14px;
	transition: all 0.2s ease;
}

.sidebar li a:hover {
	background: var(--pink-soft);
	color: var(--pink-dark);
	font-weight: 600;
	padding-left: 18px;
}

/* Main Display Area (Products, News & About) */
.content-area {
	flex-grow: 1;
}

.content-area h2 {
	color: var(--pink-dark);
	font-size: 22px;
	margin-bottom: 20px;
	position: relative;
	padding-bottom: 8px;
	font-weight: 700;
}

.content-area h2::after {
	content: '';
	position: absolute;
	bottom: 0;
	left: 0;
	width: 60px;
	height: 3px;
	background: var(--pink-gradient);
	border-radius: 2px;
}

/* Product Card Grid */
.product-list {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
	gap: 20px;
}

.product-card {
	background: #ffffff;
	border-radius: 16px;
	padding: 15px;
	text-align: center;
	border: 1px solid var(--pink-light);
	box-shadow: 0 6px 15px rgba(255, 117, 140, 0.05);
	transition: all 0.3s ease;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.product-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 12px 25px rgba(255, 117, 140, 0.18);
}

.product-card .img-box {
	width: 100%;
	aspect-ratio: 1 / 1;
	overflow: hidden;
	border-radius: 10px;
	margin-bottom: 12px;
	background-color: #fafafa;
}

.product-card img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: transform 0.3s ease;
}

.product-card:hover img {
	transform: scale(1.05);
}

.product-card h4 {
	font-size: 14px;
	color: var(--text-color);
	margin-bottom: 8px;
	font-weight: 600;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
	height: 2.8em;
	line-height: 1.4;
}

.product-card .price {
	color: var(--pink-dark);
	font-size: 16px;
	font-weight: 700;
	margin-bottom: 12px;
}

.btn-cart {
	display: block;
	width: 100%;
	background: var(--pink-gradient);
	color: #ffffff;
	text-decoration: none;
	padding: 10px 0;
	border: none;
	border-radius: 10px;
	font-size: 14px;
	font-weight: 600;
	box-shadow: 0 4px 12px rgba(255, 117, 140, 0.3);
	cursor: pointer;
	transition: opacity 0.2s;
}

.btn-cart:hover {
	opacity: 0.9;
}

/* News Cards Inside Main Layout */
.news-list {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
}

.news-card {
    background: #ffffff;
    border-radius: 16px;
    overflow: hidden;
    border: 1px solid var(--pink-light);
    box-shadow: 0 6px 18px rgba(255, 117, 140, 0.08);
    transition: all 0.3s ease;
    display: flex;
    flex-direction: column;
    height: 100%;
}

.news-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 12px 25px rgba(255, 117, 140, 0.18);
}

.news-img-box {
    width: 100%;
    height: 180px;
    flex-shrink: 0;
    overflow: hidden;
    background-color: #f7f7f7;
}

.news-img-box img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.4s ease;
}

.news-card:hover .news-img-box img {
    transform: scale(1.05);
}

.news-content {
    padding: 15px 20px;
    display: flex;
    flex-direction: column;
    flex-grow: 1;
}

.news-date {
    font-size: 12px;
    color: #888;
    margin-bottom: 6px;
    display: flex;
    align-items: center;
    gap: 6px;
}

.news-title {
    font-size: 16px;
    color: var(--pink-dark);
    font-weight: 700;
    margin-bottom: 8px;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.news-summary {
    font-size: 13.5px;
    color: #666;
    line-height: 1.5;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

/* Responsive cho màn hình nhỏ */
@media (max-width: 992px) {
    .news-list {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 576px) {
    .news-list {
        grid-template-columns: 1fr;
    }
}

/* Styles Cho Trang Giới Thiệu */
.about-box {
	background: #ffffff;
	border-radius: 16px;
	padding: 30px;
	border: 1px solid var(--pink-light);
	box-shadow: 0 6px 18px rgba(255, 117, 140, 0.08);
	line-height: 1.7;
	color: var(--text-color);
}

.about-box h3 {
	color: var(--pink-dark);
	font-size: 18px;
	margin: 20px 0 10px 0;
	font-weight: 600;
}

.about-box p {
	font-size: 14px;
	margin-bottom: 15px;
	color: #555;
}

.about-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
	gap: 20px;
	margin-top: 25px;
}

.about-card {
	background: var(--pink-soft);
	padding: 20px;
	border-radius: 12px;
	border: 1px solid var(--pink-light);
	text-align: center;
}

.about-card i {
	font-size: 30px;
	color: var(--pink-main);
	margin-bottom: 10px;
}

.about-card h4 {
	color: var(--pink-dark);
	font-size: 15px;
	margin-bottom: 8px;
}

.about-card p {
	font-size: 13px;
	margin-bottom: 0;
}

/* ========================================= */
/* CSS BỔ SUNG CHO TRANG LIÊN HỆ & THẮC MẮC */
/* ========================================= */
.contact-container {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 25px;
	margin-bottom: 30px;
}

.contact-card-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 15px;
	margin-bottom: 25px;
}

.contact-info-card {
	background: #ffffff;
	border: 1px solid var(--pink-light);
	padding: 20px;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(255, 117, 140, 0.05);
	display: flex;
	align-items: flex-start;
	gap: 12px;
}

.contact-info-card i {
	font-size: 24px;
	color: var(--pink-main);
	background: var(--pink-soft);
	padding: 12px;
	border-radius: 50%;
}

.contact-info-card h4 {
	font-size: 14px;
	color: var(--pink-dark);
	margin-bottom: 4px;
}

.contact-info-card p {
	font-size: 13px;
	color: #666;
	margin: 0;
	line-height: 1.4;
}

.contact-form-box {
	background: #ffffff;
	padding: 25px;
	border-radius: 16px;
	border: 1px solid var(--pink-light);
	box-shadow: 0 6px 18px rgba(255, 117, 140, 0.08);
}

.contact-form-box h3 {
	color: var(--pink-dark);
	font-size: 18px;
	margin-bottom: 15px;
	font-weight: 700;
}

.form-group {
	margin-bottom: 15px;
}

.form-group label {
	display: block;
	font-size: 13px;
	font-weight: 600;
	margin-bottom: 5px;
	color: var(--text-color);
}

.form-group input, .form-group select, .form-group textarea {
	width: 100%;
	padding: 10px 14px;
	border: 1px solid var(--pink-light);
	border-radius: 8px;
	font-size: 13.5px;
	outline: none;
	background: var(--pink-soft);
	transition: all 0.3s ease;
}

.form-group input:focus, .form-group select:focus, .form-group textarea:focus {
	border-color: var(--pink-main);
	background: #ffffff;
	box-shadow: 0 0 8px rgba(255, 82, 119, 0.15);
}

.btn-submit-contact {
	width: 100%;
	background: var(--pink-gradient);
	color: #ffffff;
	border: none;
	padding: 12px;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	transition: opacity 0.2s;
}

.btn-submit-contact:hover {
	opacity: 0.9;
}

.faq-section {
	background: #ffffff;
	padding: 25px;
	border-radius: 16px;
	border: 1px solid var(--pink-light);
	box-shadow: 0 6px 18px rgba(255, 117, 140, 0.08);
	margin-bottom: 25px;
}

.faq-section h3 {
	color: var(--pink-dark);
	font-size: 18px;
	margin-bottom: 15px;
	font-weight: 700;
}

.faq-item {
	margin-bottom: 12px;
	border-bottom: 1px dashed var(--pink-light);
	padding-bottom: 10px;
}

.faq-item:last-child {
	border-bottom: none;
}

.faq-title {
	font-size: 14px;
	font-weight: 600;
	color: var(--pink-dark);
	margin-bottom: 4px;
	display: flex;
	align-items: center;
	gap: 8px;
}

.faq-desc {
	font-size: 13px;
	color: #666;
	line-height: 1.5;
}

.map-container {
	border-radius: 16px;
	overflow: hidden;
	border: 1px solid var(--pink-light);
	box-shadow: 0 6px 18px rgba(255, 117, 140, 0.08);
	height: 300px;
}

@media (max-width: 768px) {
	.contact-container {
		grid-template-columns: 1fr;
	}
	.contact-card-grid {
		grid-template-columns: 1fr;
	}
}

/* 6. Footer */
.footer {
	background: #2b2b2b;
	color: #e0e0e0;
	padding-top: 50px;
	margin-top: 60px;
	font-size: 13.5px;
}

.footer-content {
	display: grid;
	grid-template-columns: 1.2fr 1fr 1fr 1.2fr;
	gap: 30px;
	padding-bottom: 40px;
}

.footer-col h3.footer-logo {
	color: #ff758c;
	font-size: 22px;
	font-weight: 700;
	letter-spacing: 1px;
	margin-bottom: 12px;
}

.footer-col h4 {
	color: #ffffff;
	font-size: 15px;
	font-weight: 600;
	margin-bottom: 18px;
	position: relative;
	padding-bottom: 8px;
}

.footer-col h4::after {
	content: '';
	position: absolute;
	bottom: 0;
	left: 0;
	width: 35px;
	height: 2px;
	background: var(--pink-main);
	border-radius: 2px;
}

.footer-col p {
	line-height: 1.6;
	color: #b0b0b0;
	margin-bottom: 10px;
}

.footer-col ul {
	list-style: none;
}

.footer-col ul li {
	margin-bottom: 10px;
}

.footer-col ul li a {
	color: #b0b0b0;
	text-decoration: none;
	transition: all 0.2s ease;
}

.footer-col ul li a:hover {
	color: #ff758c;
	padding-left: 5px;
}

.social-links {
	display: flex;
	gap: 12px;
	margin-top: 15px;
}

.social-links a {
	width: 36px;
	height: 36px;
	background: #3a3a3a;
	color: #fff;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	text-decoration: none;
	transition: all 0.3s ease;
}

.social-links a:hover {
	background: var(--pink-gradient);
	transform: translateY(-3px);
}

.contact-col p {
	display: flex;
	align-items: center;
	gap: 10px;
}

.contact-col i {
	color: #ff758c;
	font-size: 15px;
}

.payment-methods {
	display: flex;
	gap: 15px;
	font-size: 24px;
	color: #d0d0d0;
	margin-top: 15px;
}

.footer-bottom {
	background: #1f1f1f;
	padding: 15px 0;
	text-align: center;
	border-top: 1px solid #383838;
	font-size: 13px;
	color: #888888;
}

.footer-bottom i {
	color: #ff5277;
}

.custom-scrollbar::-webkit-scrollbar {
        width: 6px;
    }
    .custom-scrollbar::-webkit-scrollbar-track {
        background: #fff0f5;
        border-radius: 10px;
    }
    .custom-scrollbar::-webkit-scrollbar-thumb {
        background: #ffb6c1;
        border-radius: 10px;
    }
    .custom-scrollbar::-webkit-scrollbar-thumb:hover {
        background: #ff4d6d;
    }
</style>
</head>
<body>

<!-- 1. Top Bar -->
<div class="top-bar">
    <div class="container">
        <div class="top-left">
            <i class="fa-solid fa-truck"></i> Miễn phí vận chuyển cho đơn từ 500.000đ
        </div>
        <div class="top-right">
            <i class="fa-solid fa-clock"></i> Giờ mở cửa: 8:00 - 22:00 Hằng ngày
        </div>
    </div>
</div>

<!-- 2. Header -->
<header class="header">
    <div class="container header-content">

        <div class="logo">
            <a href="${pageContext.request.contextPath}/products">WINX</a>
        </div>

        <div class="search-box">
            <form action="${pageContext.request.contextPath}/products" method="get">
                <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm mỹ phẩm...">
                <button type="submit">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </button>
            </form>
        </div>

        <div class="header-actions">
            <!-- Nút Lịch sử đơn hàng đã chuyển lên đây -->
            <a href="${pageContext.request.contextPath}/order-history" class="btn-action ${viewPage == 'order-history' ? 'active' : ''}"> 
                <i class="fa-solid fa-clock-rotate-left"></i> Lịch sử đơn hàng
            </a>

            <a href="${pageContext.request.contextPath}/cart?action=view" class="btn-action"> 
                <i class="fa-solid fa-cart-shopping"></i> Giỏ hàng
            </a>

            <c:choose>
                <c:when test="${not empty sessionScope.currentUser}">
                    <div class="user-dropdown">
                        <span class="user-info"> 
                            <i class="fa-solid fa-user"></i>
                            <c:out value="${sessionScope.currentUser.customerName != null ? sessionScope.currentUser.customerName : sessionScope.currentUser.name}" />
                        </span> 
                        <a href="${pageContext.request.contextPath}/logout" class="btn-logout" title="Đăng xuất"> 
                            <i class="fa-solid fa-right-from-bracket"></i>
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn-action"> 
                        <i class="fa-solid fa-right-to-bracket"></i> Đăng nhập
                    </a>
                    <a href="${pageContext.request.contextPath}/register" class="btn-action btn-primary"> 
                        <i class="fa-solid fa-user-plus"></i> Đăng ký
                    </a>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</header>

<!-- 3. Menu Navbar -->
<nav class="navbar">
    <div class="container">
        <ul>
            <li><a href="${pageContext.request.contextPath}/home"><i class="fa-solid fa-house"></i> Trang chủ</a></li>
            <li><a href="${pageContext.request.contextPath}/products"><i class="fa-solid fa-store"></i> Sản phẩm</a></li>
            
            <!-- Sửa href tại đây để trỏ vào Servlet BestSeller -->
            <li><a href="${pageContext.request.contextPath}/best-sellers" class="${viewPage == 'best-sellers' ? 'active' : ''}"><i class="fa-solid fa-fire"></i> Bán chạy</a></li>
            
            <li><a href="${pageContext.request.contextPath}/promotion" class="${viewPage == 'promotion' ? 'active' : ''}"><i class="fa-solid fa-percent"></i> Khuyến mãi</a></li>
            <li><a href="${pageContext.request.contextPath}/news" class="${viewPage == 'news' ? 'active' : ''}"><i class="fa-regular fa-newspaper"></i> Tin tức</a></li>
            <li><a href="${pageContext.request.contextPath}/about" class="${viewPage == 'about' ? 'active' : ''}"><i class="fa-solid fa-circle-info"></i> Giới thiệu</a></li>
            <li><a href="${pageContext.request.contextPath}/contact" class="${viewPage == 'contact' ? 'active' : ''}"><i class="fa-solid fa-headset"></i> Liên hệ</a></li>
        </ul>

        <div class="navbar-hotline">
            <i class="fa-solid fa-phone-volume"></i> Hotline: 1900 3667
        </div>
    </div>
</nav>

<!-- 4. Banner + Khung Giới thiệu -->
<c:if test="${viewPage == 'home' || empty viewPage}">
    <section class="hero-section container">
        <div class="banner-slider">
            <img src="${pageContext.request.contextPath}/assets/images/Banner.png"
                alt="Banner Mỹ Phẩm WINX"
                onerror="this.style.display='none'; document.getElementById('banner-fallback').style.display='block';">
            
            <div id="banner-fallback" class="banner-fallback" style="display: none;">
                <h2>TỎA SÁNG CÙNG WINX COSMETICS</h2>
                <p>Mỹ phẩm chính hãng - Nâng niu làn da Việt</p>
            </div>
        </div>

        <div class="store-intro">
            <h3><i class="fa-solid fa-sparkles"></i> Về WINX Cosmetics</h3>
            <p>Thương hiệu chuyên cung cấp các sản phẩm chăm sóc da và trang điểm chính hãng, nâng niu vẻ đẹp tự nhiên của bạn.</p>
            <ul class="intro-features">
                <li><i class="fa-solid fa-circle-check"></i> 100% Sản phẩm chính hãng</li>
                <li><i class="fa-solid fa-circle-check"></i> Tư vấn da chuyên sâu miễn phí</li>
                <li><i class="fa-solid fa-circle-check"></i> Đổi trả dễ dàng trong 7 ngày</li>
            </ul>
        </div>
    </section>
</c:if>

<!-- 5. Main Content -->
<div class="container main-content">
<%-- CHỈ HIỂN THỊ SIDEBAR DANH MỤC Ở TRANG CHỦ, BÁN CHẠY, KHUYẾN MÃI VÀ SẢN PHẨM --%>
<c:if test="${viewPage == 'home' || viewPage == 'products' || empty viewPage}">
    <!-- Sidebar Danh Mục (Bên trái) -->
    <aside class="sidebar">
        <h3>Danh mục</h3>
        <ul>
            <c:if test="${empty categories}">
                <li><span style="font-size:13px; color:#888;">Đang cập nhật danh mục...</span></li>
            </c:if>
            <c:forEach var="category" items="${categories}">
                <li>
                    <a href="${pageContext.request.contextPath}/products?category=${category.categoryID}">
                        <c:out value="${category.categoryName}" />
                    </a>
                </li>
            </c:forEach>
        </ul>
    </aside>
</c:if>
    

    <!-- Khung Hiển Thị Nội Dụng Chính -->
    <section class="content-area" style="${(viewPage == 'products' || viewPage == 'news' || viewPage == 'about' || viewPage == 'contact' || viewPage == 'order-history' || viewPage == 'order-success') ? 'width: 100%;' : ''}">
        <c:choose>

<%-- KHI ĐẶT HÀNG THÀNH CÔNG (${viewPage == 'order-success'}) --%>
            <c:when test="${viewPage == 'order-success'}">
                <div style="display: flex; justify-content: center; align-items: center; padding: 40px 0; width: 100%;">
                    <div style="background: #fff; padding: 40px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); text-align: center; max-width: 550px; width: 100%;">
                        <div style="font-size: 50px; color: #ff4d6d; margin-bottom: 20px;">
                            <i class="fa-solid fa-circle-check"></i>
                        </div>
                        <h2 style="color: #d90429; margin-bottom: 15px;">ĐẶT HÀNG THÀNH CÔNG!</h2>
                        <p style="color: #666; line-height: 1.6; margin-bottom: 10px;">
                            Mã đơn hàng của bạn: <strong>#<c:out value="${orderID}"/></strong>
                        </p>
                        <p style="color: #666; line-height: 1.6; margin-bottom: 25px;">
                            Cảm ơn quý khách đã đặt hàng tại WINX Cosmetics. Chúng tôi sẽ liên lạc xác nhận và giao hàng trong thời gian sớm nhất.
                        </p>
                        <div style="display: flex; gap: 12px; justify-content: center;">
                            <a href="${pageContext.request.contextPath}/order-history" style="background: #ff4d6d; color: white; padding: 10px 20px; border-radius: 6px; text-decoration: none; font-weight: 500; display: inline-flex; align-items: center; gap: 8px;">
                                <i class="fa-solid fa-clock-rotate-left"></i> Xem lịch sử đơn hàng
                            </a>
                            <a href="${pageContext.request.contextPath}/home" style="background: #f8f9fa; color: #333; padding: 10px 20px; border-radius: 6px; text-decoration: none; font-weight: 500; border: 1px solid #ddd; display: inline-flex; align-items: center; gap: 8px;">
                                <i class="fa-solid fa-house"></i> Về trang chủ
                            </a>
                        </div>
                    </div>
                </div>
            </c:when>

<%-- KHI BẤM VÀO LỊCH SỬ ĐƠN HÀNG (${viewPage == 'order-history'}) --%>
            <c:when test="${viewPage == 'order-history'}">
                <h2><i class="fa-solid fa-clock-rotate-left" style="color: #e91e63;"></i> Lịch Sử Đơn Hàng Của Bạn</h2>

                <div class="order-history-container" style="margin-top: 20px;">
                    <c:if test="${empty orderList}">
                        <p style="text-align: center; color: #777; padding: 40px 0;">
                            Bạn chưa có đơn hàng nào. Hãy mua sắm ngay nhé!
                        </p>
                    </c:if>

                    <c:if test="${not empty orderList}">
                        <c:forEach var="order" items="${orderList}">
                            <!-- Thẻ chứa từng đơn hàng -->
                            <div style="background: #fff; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); margin-bottom: 20px; overflow: hidden; border: 1px solid #eee;">
                                
                                <!-- Header Đơn hàng -->
                                <div style="background-color: #f8f9fa; padding: 12px 15px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #dee2e6;">
                                    <div>
                                        <strong style="color: #e91e63; font-size: 16px;">Mã đơn: #${order.orderID}</strong>
                                        <span style="color: #666; margin-left: 15px; font-size: 13px;">
                                            <i class="far fa-clock"></i> Ngày đặt: <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </span>
                                    </div>
                                    <div>
                                        <span style="padding: 5px 10px; border-radius: 4px; font-size: 12px; font-weight: 500; 
                                            ${order.status == 'Completed' || order.status == 'Đã hoàn thành' || order.status == 'Đã giao' ? 'background: #d4edda; color: #155724;' : 
                                              (order.status == 'Cancelled' || order.status == 'Đã hủy' ? 'background: #f8d7da; color: #721c24;' : 'background: #fff3cd; color: #856404;')}">
                                            <c:out value="${order.status}" />
                                        </span>
                                    </div>
                                </div>

                                <!-- Body Chi tiết đơn hàng -->
                                <div style="padding: 15px;">
                                    <div style="background: #f1f3f5; padding: 10px 12px; border-radius: 6px; font-size: 13px; color: #495057; margin-bottom: 15px;">
                                        <i class="fa-solid fa-truck-fast" style="color: #e91e63;"></i> 
                                        <strong>Vận chuyển:</strong> Giao hàng nhanh | 
                                        <strong>Mã vận đơn:</strong> <span style="color: #0d6efd;">SPM${order.orderID}9988</span> | 
                                        <strong>Hành trình:</strong> Đang trên đường giao đến bạn.
                                    </div>

                                    <!-- Danh sách sản phẩm trong đơn -->
                                    <table style="width: 100%; border-collapse: collapse; margin-bottom: 15px;">
                                        <thead>
                                            <tr style="color: #888; font-size: 13px; border-bottom: 1px solid #eee; text-align: left;">
                                                <th style="padding-bottom: 8px;">Sản phẩm</th>
                                                <th style="padding-bottom: 8px;">Phân loại</th>
                                                <th style="padding-bottom: 8px;">Số lượng</th>
                                                <th style="padding-bottom: 8px; text-align: right;">Giá tiền</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="detail" items="${order.orderDetails}">
                                                <tr style="border-bottom: 1px solid #f9f9f9; font-size: 14px;">
                                                    <td style="padding: 8px 0; display: flex; align-items: center;">
                                                        <img src="${detail.product.image.startsWith('http') ? detail.product.image : pageContext.request.contextPath.concat(detail.product.image.startsWith('/') ? '' : '/').concat(detail.product.image)}" 
                                                             alt="" style="width: 40px; height: 40px; object-fit: cover; border-radius: 4px; margin-right: 10px; border: 1px solid #ddd;"
                                                             onerror="this.src='https://via.placeholder.com/40';">
                                                        <span>${detail.product.productName}</span>
                                                    </td>
                                                    <td style="padding: 8px 0; color: #666;">Mặc định</td>
                                                    <td style="padding: 8px 0;">x${detail.quantity}</td>
                                                    <td style="padding: 8px 0; text-align: right;">
                                                        <fmt:formatNumber value="${detail.unitPrice}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                    <!-- Thông tin nhận hàng & Tổng tiền -->
                                    <div style="display: flex; justify-content: space-between; font-size: 13px; color: #555; background: #fafafa; padding: 10px; border-radius: 6px;">
                                        <div>
                                            <p style="margin: 0 0 4px 0;"><strong>Người nhận:</strong> ${order.customerName} - ${order.phone}</p>
                                            <p style="margin: 0 0 4px 0;"><strong>Địa chỉ:</strong> ${order.address}</p>
                                            <p style="margin: 0;"><strong>Thanh toán:</strong> ${not empty order.paymentMethod ? order.paymentMethod : 'COD (Thanh toán khi nhận hàng)'}</p>
                                        </div>
                                        <div style="text-align: right;">
                                            <p style="margin: 0 0 4px 0;">Phí vận chuyển: <strong>0 VNĐ</strong></p>
                                            <p style="margin: 0 0 4px 0;">Voucher giảm: <strong style="color: #dc3545;">-0 VNĐ</strong></p>
                                            <h4 style="margin: 5px 0 0 0; color: #e91e63; font-size: 16px;">
                                                Tổng thực trả: <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ
                                            </h4>
                                        </div>
                                    </div>
                                </div>

                                <!-- Footer: Các nút thao tác nhanh -->
                                <div style="background-color: #fff; padding: 12px 15px; border-top: 1px solid #eee; display: flex; justify-content: flex-end; gap: 10px; align-items: center;">
                                    <c:if test="${order.status == 'Pending' || order.status == 'Chờ xác nhận'}">
                                        <form action="${pageContext.request.contextPath}/cancel-order" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?');" style="margin: 0;">
                                            <input type="hidden" name="orderId" value="${order.orderID}">
                                            <button type="submit" style="background: #fff; color: #dc3545; border: 1px solid #dc3545; padding: 6px 12px; border-radius: 4px; cursor: pointer; font-size: 13px;">
                                                Hủy đơn hàng
                                            </button>
                                        </form>
                                    </c:if>

                                    <c:if test="${order.status == 'Completed' || order.status == 'Đã hoàn thành' || order.status == 'Đã giao'}">
                                        <a href="${pageContext.request.contextPath}/review?orderId=${order.orderID}" style="background: #fff; color: #0d6efd; border: 1px solid #0d6efd; padding: 6px 12px; border-radius: 4px; text-decoration: none; font-size: 13px;">
                                            Đánh giá
                                        </a>
                                    </c:if>

                                    <a href="${pageContext.request.contextPath}/print-invoice?orderId=${order.orderID}" target="_blank" style="background: #fff; color: #6c757d; border: 1px solid #6c757d; padding: 6px 12px; border-radius: 4px; text-decoration: none; font-size: 13px;">
                                        <i class="fa-solid fa-print"></i> In hóa đơn
                                    </a>

                                    <form action="${pageContext.request.contextPath}/reorder" method="post" style="margin: 0;">
                                        <input type="hidden" name="orderId" value="${order.orderID}">
                                        <button type="submit" style="background: #e91e63; color: white; border: none; padding: 6px 14px; border-radius: 4px; cursor: pointer; font-size: 13px; font-weight: 500;">
                                            <i class="fa-solid fa-rotate-right"></i> Đặt hàng lại
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
            </c:when>

<%-- KHI BẤM VÀO TAB KHUYẾN MÃI (${viewPage == 'promotion'}) --%>
            <c:when test="${viewPage == 'promotion'}">
                <h2><i class="fa-solid fa-percent" style="color: #e91e63;"></i> Sản Phẩm Khuyến Mãi Hot</h2>

                <div class="product-list">
                    <c:if test="${empty products}">
                        <p style="grid-column: 1 / -1; text-align: center; color: #777; padding: 40px 0;">
                            Hiện chưa có sản phẩm khuyến mãi nào.
                        </p>
                    </c:if>
                    <c:forEach var="product" items="${products}">
                        <div class="product-card">
                <!-- Bấm vào ảnh mở modal chi tiết -->
							<a href="javascript:void(0);" 
							   class="img-box open-modal-btn" 
							   style="text-decoration: none; display: block;"
							   data-name="<c:out value='${product.productName}'/>"
							   data-price="<fmt:formatNumber value='${product.discountPrice != null ? product.discountPrice : product.price}' type='number' pattern='#,###'/> VNĐ"
							   data-image="${product.image}"
							   data-id="${product.productID}"
							   data-desc="<c:out value='${product.description}'/>">
							   
							    <div class="img-box" style="border: none; padding: 0;">
                                <c:choose>
                                    <c:when test="${empty product.image}">
                                        <img src="${pageContext.request.contextPath}/assets/images/default-product.jpg"
                                             alt="<c:out value='${product.productName}' />">
                                    </c:when>
                                    <c:when test="${product.image.startsWith('http://') || product.image.startsWith('https://')}">
                                        <img src="${product.image}"
                                             alt="<c:out value='${product.productName}' />"
                                             referrerpolicy="no-referrer">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}${product.image.startsWith('/') ? '' : '/'}${product.image}"
                                             alt="<c:out value='${product.productName}' />">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                          </a>
                          
							<!-- Và ở phần thẻ h4 (tiêu đề) cũng làm tương tự: -->
							<h4>
							    <a href="javascript:void(0);" 
							       class="open-modal-btn" 
							       style="text-decoration: none; color: inherit;"
							       data-name="<c:out value='${product.productName}'/>"
							       data-price="<fmt:formatNumber value='${product.discountPrice != null ? product.discountPrice : product.price}' type='number' pattern='#,###'/> VNĐ"
							       data-image="${product.image}"
							       data-id="${product.productID}"
							       data-desc="<c:out value='${product.description}'/>">
							        <c:out value="${product.productName}" />
							    </a>
							</h4>
							                            
                            <p class="price">
                                <span style="color: #e91e63; font-weight: bold;">
                                    <fmt:formatNumber value="${product.discountPrice != null ? product.discountPrice : product.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ
                                </span>
                                <c:if test="${product.discountPrice != null && product.discountPrice < product.price}">
                                    <span style="text-decoration: line-through; color: #888; font-size: 13px; margin-left: 6px;">
                                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ
                                    </span>
                                </c:if>
                            </p>
                            
                            <button type="button" class="btn-cart" onclick="addToCart(${product.productID})">
                                <i class="fa-solid fa-cart-shopping"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </c:forEach>
                </div>
            </c:when>

<%-- KHI BẤM VÀO TAB LIÊN HỆ (${viewPage == 'contact'}) --%>
            <c:when test="${viewPage == 'contact'}">
                <h2>Liên Hệ & Giải Đáp Thắc Mắc</h2>

                <div class="contact-container">
                    <div>
                        <div class="contact-card-grid">
                            <div class="contact-info-card">
                                <i class="fa-solid fa-phone-volume"></i>
                                <div>
                                    <h4>Hotline hỗ trợ</h4>
                                    <p>1900 3667</p>
                                    <p>08:00 - 22:00 (Hằng ngày)</p>
                                </div>
                            </div>
                            <div class="contact-info-card">
                                <i class="fa-solid fa-envelope"></i>
                                <div>
                                    <h4>Email tư vấn</h4>
                                    <p>cskh@winxcosmetics.vn</p>
                                    <p>Phản hồi trong 24h</p>
                                </div>
                            </div>
                            <div class="contact-info-card">
                                <i class="fa-solid fa-location-dot"></i>
                                <div>
                                    <h4>Địa chỉ Showroom</h4>
                                    <p>123 Đường ABC, Phường 1,</p>
                                    <p>Quận 1, TP. Hồ Chí Minh</p>
                                </div>
                            </div>
                            <div class="contact-info-card">
                                <i class="fa-solid fa-comments"></i>
                                <div>
                                    <h4>Hỗ trợ trực tuyến</h4>
                                    <p>Facebook & Zalo Official</p>
                                    <p>Tư vấn da miễn phí</p>
                                </div>
                            </div>
                        </div>

                        <div class="faq-section">
                            <h3><i class="fa-solid fa-circle-question"></i> Câu Hỏi Thường Gặp (FAQ)</h3>

                            <div class="faq-item">
                                <div class="faq-title"><i class="fa-solid fa-check-circle"></i> Sản phẩm tại WINX Cosmetics có chính hãng không?</div>
                                <div class="faq-desc">Tất cả sản phẩm tại WINX đều có tem nhãn, giấy tờ chứng nhận nguồn gốc xuất xứ rõ ràng 100% từ nhà sản xuất.</div>
                            </div>

                            <div class="faq-item">
                                <div class="faq-title"><i class="fa-solid fa-check-circle"></i> Thời gian giao hàng mất bao lâu?</div>
                                <div class="faq-desc">Khu vực TP.HCM giao trong 1-2 ngày. Các tỉnh thành khác từ 2-4 ngày làm việc.</div>
                            </div>

                            <div class="faq-item">
                                <div class="faq-title"><i class="fa-solid fa-check-circle"></i> Quy định đổi trả hàng như thế nào?</div>
                                <div class="faq-desc">WINX hỗ trợ đổi trả trong vòng 7 ngày kể từ khi nhận hàng nếu sản phẩm bị lỗi do nhà sản xuất hoặc hư hỏng do vận chuyển.</div>
                            </div>
                        </div>
                    </div>

                    <div class="contact-form-box">
                        <h3><i class="fa-paper-plane fa-solid"></i> Gửi Thắc Mắc Cho Chúng Tôi</h3>
                        <form action="${pageContext.request.contextPath}/contact" method="post" onsubmit="handleContactSubmit(event)">
                            <div class="form-group">
                                <label for="fullName">Họ và tên *</label>
                                <input type="text" id="fullName" name="fullName" placeholder="Nhập họ và tên của bạn" required>
                            </div>

                            <div class="form-group">
                                <label for="contactEmail">Địa chỉ Email *</label>
                                <input type="email" id="contactEmail" name="email" placeholder="example@domain.com" required>
                            </div>

                            <div class="form-group">
                                <label for="contactPhone">Số điện thoại</label>
                                <input type="tel" id="contactPhone" name="phone" placeholder="Nhập số điện thoại liên hệ">
                            </div>

                            <div class="form-group">
                                <label for="topic">Chủ đề cần hỗ trợ</label>
                                <select id="topic" name="topic">
                                    <option value="advisory">Tư vấn chọn mỹ phẩm / chăm sóc da</option>
                                    <option value="order">Thắc mắc về đơn hàng & vận chuyển</option>
                                    <option value="return">Yêu cầu đổi trả / bảo hành</option>
                                    <option value="other">Ý kiến đóng góp khác</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="message">Nội dung thắc mắc *</label>
                                <textarea id="message" name="message" rows="4" placeholder="Viết nội dung thắc mắc hoặc yêu cầu tư vấn tại đây..." required></textarea>
                            </div>

                            <button type="submit" class="btn-submit-contact">Gửi Thắc Mắc</button>
                        </form>
                    </div>
                </div>

                <div class="map-container">
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.424167419727!2d106.69834711533413!3d10.778788062097371!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752f3a537f90ed%3A0xe64a66e4a5538e!2zQ2jhu6MgQuG6v24gVGjDoG5o!5e0!3m2!1svi!2s!4v1620000000000!5m2!1svi!2s" 
                        width="100%" height="100%" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                </div>
            </c:when>
            
<%-- TRƯỜNG HỢP: GIỚI THIỆU (ABOUT) --%>
            <c:when test="${viewPage == 'about'}">
                <h2><i class="fa-solid fa-circle-info" style="color: #e91e63;"></i> Giới Thiệu Về WINX Cosmetics</h2>
                <div style="background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); line-height: 1.8; color: #444;">
                    <h3 style="color: #d90429; margin-bottom: 15px;">Chào mừng bạn đến với WINX Cosmetics!</h3>
                    <p style="margin-bottom: 15px;">WINX Cosmetics được thành lập với sứ mệnh mang lại vẻ đẹp tự nhiên, rạng rỡ và sự tự tin cho phái đẹp Việt Nam. Chúng tôi cam kết cung cấp các dòng sản phẩm chăm sóc da, trang điểm chính hãng 100% từ các thương hiệu uy tín trên toàn thế giới.</p>
                    <p style="margin-bottom: 15px;">Với đội ngũ tư vấn viên giàu kinh nghiệm, tận tâm và am hiểu sâu sắc về làn da, WINX luôn sẵn sàng lắng nghe và đồng hành cùng bạn trên hành trình chăm sóc bản thân.</p>
                    <h4 style="margin-top: 20px; margin-bottom: 10px; color: #333;">Giá trị cốt lõi của chúng tôi:</h4>
                    <ul style="padding-left: 20px;">
                        <li><strong>Chính hãng & An toàn:</strong> Nói không với hàng giả, hàng kém chất lượng.</li>
                        <li><strong>Khách hàng là trung tâm:</strong> Mọi dịch vụ đều hướng tới sự hài lòng tuyệt đối của bạn.</li>
                        <li><strong>Giá cả hợp lý:</strong> Mang lại trải nghiệm cao cấp với mức giá tốt nhất thị trường.</li>
                    </ul>
                </div>
            </c:when>

<%-- TRƯỜNG HỢP: TIN TỨC --%>
            <c:when test="${viewPage == 'news'}">
                <h2>Tin Tức & Mẹo Làm Đẹp</h2>

                <div class="news-list">
                    <c:if test="${empty newsList}">
                        <p style="text-align: center; color: #777; padding: 40px 0;">
                            Chưa có tin tức nào được cập nhật.
                        </p>
                    </c:if>

                    <c:forEach var="item" items="${newsList}">
						<article class="news-card open-news-modal" 
						         style="cursor: pointer;"
						         data-title="<c:out value='${item.title}'/>"
						         data-date="<fmt:formatDate value='${item.createdDate}' pattern='dd/MM/yyyy HH:mm'/>"
						         data-image="${item.image}"
						         data-content="<c:out value='${item.content != null ? item.content : item.summary}'/>">
						         
					    <div class="news-img-box">
					        <c:choose>
					            <c:when test="${empty item.image}">
					                <img src="${pageContext.request.contextPath}/assets/images/default-news.jpg" alt="<c:out value='${item.title}' />">
					            </c:when>
					            <c:when test="${item.image.startsWith('http://') || item.image.startsWith('https://')}">
					                <img src="${item.image}" alt="<c:out value='${item.title}' />" referrerpolicy="no-referrer">
					            </c:when>
					            <c:otherwise>
					                <img src="${pageContext.request.contextPath}${item.image.startsWith('/') ? '' : '/'}${item.image}" 
					                     alt="<c:out value='${item.title}' />">
					            </c:otherwise>
					        </c:choose>
					    </div>         
                                
                            <div class="news-content">
                                <div class="news-date">
                                    <i class="fa-regular fa-calendar-days"></i>
                                    <fmt:formatDate value="${item.createdDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </div>
                                <h3 class="news-title"><c:out value="${item.title}" /></h3>
                                <p class="news-summary"><c:out value="${item.summary}" /></p>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </c:when>

<%-- TRƯỜNG HỢP 1: TAB SẢN PHẨM BÁN CHẠY --%>
            <c:when test="${viewPage == 'best-sellers'}">
                <h2><i class="fa-solid fa-fire" style="color: #e91e63;"></i> Sản Phẩm Bán Chạy Nhất</h2>

                <div class="product-list">
                    <c:if test="${empty products}">
                        <p style="grid-column: 1 / -1; text-align: center; color: #777; padding: 40px 0;">
                            Hiện chưa có sản phẩm bán chạy nào.
                        </p>
                    </c:if>
                    <c:forEach var="product" items="${products}">
                        <div class="product-card">
                <!-- Bấm vào ảnh mở modal chi tiết -->
								<a href="javascript:void(0);" 
							   class="img-box open-modal-btn" 
							   style="text-decoration: none; display: block;"
							   data-name="<c:out value='${product.productName}'/>"
							   data-price="<fmt:formatNumber value='${product.discountPrice != null ? product.discountPrice : product.price}' type='number' pattern='#,###'/> VNĐ"
							   data-image="${product.image}"
							   data-id="${product.productID}"
							   data-desc="${fn:escapeXml(product.description)}">
							   
							    <div class="img-box" style="border: none; padding: 0;">
                            
                                <c:choose>
                                    <c:when test="${empty product.image}">
                                        <%-- Ảnh mặc định nội bộ nếu trong DB không có ảnh --%>
                                        <img src="${pageContext.request.contextPath}/assets/images/default-product.jpg"
                                             alt="<c:out value='${product.productName}' />">
                                    </c:when>
                                    <c:when test="${product.image.startsWith('http://') || product.image.startsWith('https://')}">
                                        <%-- Ảnh dạng link tuyệt đối ngoài internet --%>
                                        <img src="${product.image}"
                                             alt="<c:out value='${product.productName}' />"
                                             referrerpolicy="no-referrer">
                                    </c:when>
                                    <c:otherwise>
                                        <%-- Ảnh từ Admin tải lên / quản lý --%>
                                        <img src="${pageContext.request.contextPath}${product.image.startsWith('/') ? '' : '/'}${product.image}"
                                             alt="<c:out value='${product.productName}' />">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                          </a>
                            
							<!-- Và ở phần thẻ h4 (tiêu đề) cũng làm tương tự: -->
							<h4>
							    <a href="javascript:void(0);" 
							       class="open-modal-btn" 
							       style="text-decoration: none; color: inherit;"
							       data-name="<c:out value='${product.productName}'/>"
							       data-price="<fmt:formatNumber value='${product.discountPrice != null ? product.discountPrice : product.price}' type='number' pattern='#,###'/> VNĐ"
							       data-image="${product.image}"
							       data-id="${product.productID}"
							       data-desc="${fn:escapeXml(product.description)}">
							        <c:out value="${product.productName}" />
							    </a>
							</h4>
							                            
                            <p class="price">
                                <span style="color: #e91e63; font-weight: bold;">
                                    <fmt:formatNumber value="${product.discountPrice != null ? product.discountPrice : product.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ
                                </span>
                                <c:if test="${product.discountPrice != null && product.discountPrice < product.price}">
                                    <span style="text-decoration: line-through; color: #888; font-size: 13px; margin-left: 6px;">
                                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ
                                    </span>
                                </c:if>
                            </p>
                            
                            <button type="button" class="btn-cart" onclick="addToCart(${product.productID})">
                                <i class="fa-solid fa-cart-shopping"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </c:forEach>
                </div>
            </c:when>

<%-- TRƯỜNG HỢP 2: MẶC ĐỊNH (TRANG CHỦ) - HIỂN THỊ CẢ SẢN PHẨM NỔI BẬT VÀ TIN TỨC --%>
            <c:otherwise>
                <h2>Sản phẩm nổi bật</h2>

                <div class="product-list">
                    <c:if test="${empty products}">
                        <p style="grid-column: 1 / -1; text-align: center; color: #777; padding: 20px 0 40px 0;">
                            Hiện chưa có sản phẩm nào để hiển thị.
                        </p>
                    </c:if>
                    <c:forEach var="product" items="${products}">
                        <div class="product-card">
                            <!-- Bấm vào ảnh mở modal chi tiết -->
								<a href="javascript:void(0);" 
								   class="img-box open-modal-btn" 
								   style="text-decoration: none; display: block;"
								   data-name="<c:out value='${product.productName}'/>"
								   data-price="${product.price}"
								   data-image="${product.image}"
								   data-id="${product.productID}"
								   data-desc="<c:out value='${product.description}'/>">
                   
                                <c:choose>
                                    <c:when test="${empty product.image}">
                                        <img src="https://images.unsplash.com/photo-1586495777744-4413f21062fa?q=80&w=400&auto=format&fit=crop"
                                            alt="<c:out value='${product.productName}' />">
                                    </c:when>
                                    <c:when test="${product.image.startsWith('http://') || product.image.startsWith('https://')}">
                                        <img src="${product.image}"
                                            alt="<c:out value='${product.productName}' />"
                                            referrerpolicy="no-referrer"
                                            onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1586495777744-4413f21062fa?q=80&w=400&auto=format&fit=crop';">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/images/${product.image}"
                                            alt="<c:out value='${product.productName}' />"
                                            onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1586495777744-4413f21062fa?q=80&w=400&auto=format&fit=crop';">
                                    </c:otherwise>
                                </c:choose>
                            </a>
                            
                            <!-- Bấm vào tiêu đề mở modal chi tiết -->
							<h4>
							    <a href="javascript:void(0);" 
							       class="open-modal-btn" 
							       style="text-decoration: none; color: inherit;"
							       data-name="<c:out value='${product.productName}'/>"
							       data-price="${product.price}"
							       data-image="${product.image}"
							       data-id="${product.productID}"
							       data-desc="<c:out value='${product.description}'/>">
							        <c:out value="${product.productName}" />
							    </a>
							</h4>
					                            
                            <p class="price">
                                <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ
                            </p>
                            
                            <button type="button" class="btn-cart" onclick="addToCart(${product.productID})">
                                <i class="fa-solid fa-cart-shopping"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </c:forEach>
                </div>
           

<%-- CHỈ HIỂN THỊ TIN TỨC KHI KHÔNG PHẢI TRANG SẢN PHẨM --%>
                <c:if test="${viewPage ne 'products' && action ne 'products'}">
                    <h2 style="margin-top: 40px;">Tin tức & Mẹo làm đẹp</h2>

                    <div class="news-list">
                        <c:if test="${empty newsList}">
                            <p style="text-align: center; color: #777; padding: 20px 0 40px 0;">
                                Chưa có tin tức nào được cập nhật.
                            </p>
                        </c:if>

                        <c:forEach var="item" items="${newsList}">
                            <article class="news-card open-news-modal" 
                     style="cursor: pointer;"
                     data-title="<c:out value='${item.title}'/>"
                     data-date="<fmt:formatDate value='${item.createdDate}' pattern='dd/MM/yyyy HH:mm'/>"
                     data-image="${item.image}"
                     data-content="<c:out value='${item.content != null ? item.content : item.summary}'/>">
                     
                                <div class="news-img-box">
                                    <c:choose>
                                        <c:when test="${empty item.image}">
                                            <img src="${pageContext.request.contextPath}/assets/images/news1.jpg" alt="<c:out value='${item.title}' />">
                                        </c:when>
                                        <c:when test="${item.image.startsWith('http://') || item.image.startsWith('https://')}">
                                            <img src="${item.image}" alt="<c:out value='${item.title}' />" referrerpolicy="no-referrer">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}${item.image.startsWith('/') ? '' : '/'}${item.image}" 
                                                 alt="<c:out value='${item.title}' />"
                                                 onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?q=80&w=1000&auto=format&fit=crop';">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="news-content">
                                    <div class="news-date">
                                        <i class="fa-regular fa-calendar-days"></i>
                                        <fmt:formatDate value="${item.createdDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </div>
                                    <h3 class="news-title"><c:out value="${item.title}" /></h3>
                                    <p class="news-summary"><c:out value="${item.summary}" /></p>
                                </div>
                            </article>
                        </c:forEach>
                    </div>
                </c:if>
            </c:otherwise>

        </c:choose>
    </section>
</div>

<!-- 6. Footer -->
<footer class="footer">
    <div class="container footer-content">
        <div class="footer-col brand-col">
            <h3 class="footer-logo">WINX COSMETICS</h3>
            <p class="footer-desc">Thương hiệu bán lẻ mỹ phẩm chính hãng hàng đầu, mang đến vẻ đẹp rạng rỡ và tự nhiên nhất cho bạn.</p>
            <div class="social-links">
                <a href="#"><i class="fa-brands fa-facebook-f"></i></a> 
                <a href="#"><i class="fa-brands fa-instagram"></i></a> 
                <a href="#"><i class="fa-brands fa-tiktok"></i></a> 
                <a href="#"><i class="fa-brands fa-youtube"></i></a>
            </div>
        </div>

        <div class="footer-col">
            <h4>HỖ TRỢ KHÁCH HÀNG</h4>
            <ul>
                <li><a href="#">Hướng dẫn mua hàng</a></li>
                <li><a href="#">Chính sách đổi trả</a></li>
                <li><a href="#">Chính sách bảo mật</a></li>
                <li><a href="#">Phương thức thanh toán</a></li>
                <li><a href="#">Tra cứu đơn hàng</a></li>
            </ul>
        </div>

        <div class="footer-col">
            <h4>VỀ WINX STORE</h4>
            <ul>
                <li><a href="#">Giới thiệu cửa hàng</a></li>
                <li><a href="#">Hệ thống cửa hàng</a></li>
                <li><a href="#">Tuyển dụng</a></li>
                <li><a href="#">Liên hệ & Góp ý</a></li>
                <li><a href="#">Tin tức & Báo chí</a></li>
            </ul>
        </div>

        <div class="footer-col contact-col">
            <h4>THÔNG TIN LIÊN HỆ</h4>
            <p><i class="fa-solid fa-location-dot"></i> 123 Đường ABC, Phường 1, Quận 1, TP.HCM</p>
            <p><i class="fa-solid fa-phone"></i> Hotline: <strong>1900 3667</strong> (8:00 - 21:30)</p>
            <p><i class="fa-solid fa-envelope"></i> Email: cskh@winxcosmetics.vn</p>
            <div class="payment-methods">
                <i class="fa-brands fa-cc-visa"></i> 
                <i class="fa-brands fa-cc-mastercard"></i> 
                <i class="fa-solid fa-qrcode"></i>
            </div>
        </div>
    </div>

    <div class="footer-bottom">
        <div class="container">
            <p>&copy; 2026 WINX Cosmetics. All Rights Reserved. Designed with <i class="fa-solid fa-heart"></i></p>
        </div>
    </div>
</footer>

<!-- Modal hiển thị chi tiết Sản phẩm -->
<div id="productModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 9999; justify-content: center; align-items: center; backdrop-filter: blur(3px);">
    <div style="background: #fff; padding: 35px; border-radius: 16px; width: 850px; max-width: 92%; max-height: 85vh; position: relative; display: flex; gap: 30px; box-shadow: 0 10px 30px rgba(232, 67, 147, 0.15); border: 1px solid #ffe6f0; overflow: hidden;">
        
        <!-- Nút đóng modal (Dấu X chuẩn, chắc chắn bấm được) -->
        <span onclick="closeModal()" style="position: absolute; top: 15px; right: 20px; width: 32px; height: 32px; background: #fff0f5; color: #d63384; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 20px; cursor: pointer; z-index: 10; transition: all 0.2s;" onmouseover="this.style.background='#ff4d6d'; this.style.color='#fff';" onmouseout="this.style.background='#fff0f5'; this.style.color='#d63384';">&times;</span>
        
        <!-- Cột Ảnh bên trái -->
        <div style="flex: 1; display: flex; align-items: center; justify-content: center; background: #fff9fb; padding: 15px; border-radius: 12px; border: 1px dashed #ffb6c1; max-height: 400px;">
            <img id="modalImg" src="" alt="" style="width: 100%; max-height: 380px; object-fit: contain; border-radius: 8px;">
        </div>
        
        <!-- Cột Nội dung bên phải -->
        <div style="flex: 1; display: flex; flex-direction: column; max-height: 75vh; overflow-y: auto; padding-right: 8px;">
            <h2 id="modalTitle" style="margin-top: 0; color: #2c3e50; font-size: 22px; font-weight: 700; line-height: 1.4; margin-bottom: 8px;"></h2>
            
            <div id="modalPrice" style="color: #e91e63; font-size: 20px; font-weight: 700; margin-bottom: 15px;"></div>
            
            <hr style="border: none; border-top: 1px solid #ffe6f0; margin-bottom: 15px;">
            
            <p style="margin: 0 0 8px 0; font-weight: 600; color: #555; font-size: 14px;">
                <i class="fa-solid fa-circle-info" style="color: #e91e63;"></i> Mô tả chi tiết:
            </p>
            <div id="modalDescription" style="color: #666; font-size: 14px; line-height: 1.6; white-space: pre-line; margin-bottom: 20px;"></div>
            
            <!-- Nút thêm vào giỏ hàng trong modal -->
            <button id="modalBtnCart" type="button" style="margin-top: auto; background: #ff4d6d; color: white; border: none; padding: 12px 20px; border-radius: 8px; font-size: 16px; font-weight: 600; cursor: pointer; display: flex; align-items: center; justify-content: center; gap: 8px;">
                <i class="fa-solid fa-cart-shopping"></i> Thêm vào giỏ hàng
            </button>
        </div>
    </div>
</div>

<!-- Modal hiển thị chi tiết Tin tức -->
<div id="newsModal" class="modal-overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 9999; justify-content: center; align-items: center; backdrop-filter: blur(3px);">
    <div class="modal-content" style="background: #fff; padding: 35px; border-radius: 16px; width: 850px; max-width: 92%; max-height: 85vh; position: relative; display: flex; gap: 30px; box-shadow: 0 10px 30px rgba(232, 67, 147, 0.15); border: 1px solid #ffe6f0; overflow: hidden;">
        
        <!-- Nút đóng modal -->
        <span onclick="closeNewsModal()" style="position: absolute; top: 15px; right: 20px; width: 32px; height: 32px; background: #fff0f5; color: #d63384; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 20px; cursor: pointer; transition: all 0.2s; z-index: 10;" onmouseover="this.style.background='#ff4d6d'; this.style.color='#fff';" onmouseout="this.style.background='#fff0f5'; this.style.color='#d63384';">&times;</span>
        
        <!-- Cột Ảnh bên trái -->
        <div style="flex: 1; display: flex; align-items: center; justify-content: center; background: #fff9fb; padding: 15px; border-radius: 12px; border: 1px dashed #ffb6c1; max-height: 400px;">
            <img id="newsModalImg" src="" alt="" style="width: 100%; max-height: 380px; object-fit: contain; border-radius: 8px;">
        </div>
        
        <!-- Cột Nội dung bên phải (Có thanh cuộn riêng) -->
        <div style="flex: 1; display: flex; flex-direction: column; max-height: 75vh; overflow-y: auto; padding-right: 8px;" class="custom-scrollbar">
            <h2 id="newsModalTitle" style="margin-top: 0; color: #2c3e50; font-size: 22px; font-weight: 700; line-height: 1.4; margin-bottom: 8px;"></h2>
            
            <div id="newsModalDate" style="color: #e91e63; font-size: 13px; font-weight: 500; margin-bottom: 15px; display: flex; align-items: center; gap: 6px;">
                <i class="fa-regular fa-calendar-days"></i> <span></span>
            </div>
            
            <hr style="border: none; border-top: 1px solid #ffe6f0; margin-bottom: 15px;">
            
            <!-- Nội dung chi tiết bài viết -->
            <div id="newsModalContent" style="color: #444; font-size: 14px; line-height: 1.8; white-space: pre-line;"></div>
        </div>
    </div>
</div>

<!-- Script AJAX Thêm vào giỏ hàng, Gửi liên hệ & Điều khiển Modal -->
<script>
document.addEventListener("DOMContentLoaded", function() {
    // Xử lý sự kiện click cho Tin tức
    const newsCards = document.querySelectorAll('.open-news-modal');
    newsCards.forEach(card => {
        card.addEventListener('click', function() {
            const title = this.getAttribute('data-title');
            const date = this.getAttribute('data-date');
            const image = this.getAttribute('data-image');
            const content = this.getAttribute('data-desc') || this.getAttribute('data-content');
            
            openNewsModal(title, date, image, content);
        });
    });
});

// 1. Hàm mở Modal Tin tức
function openNewsModal(title, date, image, content) {
    document.getElementById('newsModal').style.display = 'flex';
    document.getElementById('newsModalTitle').innerText = title;
    document.getElementById('newsModalDate').querySelector('span').innerText = date;
    
    let finalImg = '';
    if (!image || image === 'null' || image.trim() === '') {
        finalImg = '${pageContext.request.contextPath}/assets/images/default-news.jpg';
    } else if (image.startsWith('http://') || image.startsWith('https://')) {
        finalImg = image;
    } else {
        let cleanImg = image.startsWith('/') ? image : '/' + image;
        finalImg = '${pageContext.request.contextPath}/assets/images' + cleanImg;
    }
    document.getElementById('newsModalImg').src = finalImg;
    
    document.getElementById('newsModalContent').innerText = (content && content !== 'null' && content.trim() !== '') 
        ? content 
        : 'Nội dung chi tiết của bài viết đang được cập nhật...';
}

// 2. Hàm đóng Modal Tin tức (Khớp với nút X ở modal tin tức)
function closeNewsModal() {
    document.getElementById('newsModal').style.display = 'none';
}

// 3. Hàm mở Modal Sản phẩm
function openModal(name, price, image, id, description) {
    document.getElementById('productModal').style.display = 'flex';
    document.getElementById('modalTitle').innerText = name;
    document.getElementById('modalPrice').innerText = String(price).includes('VNĐ') ? price : price + ' VNĐ';
    document.getElementById('modalDescription').innerText = (description && description !== 'null' && description.trim() !== '') ? description : 'Mô tả sản phẩm đang được cập nhật...';
    
    let btnCart = document.getElementById('modalBtnCart');
    if(btnCart) {
        btnCart.setAttribute('onclick', 'addToCart(' + id + ')');
    }
    
    let finalImg = '';
    if (!image || image === 'null' || image.trim() === '') {
        finalImg = 'https://images.unsplash.com/photo-1586495777744-4413f21062fa?q=80&w=400&auto=format&fit=crop';
    } else if (image.startsWith('http://') || image.startsWith('https://')) {
        finalImg = image;
    } else {
        let cleanImg = image.startsWith('/') ? image : '/' + image;
        finalImg = '${pageContext.request.contextPath}/assets/images' + cleanImg;
    }
    document.getElementById('modalImg').src = finalImg;
}

// 4. Hàm đóng Modal Sản phẩm (Khớp với nút X ở modal sản phẩm)
function closeModal() {
    document.getElementById('productModal').style.display = 'none';
}

// 5. Bắt sự kiện click chung cho tất cả các nút mở modal sản phẩm (Dùng Delegation để bắt cả sản phẩm load động)
document.addEventListener('click', function(event) {
    let btn = event.target.closest('.open-modal-btn');
    if (btn) {
        event.preventDefault();
        openModal(
            btn.getAttribute('data-name'),
            btn.getAttribute('data-price'),
            btn.getAttribute('data-image'),
            btn.getAttribute('data-id'),
            btn.getAttribute('data-desc')
        );
    }
});

// 6. Thêm vào giỏ hàng
function addToCart(productId) {
    fetch('${pageContext.request.contextPath}/cart?action=add&productID=' + productId, {
        method: 'GET'
    })
    .then(response => {
        if (response.ok) {
            alert('🎉 Đã thêm sản phẩm vào giỏ hàng thành công!');
        } else {
            alert('Có lỗi xảy ra, vui lòng thử lại!');
        }
    })
    .catch(error => console.error('Lỗi:', error));
}

function handleContactSubmit(e) {
    e.preventDefault();
    alert('📩 Thắc mắc của bạn đã được gửi thành công! Đội ngũ WINX sẽ liên hệ phản hồi trong thời gian sớm nhất.');
    e.target.reset();
}
</script>

</body>
</html>