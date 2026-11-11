<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sản phẩm | WINX ENCHANTIX</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    :root {
        --pink-main: #ff758c;
        --pink-gradient: linear-gradient(135deg, #ff758c 0%, #ff7eb3 100%);
        --pink-soft: #fff0f5;
        --pink-hover: #ff5277;
    }

    body {
        background-color: #fff8fa;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #4a4a4a;
    }

    .form-container {
        max-width: 650px;
        margin: 40px auto;
        background: #ffffff;
        padding: 35px;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(255, 117, 140, 0.15);
        border: 1px solid #ffe3ec;
    }

    .form-title {
        color: #d81b60;
        font-weight: 700;
        position: relative;
        padding-bottom: 15px;
        margin-bottom: 25px;
    }

    .form-title::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 80px;
        height: 4px;
        background: var(--pink-gradient);
        border-radius: 10px;
    }

    .form-label {
        font-weight: 600;
        color: #d81b60;
        margin-bottom: 8px;
    }

    .form-control, .form-select {
        border-radius: 10px;
        border: 1.5px solid #ffd1dc;
        padding: 10px 15px;
        transition: all 0.3s ease;
    }

    .form-control:focus, .form-select:focus {
        border-color: var(--pink-main);
        box-shadow: 0 0 8px rgba(255, 117, 140, 0.3);
    }

    .image-preview-wrapper {
        width: 100px;
        height: 100px;
        border-radius: 15px;
        border: 2px dashed #ffb7c5;
        background-color: #fff8fa;
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
    }

    .image-preview-wrapper img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .btn-pink-primary {
        background: var(--pink-gradient);
        color: #fff;
        border: none;
        border-radius: 10px;
        padding: 10px 25px;
        font-weight: 600;
    }

    .btn-pink-primary:hover {
        background: linear-gradient(135deg, #ff5277 0%, #ff68a4 100%);
        color: #fff;
    }

    .btn-pink-outline {
        background: transparent;
        color: #d81b60;
        border: 1.5px solid var(--pink-main);
        border-radius: 10px;
        padding: 10px 20px;
        font-weight: 600;
        text-decoration: none;
    }

    .btn-home {
        background: #fce4ec;
        color: #c2185b;
        border: none;
        border-radius: 10px;
        padding: 10px 20px;
        font-weight: 600;
        text-decoration: none;
    }
</style>
</head>

<body>

<div class="container">

    <div class="form-container">

        <h2 class="text-center form-title">
            <i class="fa-solid fa-wand-magic-sparkles me-2"></i>
            ${product == null || product.productID == 0 ? "THÊM SẢN PHẨM" : "CẬP NHẬT SẢN PHẨM"}
        </h2>

        <c:if test="${not empty error}">
            <div class="alert alert-danger d-flex align-items-center mb-4">
                <i class="fa-solid fa-circle-exclamation me-2 fs-5"></i>
                <div>${error}</div>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/product" method="post">

            <input type="hidden" name="productID" value="${product.productID}">

            <div class="mb-3">
                <label class="form-label">
                    <i class="fa-solid fa-box-open me-1"></i> Tên sản phẩm
                </label>
                <input type="text" class="form-control" name="productName" value="${product.productName}" required>
            </div>

            <!-- Ô NHẬP LINK/URL ẢNH TRỰC TIẾP -->
            <div class="mb-3">
                <label class="form-label">
                    <i class="fa-solid fa-image me-1"></i> Đường dẫn hình ảnh (URL)
                </label>
                
                <div class="d-flex gap-3 align-items-center">
                    <!-- Xem trước ảnh -->
                    <div class="image-preview-wrapper flex-shrink-0">
                        <c:choose>
                            <c:when test="${empty product.image}">
                                <c:set var="imgSrc" value="https://via.placeholder.com/100?text=No+Image" />
                            </c:when>
                            <c:when test="${product.image.startsWith('http://') || product.image.startsWith('https://')}">
                                <c:set var="imgSrc" value="${product.image}" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="imgSrc" value="${pageContext.request.contextPath}/${product.image}" />
                            </c:otherwise>
                        </c:choose>

                        <img id="previewImg" 
                             src="${imgSrc}" 
                             alt="Preview"
                             referrerpolicy="no-referrer"
                             onerror="this.src='https://via.placeholder.com/100?text=Error';">
                    </div>

                    <!-- Input nhập Link -->
                    <div class="flex-grow-1">
                        <input type="text" 
                             class="form-control" 
                             name="image" 
                             id="imageUrlInput"
                             value="${product.image}"
                             placeholder="Dán link ảnh tại đây (VD: https://...)"
                             oninput="updatePreviewImage(this.value)">
                        <small class="text-muted mt-1 d-block">
                            <i class="fa-solid fa-circle-info me-1"></i> Dán liên kết ảnh trực tiếp từ Google / Web khác.
                        </small>
                    </div>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label"><i class="fa-solid fa-tag me-1"></i> Giá (VNĐ)</label>
                <input type="number" class="form-control" name="price" value="${product.price}" min="1" step="any" required>
            </div>

            <!-- Ô NHẬP GIÁ ĐÃ GIẢM -->
            <div class="mb-3">
                <label class="form-label"><i class="fa-solid fa-tags me-1"></i> Giá đã giảm (VNĐ)</label>
                <input type="number" class="form-control" name="discountPrice" value="${product.discountPrice}" min="0" step="any" placeholder="Nhập giá khuyến mãi (nếu có)">
            </div>

            <div class="mb-3">
                <label class="form-label"><i class="fa-solid fa-cubes me-1"></i> Số lượng</label>
                <input type="number" class="form-control" name="stockQuantity" value="${product.stockQuantity}" min="0" required>
            </div>

            <!-- Ô NHẬP MÔ TẢ CHI TIẾT SẢN PHẨM -->
            <div class="mb-3">
                <label class="form-label"><i class="fa-solid fa-align-left me-1"></i> Mô tả chi tiết</label>
                <textarea class="form-control" name="description" rows="4" placeholder="Nhập thông tin mô tả chi tiết sản phẩm...">${product.description}</textarea>
            </div>

            <div class="mb-4">
                <label class="form-label"><i class="fa-solid fa-layer-group me-1"></i> Loại sản phẩm</label>
                <select class="form-select" name="categoryID" required>
                    <option value="">-- Chọn loại sản phẩm --</option>
                    <c:forEach items="${categories}" var="c">
                        <option value="${c.categoryID}" <c:if test="${product != null && product.categoryID == c.categoryID}">selected</c:if>>
                            ${c.categoryName}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="d-flex flex-wrap gap-2 justify-content-between pt-2">
                <div>
                    <button type="submit" class="btn btn-pink-primary">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Lưu
                    </button>
                    <a href="${pageContext.request.contextPath}/product" class="btn btn-pink-outline ms-1">
                        <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
                    </a>
                </div>

                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-home">
                    <i class="fa-solid fa-house me-1"></i> Trang chủ
                </a>
            </div>

        </form>

    </div>

</div>

<!-- Script xem trước ảnh khi dán link vào ô input -->
<script>
    const contextPath = "${pageContext.request.contextPath}";

    function updatePreviewImage(url) {
        const preview = document.getElementById('previewImg');
        const trimmedUrl = url ? url.trim() : '';

        if (!trimmedUrl) {
            preview.src = 'https://via.placeholder.com/100?text=No+Image';
        } else if (trimmedUrl.startsWith('http://') || trimmedUrl.startsWith('https://')) {
            preview.src = trimmedUrl;
        } else {
            preview.src = contextPath + '/' + trimmedUrl;
        }
    }
</script>

</body>
</html>