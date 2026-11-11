<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Đơn Hàng #${not empty orderID ? orderID : order.orderID} | WINX ENCHANTIX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <style>
        :root {
            --pink-gradient: linear-gradient(135deg, #ff758c 0%, #ff7eb3 100%);
            --pink-dark: #d81b60;
        }

        body {
            background-color: #fff8fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #4a4a4a;
        }

        .main-card {
            background: #ffffff;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(255, 117, 140, 0.12);
            border: 1px solid #ffe3ec;
            margin-top: 30px;
            margin-bottom: 40px;
        }

        .page-title {
            color: var(--pink-dark);
            font-weight: 700;
            position: relative;
            padding-bottom: 12px;
        }

        .page-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: var(--pink-gradient);
            border-radius: 10px;
        }

        .table-pink-header {
            background: var(--pink-gradient) !important;
            color: #ffffff !important;
        }

        .table-pink-header th {
            border: none !important;
            padding: 14px 10px;
            font-weight: 600;
        }

        .btn-back {
            background: #fce4ec;
            color: #c2185b;
            border: none;
            border-radius: 10px;
            padding: 10px 20px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            background: #f8bbd0;
            color: #880e4f;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="main-card">
        
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div></div>
            <h2 class="page-title text-center m-0">CHI TIẾT ĐƠN HÀNG #${not empty orderID ? orderID : order.orderID}</h2>
            <a href="${pageContext.request.contextPath}/admin/order?action=list" class="btn btn-back">
                <i class="fa-solid fa-arrow-left me-1"></i> Danh sách đơn hàng
            </a>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead>
                    <tr class="table-pink-header text-center">
                        <th>MÃ ĐƠN</th>
                        <th>KHÁCH HÀNG</th>
                        <th>TÊN SẢN PHẨM</th>
                        <th>SỐ LƯỢNG</th>
                        <th>ĐƠN GIÁ</th>
                        <th>THÀNH TIỀN</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty list}">
                            <tr>
                                <td colspan="6" class="text-center text-muted py-4">Không có dữ liệu chi tiết cho đơn hàng này.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${list}" var="od">
                                <tr>
                                    <td class="text-center fw-bold">#${od.orderID}</td>
                                    
                                    <!-- Hiển thị Tên Khách Hàng -->
                                    <td class="text-center fw-semibold">
                                        <c:out value="${od.customerName}" default="Khách lẻ" />
                                    </td>
                                    
                                    <!-- Hiển thị Tên Sản Phẩm -->
                                    <td class="text-start ps-3 fw-medium">
                                        <c:out value="${od.productName}" default="Sản phẩm #${od.productID}" />
                                    </td>
                                    
                                    <td class="text-center">${od.quantity}</td>

                                    <td class="text-center text-muted">
                                        <fmt:formatNumber value="${od.unitPrice}" type="number" groupingUsed="true"/> VNĐ
                                    </td>
                                    
                                    <td class="text-center text-danger fw-bold">
                                        <fmt:formatNumber value="${od.quantity * od.unitPrice}" type="number" groupingUsed="true"/> VNĐ
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

    </div>
</div>

</body>
</html>