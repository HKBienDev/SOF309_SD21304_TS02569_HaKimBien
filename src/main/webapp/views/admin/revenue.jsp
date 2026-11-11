<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản lý doanh thu</title>

<!-- Font & Chart.js -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
:root {
	--pink-gradient: linear-gradient(135deg, #ff758c 0%, #ff7eb3 100%);
	--pink-dark: #d81b60;
	--pink-soft: #fff0f5;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

body {
	background: #fff8fa;
	color: #4a4a4a;
	padding: 20px;
}

.revenue-container {
	width: 100%;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 25px;
}

.header h1 {
	color: var(--pink-dark);
	font-size: 24px;
	font-weight: 700;
}

.dashboard {
	display: flex;
	gap: 20px;
	margin-bottom: 25px;
}

.card {
	flex: 1;
	background: white;
	border-radius: 16px;
	padding: 20px;
	box-shadow: 0 8px 20px rgba(255, 117, 140, 0.08);
	border: 1px solid #ffe3ec;
}

.card p {
	font-size: 13px;
	color: #888;
	margin-bottom: 8px;
}

.card h2 {
	color: var(--pink-dark);
	font-size: 22px;
}

.search-card, .table-card {
	background: white;
	padding: 25px;
	border-radius: 16px;
	margin-bottom: 25px;
	box-shadow: 0 8px 20px rgba(255, 117, 140, 0.08);
	border: 1px solid #ffe3ec;
}

.search-card form {
	display: flex;
	gap: 20px;
	align-items: flex-end;
}

.form-group {
	display: flex;
	flex-direction: column;
	gap: 6px;
}

.form-group label {
	font-size: 13px;
	font-weight: 600;
	color: #555;
}

.form-group input {
	padding: 9px 14px;
	border: 1px solid #ffccd5;
	border-radius: 8px;
	outline: none;
}

.form-group input:focus {
	border-color: #ff758c;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 15px;
}

table th, table td {
	padding: 14px;
	border-bottom: 1px solid #ffe3ec;
	text-align: left;
}

table th {
	background: var(--pink-soft);
	color: var(--pink-dark);
	font-size: 13px;
}

button {
	background: var(--pink-gradient);
	color: white;
	border: none;
	padding: 10px 24px;
	border-radius: 8px;
	font-weight: 600;
	cursor: pointer;
	transition: opacity 0.3s ease;
}

button:hover {
	opacity: 0.9;
}

.empty {
	text-align: center;
	color: #aaa;
}

.btn-home {
	background: #fce4ec;
	color: #c2185b;
	padding: 8px 18px;
	border-radius: 8px;
	text-decoration: none;
	font-size: 13px;
	font-weight: 600;
}
</style>
</head>

<body>

	<div class="revenue-container">

		<div class="header">
			<h1>Quản Lý Doanh Thu</h1>
			<a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-home">Trang chủ</a>
		</div>

		<!-- Thống kê tổng quan -->
		<div class="dashboard">
			<div class="card">
				<p>TỔNG DOANH THU</p>
				<h2>
					<fmt:formatNumber value="${totalRevenue}" type="number" /> VNĐ
				</h2>
			</div>

			<div class="card">
				<p>TỔNG HÓA ĐƠN</p>
				<h2>${totalBills}</h2>
			</div>

			<div class="card">
				<p>SẢN PHẨM BÁN CHẠY NHẤT</p>
				<h2>
					<c:choose>
						<c:when test="${not empty topProductList}">
							${topProductList[0].productName}
						</c:when>
						<c:otherwise>---</c:otherwise>
					</c:choose>
				</h2>
			</div>
		</div>

		<!-- Form Thống kê -->
		<div class="search-card">
			<form action="${pageContext.request.contextPath}/admin/revenue" method="get">
				<div class="form-group">
					<label>Từ ngày</label>
					<input type="date" name="fromDate" value="${param.fromDate}">
				</div>

				<div class="form-group">
					<label>Đến ngày</label>
					<input type="date" name="toDate" value="${param.toDate}">
				</div>

				<button type="submit">Thống kê</button>
			</form>
		</div>

		<!-- Biểu đồ doanh thu -->
		<div class="table-card">
			<h2 style="font-size: 16px; color: var(--pink-dark); margin-bottom: 15px;">Biểu đồ doanh thu</h2>
			<div style="height: 320px; position: relative;">
				<canvas id="revenueChart"></canvas>
			</div>
		</div>

		<!-- Bảng doanh thu theo ngày -->
		<div class="table-card">
			<h2 style="font-size: 16px; color: var(--pink-dark); margin-bottom: 10px;">Doanh thu theo ngày</h2>
			<table>
				<thead>
					<tr>
						<th>STT</th>
						<th>Ngày</th>
						<th>Số hóa đơn</th>
						<th>Doanh thu</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty revenueList}">
							<tr>
								<td colspan="4" class="empty">Không có dữ liệu</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${revenueList}" var="item" varStatus="st">
								<tr>
									<td>${st.index + 1}</td>
									<td><fmt:formatDate value="${item.revenueDate}" pattern="dd/MM/yyyy" /></td>
									<td>${item.totalBills}</td>
									<td style="color: #d81b60; font-weight: 600;">
										<fmt:formatNumber value="${item.totalRevenue}" type="number" /> VNĐ
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>

		<!-- Top 5 sản phẩm bán chạy -->
		<div class="table-card">
			<h2 style="font-size: 16px; color: var(--pink-dark); margin-bottom: 10px;">Top 5 sản phẩm bán chạy</h2>
			<table>
				<thead>
					<tr>
						<th>Hạng</th>
						<th>Mã SP</th>
						<th>Tên sản phẩm</th>
						<th>Số lượng bán</th>
						<th>Doanh thu</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty topProductList}">
							<tr>
								<td colspan="5" class="empty">Không có dữ liệu</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${topProductList}" var="item" varStatus="st">
								<tr>
									<td style="font-weight: 700; color: var(--pink-dark);">#${st.index + 1}</td>
									<td>${item.productID}</td>
									<td>${item.productName}</td>
									<td>${item.totalQuantitySold}</td>
									<td style="color: #d81b60; font-weight: 600;">
										<fmt:formatNumber value="${item.totalRevenue}" type="number" /> VNĐ
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>

	</div>

	<!-- Script vẽ biểu đồ (được đặt ở cuối file để tránh lỗi null canvas) -->
	<script>
		const labels = [
			<c:forEach items="${revenueList}" var="item">
				"${item.revenueDate}",
			</c:forEach>
		];

		const revenues = [
			<c:forEach items="${revenueList}" var="item">
				${item.totalRevenue},
			</c:forEach>
		];

		const ctx = document.getElementById("revenueChart").getContext("2d");
		new Chart(ctx, {
		    type: "line",
		    data: {
		        labels: labels,
		        datasets: [
		            {
		                label: "Doanh thu (VNĐ)",
		                data: revenues,
		                borderColor: "#ff758c",
		                backgroundColor: "rgba(255, 117, 140, 0.15)",
		                borderWidth: 3,
		                fill: true,
		                tension: 0.4
		            }
		        ]
		    },
		    options: {
		        responsive: true,
		        maintainAspectRatio: false
		    }
		});
	</script>

</body>
</html>