<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Cập nhật Tin tức | WINX ENCHANTIX</title>

<!-- Font Awesome Icon & Google Fonts -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;600;700&display=swap" rel="stylesheet">

<style>
    :root {
        --pink-sidebar: #ff4081; 
        --pink-accent: #c2185b;  /* Màu tiêu đề hồng đậm */
        --pink-light-bg: #fff5f8;/* Màu nền trang web */
        --pink-btn: #ff6090;     /* Nút bấm hồng tươi */
        --pink-btn-hover: #e91e63;
        --border-color: #ffe0eb;
    }

    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    body {
        background-color: var(--pink-light-bg);
        font-family: 'Quicksand', sans-serif;
        color: #4a4a4a;
        min-height: 100vh;
        padding: 40px 20px;
    }

    /* CONTAINER CHÍNH CĂN GIỮA MÀN HÌNH */
    .container {
        max-width: 900px;
        margin: 0 auto;
    }

    .topbar {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-bottom: 30px;
    }

    .topbar h1 {
        color: var(--pink-accent);
        font-size: 2.2rem;
        font-weight: 700;
        margin-bottom: 6px;
    }

    .topbar p {
        color: #888888;
        font-size: 0.95rem;
    }

    /* Nút Quay Lại */
    .btn-add {
        background-color: var(--pink-btn);
        color: #ffffff !important;
        text-decoration: none;
        padding: 12px 28px;
        border-radius: 25px;
        font-weight: 700;
        font-size: 0.95rem;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        border: none;
        box-shadow: 0 4px 12px rgba(255, 96, 144, 0.3);
        transition: all 0.25s ease;
        cursor: pointer;
    }

    .btn-add:hover {
        background-color: var(--pink-btn-hover);
        transform: translateY(-2px);
    }

    /* FORM CARD */
    .card {
        background: #ffffff;
        border-radius: 20px;
        padding: 40px;
        box-shadow: 0 8px 25px rgba(255, 64, 129, 0.05);
        border: 1px solid var(--border-color);
    }

    .form-group {
        margin-bottom: 25px;
    }

    .form-group label {
        display: block;
        font-weight: 700;
        color: var(--pink-accent);
        margin-bottom: 10px;
        font-size: 1rem;
    }

    .form-group label i {
        margin-right: 8px;
        color: var(--pink-sidebar);
    }

    .form-group input[type="text"],
    .form-group textarea {
        width: 100%;
        padding: 14px 18px;
        border: 1px solid var(--border-color);
        border-radius: 12px;
        outline: none;
        font-family: inherit;
        font-size: 0.95rem;
        color: #333;
        transition: all 0.25s ease;
        background-color: #fff;
    }

    .form-group input[type="text"]:focus,
    .form-group textarea:focus {
        border-color: var(--pink-sidebar);
        box-shadow: 0 0 8px rgba(255, 64, 129, 0.15);
    }

    .image-preview {
        width: 220px;
        height: 140px;
        object-fit: cover;
        border-radius: 12px;
        border: 2px solid var(--border-color);
        margin-top: 12px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        display: block;
    }

    .btn-delete {
        background: #ffe0eb;
        color: var(--pink-accent) !important;
        border-radius: 25px;
        padding: 12px 28px;
        font-weight: 700;
        font-size: 0.95rem;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.25s ease;
        border: none;
        cursor: pointer;
    }

    .btn-delete:hover {
        background: #ffd0e0;
        transform: translateY(-2px);
    }
</style>

</head>

<body>

<div class="container">

    <div class="topbar">
        <div>
            <h1>Cập nhật Tin tức</h1>
            <p>WINX ENCHANTIX Cosmetics Admin</p>
        </div>

        <a href="${pageContext.request.contextPath}/admin/news" class="btn-add">
            <i class="fa fa-arrow-left"></i> Quay lại
        </a>
    </div>

    <div class="card">

        <!-- Bỏ enctype="multipart/form-data" -->
        <form id="editNewsForm" action="${pageContext.request.contextPath}/admin/news/update" method="post">

            <input type="hidden" name="id" value="${item.id}">

            <div class="form-group">
                <label for="title"><i class="fa fa-heading"></i> Tiêu đề</label>
                <input type="text" id="title" name="title" value="${item.title}" required>
            </div>

            <div class="form-group">
                <label for="summary"><i class="fa fa-align-left"></i> Tóm tắt</label>
                <textarea id="summary" rows="3" name="summary" required>${item.summary}</textarea>
            </div>

            <div class="form-group">
                <label for="content"><i class="fa fa-file-lines"></i> Nội dung</label>
                <textarea id="content" rows="8" name="content" required>${item.content}</textarea>
            </div>

            <!-- Ô NHẬP LINK HÌNH ẢNH (URL) -->
            <div class="form-group">
                <label for="photoUrl"><i class="fa fa-link"></i> Link hình ảnh (URL)</label>
                <input type="text" 
                       id="photoUrl" 
                       name="photoUrl" 
                       value="${item.image}" 
                       placeholder="Dán đường dẫn hình ảnh tại đây..."
                       required>

                <!-- KHUNG XEM TRƯỚC HÌNH ẢNH -->
                <img id="preview"
                     class="image-preview"
                     src="${item.image}"
                     alt="Xem trước hình ảnh"
                     onerror="this.style.display='none';">
            </div>

            <div style="display:flex; gap:15px; margin-top: 30px;">
                <button type="submit" class="btn-add">
                    <i class="fa fa-floppy-disk"></i> Cập nhật
                </button>

                <button type="reset" class="btn-delete">
                    <i class="fa fa-rotate"></i> Khôi phục
                </button>
            </div>

        </form>

    </div>

</div>

<script>
    const photoUrlInput = document.getElementById("photoUrl");
    const previewImage = document.getElementById("preview");
    const editNewsForm = document.getElementById("editNewsForm");
    const initialImageSrc = "${item.image}";

    // Cập nhật khung xem trước hình ảnh thời gian thực khi dán/sửa link
    photoUrlInput.addEventListener("input", function () {
        const url = this.value.trim();
        if (url) {
            previewImage.src = url;
            previewImage.style.display = "block";
        } else {
            previewImage.src = "";
            previewImage.style.display = "none";
        }
    });

    // Nếu ảnh bị lỗi/link hỏng thì tự ẩn khung preview
    previewImage.addEventListener("error", function () {
        this.style.display = "none";
    });

    // Khi nhấn nút Khôi phục (Reset), trả lại giá trị đường dẫn ảnh ban đầu
    editNewsForm.addEventListener("reset", function () {
        setTimeout(() => {
            if (initialImageSrc) {
                previewImage.src = initialImageSrc;
                previewImage.style.display = "block";
            } else {
                previewImage.src = "";
                previewImage.style.display = "none";
            }
        }, 0);
    });
</script>

</body>
</html>