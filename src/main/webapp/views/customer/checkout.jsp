<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận thanh toán | WINX ENCHANTIX</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #ff4d8d;
            --primary-hover: #e03a75;
            --primary-light: #fff0f3;
            --surface-card: #ffffff;
            --surface-subtle: #fff8f9;
            --border-color: #ffd0dc;
            --text-main: #2c2c2c;
            --text-muted: #666666;
            --radius-lg: 20px;
            --radius-md: 12px;
            --radius-sm: 8px;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Plus Jakarta Sans', 'Segoe UI', sans-serif;
            background-color: var(--primary-light);
            color: var(--text-main);
            padding: 40px 20px;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .checkout-wrapper {
            width: 100%;
            max-width: 960px;
            background: var(--surface-card);
            border-radius: var(--radius-lg);
            padding: 40px;
            box-shadow: 0 10px 40px rgba(255, 77, 141, 0.08);
        }

        .page-title {
            color: var(--primary);
            text-align: center;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 30px;
            letter-spacing: -0.5px;
            text-transform: uppercase;
        }

        .checkout-grid {
            display: grid;
            grid-template-columns: 1.25fr 1fr;
            gap: 30px;
        }

        .section-box {
            background: var(--surface-subtle);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-md);
            padding: 24px;
            margin-bottom: 24px;
        }

        .section-box:last-child {
            margin-bottom: 0;
        }

        .section-title {
            color: var(--text-main);
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 18px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--border-color);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-group:last-child {
            margin-bottom: 0;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            font-size: 13px;
            color: var(--text-muted);
            margin-bottom: 6px;
        }

        .form-control {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid var(--border-color);
            border-radius: var(--radius-sm);
            font-size: 14px;
            font-family: inherit;
            color: var(--text-main);
            background-color: #ffffff;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(255, 77, 141, 0.15);
        }

        .readonly-input {
            background-color: #f7f7f7;
            color: #777777;
            border-color: #e2e2e2;
            cursor: not-allowed;
        }

        .payment-option {
            display: flex;
            align-items: center;
            padding: 14px;
            border: 1px solid var(--border-color);
            border-radius: var(--radius-sm);
            margin-bottom: 12px;
            background: #ffffff;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .payment-option:hover {
            border-color: var(--primary);
            background: #fffdfd;
        }

        .payment-option input[type="radio"] {
            accent-color: var(--primary);
            width: 18px;
            height: 18px;
            margin-right: 12px;
            cursor: pointer;
        }

        .payment-option-label {
            font-size: 14px;
            font-weight: 600;
            color: var(--text-main);
        }

        .qr-box {
            text-align: center;
            padding: 16px;
            background: #ffffff;
            border: 2px dashed var(--primary);
            border-radius: var(--radius-sm);
            margin-top: 14px;
            animation: fadeIn 0.3s ease;
        }

        .qr-box p {
            margin-bottom: 10px;
            font-size: 13px;
            color: var(--text-muted);
            font-weight: 500;
        }

        .qr-box img {
            width: 180px;
            height: 180px;
            border-radius: 8px;
            border: 1px solid #eee;
        }

        .summary-list {
            max-height: 280px;
            overflow-y: auto;
            margin-bottom: 16px;
            padding-right: 4px;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px dashed var(--border-color);
            font-size: 14px;
        }

        .summary-item:last-child {
            border-bottom: none;
        }

        .summary-item-title {
            color: var(--text-muted);
            line-height: 1.4;
        }

        .summary-item-price {
            font-weight: 600;
            color: var(--text-main);
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: 700;
            font-size: 18px;
            color: var(--primary);
            border-top: 2px solid var(--border-color);
            padding-top: 16px;
            margin-top: 8px;
        }

        .actions-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
        }

        .btn-back {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: transform 0.2s ease;
        }

        .btn-back:hover {
            transform: translateX(-4px);
            color: var(--primary-hover);
        }

        .btn-submit {
            background: linear-gradient(135deg, #ff6584, #ff4d8d);
            color: #ffffff;
            border: none;
            padding: 14px 36px;
            border-radius: 30px;
            font-weight: 700;
            font-size: 15px;
            cursor: pointer;
            box-shadow: 0 6px 18px rgba(255, 77, 141, 0.35);
            transition: all 0.2s ease;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 22px rgba(255, 77, 141, 0.45);
        }

        .btn-submit:disabled {
            background: #ccc;
            box-shadow: none;
            cursor: not-allowed;
            transform: none;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-6px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .checkout-wrapper {
                padding: 24px;
            }
            .checkout-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            .actions-bar {
                flex-direction: column-reverse;
                gap: 16px;
            }
            .btn-submit {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<div class="checkout-wrapper">
    <h1 class="page-title">Xác nhận & Thanh toán</h1>

    <form id="checkoutForm" action="${pageContext.request.contextPath}/checkout" method="post" onsubmit="return handleFormSubmit(this)">
        <div class="checkout-grid">
            
            <!-- LEFT COLUMN: Shipping & Payment -->
            <div>
                <div class="section-box">
                    <div class="section-title">
                        <span>1. Thông tin người nhận</span>
                    </div>
                    
                    <div class="form-group">
                        <label for="emailInput">Tài khoản đặt hàng</label>
                        <input id="emailInput" type="text" class="form-control readonly-input" 
                               value="<c:out value='${sessionScope.currentUser.email}'/>" readonly />
                    </div>
                    
                    <div class="form-group">
                        <label for="fullnameInput">Họ và tên người nhận (*)</label>
                        <input id="fullnameInput" type="text" name="fullname" class="form-control" 
                               value="<c:out value='${sessionScope.currentUser.name}'/>" 
                               required placeholder="Nhập tên người nhận" />
                    </div>

                    <div class="form-group">
                        <label for="phoneInput">Số điện thoại (*)</label>
                        <input id="phoneInput" type="tel" name="phone" class="form-control" 
                               value="<c:out value='${sessionScope.currentUser.phone}'/>" 
                               required pattern="(0[3|5|7|8|9])+([0-9]{8})" 
                               title="Vui lòng nhập số điện thoại hợp lệ (10 chữ số)"
                               placeholder="Ví dụ: 0912345678" />
                    </div>

                    <div class="form-group">
                        <label for="addressInput">Địa chỉ nhận hàng (*)</label>
                        <textarea id="addressInput" name="address" class="form-control" rows="3" 
                                  required placeholder="Nhập địa chỉ giao hàng chi tiết"><c:out value="${sessionScope.currentUser.address}"/></textarea>
                    </div>
                </div>

                <div class="section-box">
                    <div class="section-title">
                        <span>2. Hình thức thanh toán</span>
                    </div>
                    
                    <label class="payment-option">
                        <input type="radio" name="paymentMethod" value="COD" checked onclick="toggleQR(false)">
                        <span class="payment-option-label">Thanh toán khi nhận hàng (COD)</span>
                    </label>

                    <label class="payment-option">
                        <input type="radio" name="paymentMethod" value="BANK" onclick="toggleQR(true)">
                        <span class="payment-option-label">Chuyển khoản qua Mã QR (Bank)</span>
                    </label>

					<div id="qr-box" class="qr-box" style="display: none;">
					    <p>Quét mã QR bằng ứng dụng ngân hàng để chuyển khoản:</p>
					    <!-- Ép kiểu số nguyên cho VietQR và Format thông tin thanh toán -->
					    <fmt:formatNumber var="rawTotal" value="${totalAmount}" pattern="#" />
					    <img id="qrImage" 
					         src="https://img.vietqr.io/image/MB-1901472008-compact2.png?amount=${rawTotal}&addInfo=ThanhToan%20Winx%20${sessionScope.currentUser.phone}&accountName=NGUYEN%20NGOC%20SUONG" 
					         alt="Mã QR Thanh Toán">
					</div>
                </div>
            </div>

            <!-- RIGHT COLUMN: Order Summary -->
            <div>
                <div class="section-box">
                    <div class="section-title">Tóm tắt đơn hàng</div>
                    
                    <div class="summary-list">
                        <c:forEach var="item" items="${cartList}">
                            <div class="summary-item">
                                <span class="summary-item-title">
                                    <c:out value="${item.productName != null ? item.productName : item.productID}"/> 
                                    <strong>(x${item.quantity})</strong>
                                </span>
                                <span class="summary-item-price">
                                    <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,##0" /> VNĐ
                                </span>
                            </div>
                        </c:forEach>
                    </div>
            
                    <div class="summary-total">
                        <span>Tổng tiền</span>
                        <span>
                            <fmt:formatNumber value="${totalAmount}" pattern="#,##0" /> VNĐ
                        </span>
                    </div>
                </div>
            </div>

        </div>

        <!-- ACTION BUTTONS -->
        <div class="actions-bar">
            <a href="${pageContext.request.contextPath}/cart?action=view" class="btn-back">
                &larr; Quay lại giỏ hàng
            </a>
            <button type="submit" id="submitBtn" class="btn-submit">Hoàn tất đặt hàng</button>
        </div>
    </form>
</div>

<script>
    function toggleQR(show) {
        document.getElementById('qr-box').style.display = show ? 'block' : 'none';
    }

    function handleFormSubmit(form) {
        const submitBtn = document.getElementById('submitBtn');
        submitBtn.disabled = true;
        submitBtn.innerText = "Đang xử lý...";
        return true;
    }
</script>

</body>
</html>