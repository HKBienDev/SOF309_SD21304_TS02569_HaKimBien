<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Tin tức - WINX ENCHANTIX</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <style>
        :root {
            --primary-pink: #ff66a3;
            --light-pink: #fff0f5;
            --dark-pink: #d11a5b;
            --soft-white: #ffffff;
            --gray-text: #757575;
            --border-color: #ffe4e1;
            --shadow: 0 4px 15px rgba(255, 102, 163, 0.15);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: var(--light-pink);
            min-height: 100vh;
        }

        /* --- MAIN CONTENT STYLE --- */
        .main {
            flex: 1;
            padding: 40px 20px;
            max-width: 1000px;
            margin: 0 auto;
        }

        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .topbar h1 {
            color: var(--dark-pink);
            font-size: 28px;
            font-weight: 700;
        }

        .topbar p {
            color: var(--gray-text);
            font-size: 14px;
            margin-top: 5px;
        }

        .topbar-buttons {
            display: flex;
            gap: 12px;
        }

        /* BUTTONS */
        .btn-home {
            background-color: #ffe6f0;
            color: var(--dark-pink);
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 25px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            border: 1px solid var(--border-color);
        }

        .btn-home:hover {
            background-color: var(--primary-pink);
            color: var(--soft-white);
        }

        .btn-add {
            background-color: var(--primary-pink);
            color: var(--soft-white);
            text-decoration: none;
            padding: 10px 22px;
            border-radius: 25px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: var(--shadow);
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-add:hover {
            background-color: var(--dark-pink);
            transform: translateY(-2px);
        }

        .btn-delete {
            background-color: #fff0f0;
            color: #ff4d4d;
            padding: 10px 22px;
            border-radius: 25px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .btn-delete:hover {
            background-color: #ff4d4d;
            color: var(--soft-white);
        }

        /* --- CARD & FORM STYLE --- */
        .card {
            background-color: var(--soft-white);
            border-radius: 15px;
            padding: 35px;
            box-shadow: var(--shadow);
        }

        .form-group {
            margin-bottom: 22px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--dark-pink);
            font-weight: 600;
            font-size: 15px;
        }

        .form-group label i {
            margin-right: 6px;
            color: var(--primary-pink);
        }

        .form-group input[type="text"],
        .form-group textarea {
            width: 100%;
            padding: 12px 18px;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            outline: none;
            background-color: #fffafc;
            font-size: 14px;
            color: #444;
            transition: all 0.3s;
        }

        .form-group input[type="text"]:focus,
        .form-group textarea:focus {
            border-color: var(--primary-pink);
            background-color: var(--soft-white);
            box-shadow: 0 0 8px rgba(255, 102, 163, 0.25);
        }

        .image-preview {
            width: 220px;
            height: 140px;
            object-fit: cover;
            border-radius: 12px;
            border: 2px solid var(--border-color);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-top: 12px;
            display: none; /* Mặc định ẩn đi cho đến khi có link */
        }
    </style>
</head>

<body>

<!-- MAIN -->
<div class="main">

    <div class="topbar">
        <div>
            <h1>Thêm Tin tức</h1>
            <p>WINX ENCHANTIX Cosmetics Admin</p>
        </div>

        <div class="topbar-buttons">
            <!-- NÚT VỀ TRANG CHỦ -->
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-home">
                <i class="fa fa-home"></i> Trang chủ
            </a>

            <!-- NÚT QUAY LẠI DANH SÁCH -->
            <a href="${pageContext.request.contextPath}/admin/news" class="btn-add">
                <i class="fa fa-arrow-left"></i> Danh sách
            </a>
        </div>
    </div>

    <div class="card">
        <form id="newsForm" 
              action="${pageContext.request.contextPath}/admin/news/create"
              method="post">

            <div class="form-group">
                <label for="title">
                    <i class="fa fa-heading"></i> Tiêu đề
                </label>
                <input type="text"
                       id="title"
                       name="title"
                       placeholder="Nhập tiêu đề tin tức..."
                       required>
            </div>

            <div class="form-group">
                <label for="summary">
                    <i class="fa fa-align-left"></i> Tóm tắt
                </label>
                <textarea id="summary"
                          rows="3"
                          name="summary"
                          placeholder="Nhập nội dung tóm tắt ngắn..."
                          required></textarea>
            </div>

            <div class="form-group">
                <label for="content">
                    <i class="fa fa-file-lines"></i> Nội dung
                </label>
                <textarea id="content"
                          rows="8"
                          name="content"
                          placeholder="Nhập nội dung chi tiết bài viết..."
                          required></textarea>
            </div>

            <!-- NHẬP DÁN LINK HÌNH ẢNH -->
            <div class="form-group">
                <label for="photoUrl">
                    <i class="fa fa-link"></i> Link hình ảnh (URL)
                </label>
                <input type="text"
                       name="photoUrl"
                       id="photoUrl"
                       placeholder="Dán đường dẫn hình ảnh tại đây (vd: https://example.com/image.jpg)..."
                       required>
                
                <img id="preview"
                     class="image-preview"
                     src=""
                     alt="Xem trước hình ảnh bài viết">
            </div>

            <div style="display: flex; gap: 15px; margin-top: 25px;">
                <button type="submit" class="btn-add">
                    <i class="fa fa-floppy-disk"></i> Lưu bài viết
                </button>

                <button type="reset" class="btn-delete">
                    <i class="fa fa-rotate"></i> Làm mới
                </button>
            </div>

        </form>
    </div>

</div>

<script>
    const photoUrlInput = document.getElementById("photoUrl");
    const previewImage = document.getElementById("preview");
    const newsForm = document.getElementById("newsForm");

    // Lắng nghe sự kiện người dùng dán hoặc gõ link vào ô input
    photoUrlInput.addEventListener("input", function () {
        const url = this.value.trim();
        if (url) {
            previewImage.src = url;
            previewImage.style.display = "block"; // Hiện khung xem trước khi có chuỗi URL
        } else {
            previewImage.src = "";
            previewImage.style.display = "none";  // Ẩn khung xem trước nếu để trống
        }
    });

    // Ẩn ảnh xem trước nếu link bị hỏng/lỗi tải ảnh
    previewImage.addEventListener("error", function () {
        this.style.display = "none";
    });

    // Khôi phục form về trạng thái ban đầu khi nhấn nút Làm mới (Reset)
    newsForm.addEventListener("reset", function () {
        setTimeout(() => {
            previewImage.src = "";
            previewImage.style.display = "none";
        }, 0);
    });
</script>

</body>
</html>