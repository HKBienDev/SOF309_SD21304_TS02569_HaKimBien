<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Đơn Hàng | WINX ENCHANTIX</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <style>
        :root {
            --pink-gradient: linear-gradient(135deg, #ff758c 0%, #ff7eb3 100%);
            --pink-soft: #fff0f5;
            --pink-dark: #d81b60;
            --primary-pink: #ff66a3;
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

        .btn-home {
            background: #fce4ec;
            color: #c2185b;
            border: none;
            border-radius: 10px;
            padding: 10px 20px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-home:hover {
            background: #f8bbd0;
            color: #880e4f;
        }

        .btn-detail {
            background: var(--pink-gradient);
            color: #ffffff;
            border-radius: 20px;
            padding: 6px 16px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(255, 117, 140, 0.3);
        }

        .btn-detail:hover {
            opacity: 0.9;
            color: #ffffff;
            transform: translateY(-1px);
        }

        .btn-action-confirm {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 34px;
            height: 34px;
            border-radius: 50%;
            text-decoration: none;
            background-color: #e8f5e9;
            color: #2e7d32;
            transition: all 0.2s ease;
        }

        .btn-action-confirm:hover {
            background-color: #2e7d32;
            color: #ffffff;
            transform: translateY(-2px);
        }

        .btn-action-cancel {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 34px;
            height: 34px;
            border-radius: 50%;
            text-decoration: none;
            background-color: #ffebee;
            color: #c62828;
            transition: all 0.2s ease;
        }

        .btn-action-cancel:hover {
            background-color: #c62828;
            color: #ffffff;
            transform: translateY(-2px);
        }

        .badge-status {
            font-size: 13px;
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="main-card">
        
        <!-- HEADER -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div></div>
            <h2 class="page-title text-center m-0">DANH SÁCH ĐƠN HÀNG</h2>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-home">
                <i class="fa-solid fa-arrow-left me-1"></i> Trang chủ
            </a>
        </div>

        <!-- BẢNG ĐƠN HÀNG -->
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead>
                    <tr class="table-pink-header text-center">
                        <th style="width: 10%">MÃ ĐƠN</th>
                        <th style="width: 20%">KHÁCH HÀNG</th>
                        <th style="width: 20%">TỔNG TIỀN</th>
                        <th style="width: 20%">TRẠNG THÁI</th>
                        <th style="width: 15%">CHI TIẾT</th>
                        <th style="width: 15%">THAO TÁC</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty list}">
                            <tr>
                                <td colspan="6" class="text-center text-muted py-4">Chưa có đơn hàng nào trong hệ thống.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${list}" var="ord">
                                <!-- XỬ LÝ CHUỖI TRẠNG THÁI (TRÁNH LỖI KHOẢNG TRẮNG CỦA SQL) -->
                                <c:set var="rawStatus" value="${ord.status != null ? fn:trim(ord.status) : 'Pending'}" />
                                <c:set var="statusLower" value="${fn:toLowerCase(rawStatus)}" />

                                <tr>
                                    <!-- MÃ ĐƠN -->
                                    <td class="text-center fw-bold">#${ord.orderID}</td>
                                    
                                    <!-- MÃ KHÁCH HÀNG -->
                                    <td class="text-center">Khách hàng #${ord.customerID}</td>
                                    
                                    <!-- TỔNG TIỀN -->
                                    <td class="text-center text-danger fw-bold">
                                        <fmt:formatNumber value="${ord.totalAmount}" type="number" groupingUsed="true"/> VNĐ
                                    </td>

                                    <!-- TRẠNG THÁI (CẢ TIẾNG ANH & TIẾNG VIỆT) -->
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${statusLower == 'approved' || statusLower == 'completed' || rawStatus == 'Đã xác nhận' || rawStatus == 'Đã duyệt'}">
                                                <span class="badge bg-success badge-status">
                                                    <i class="fa-solid fa-circle-check me-1"></i>Đã xác nhận
                                                </span>
                                            </c:when>
                                            <c:when test="${statusLower == 'cancelled' || rawStatus == 'Đã hủy'}">
                                                <span class="badge bg-danger badge-status">
                                                    <i class="fa-solid fa-circle-xmark me-1"></i>Đã hủy
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning text-dark badge-status">
                                                    <i class="fa-solid fa-clock me-1"></i>Chờ xác nhận
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- NÚT XEM CHI TIẾT -->
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/admin/order?action=detail&orderID=${ord.orderID}" class="btn-detail">
                                            <i class="fa-solid fa-eye"></i> Xem chi tiết
                                        </a>
                                    </td>

                                    <!-- THAO TÁC DUYỆT / HỦY -->
                                    <td class="text-center">
                                        <div class="d-flex justify-content-center gap-2">
                                            
                                            <!-- Nút XÁC NHẬN (Ẩn khi đơn đã duyệt) -->
                                            <c:if test="${statusLower != 'approved' && statusLower != 'completed' && rawStatus != 'Đã xác nhận' && rawStatus != 'Đã duyệt'}">
                                                <a href="${pageContext.request.contextPath}/admin/order?action=approve&orderID=${ord.orderID}" 
                                                   class="btn-action-confirm" 
                                                   onclick="return confirm('Bạn có chắc chắn muốn duyệt đơn hàng #${ord.orderID}?')" 
                                                   title="Duyệt đơn hàng">
                                                    <i class="fa-solid fa-check"></i>
                                                </a>
                                            </c:if>

                                            <!-- Nút HỦY (Ẩn khi đơn đã hủy) -->
                                            <c:if test="${statusLower != 'cancelled' && rawStatus != 'Đã hủy'}">
                                                <a href="${pageContext.request.contextPath}/admin/order?action=cancel&orderID=${ord.orderID}" 
                                                   class="btn-action-cancel" 
                                                   onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #${ord.orderID}?')" 
                                                   title="Hủy đơn hàng">
                                                    <i class="fa-solid fa-xmark"></i>
                                                </a>
                                            </c:if>

                                        </div>
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