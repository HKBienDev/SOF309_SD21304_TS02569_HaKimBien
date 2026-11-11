<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cảm Ơn Quý Khách | WINX ENCHANTIX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <style>
        body {
            background-color: #fff8fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .success-card {
            background: #ffffff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(255, 117, 140, 0.15);
            border: 1px solid #ffe3ec;
            text-align: center;
            max-width: 550px;
            width: 100%;
        }
        .icon-check {
            font-size: 70px;
            color: #ff758c;
            margin-bottom: 20px;
        }
        .btn-custom-primary {
            background: linear-gradient(135deg, #ff758c 0%, #ff7eb3 100%);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 30px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }
        .btn-custom-primary:hover {
            color: white;
            opacity: 0.9;
            transform: translateY(-2px);
        }
        .btn-custom-outline {
            background: #fff;
            color: #ff758c;
            border: 2px solid #ff758c;
            padding: 10px 20px;
            border-radius: 30px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }
        .btn-custom-outline:hover {
            background: #fff8fa;
            color: #ff758c;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center">
    <div class="success-card">
        <div class="icon-check">
            <i class="fa-solid fa-circle-check"></i>
        </div>
        <h2 class="fw-bold text-danger mb-3">ĐẶT HÀNG THÀNH CÔNG!</h2>
        
        <!-- Hiển thị mã đơn hàng nếu Servlet gửi sang qua request attribute -->
        <p class="fs-6 text-dark mb-2">Mã đơn hàng của bạn: <strong>#<c:out value="${orderID}"/></strong></p>
        
        <p class="text-secondary mb-4" style="font-size: 14px; line-height: 1.6;">
            Cảm ơn quý khách đã đặt hàng tại WINX ENCHANTIX. Chúng tôi sẽ liên lạc với khách hàng để xác nhận đơn hàng trong thời gian sớm nhất.
        </p>
        
        <div class="d-flex justify-content-center gap-2 flex-wrap">
            <a href="${pageContext.request.contextPath}/order-history" class="btn btn-custom-outline">
                <i class="fa-solid fa-clock-rotate-left me-1"></i> Xem lịch sử đơn
            </a>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-custom-primary">
                <i class="fa-solid fa-house me-1"></i> Về trang chủ
            </a>
        </div>
    </div>
</div>

</body>
</html>