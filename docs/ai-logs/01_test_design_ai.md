# Nhật ký AI: Thiết kế Test Plan và Kịch bản Test Case (Tuần 1 - Y2)

## 1. Ngữ cảnh & Mục tiêu
* **Mục tiêu:** Sử dụng AI đóng vai trò QA Lead, nạp ngữ cảnh từ file đặc tả `SPECIFICATIONS.md` của dự án Website Bán Mỹ Phẩm (Cosmetic Store).
* **Nhiệm vụ:** Thiết kế kế hoạch kiểm thử (`TEST_PLAN.md`) và sinh bộ kịch bản kiểm thử (`TEST_CASES.md`) áp dụng hai kỹ thuật cốt lõi: Phân vùng tương đương (Equivalence Partitioning) và Phân tích giá trị biên (Boundary Value Analysis).
* **Áp dụng cho các chức năng:**
  * Xác thực: Đăng nhập (`/login`), Đăng ký (`/register`).
  * Quản trị: Quản lý sản phẩm CRUD (`/admin/product`).

---

## 2. Câu lệnh đã gửi cho AI (Prompt)
> "Bạn là QA Lead. Dưới đây là đặc tả nghiệp vụ dự án Web của tôi:
> ĐẶC TẢ NGHIỆP VỤ HỆ THỐNG WEB CÁ NHÂN (SPECIFICATIONS)
> 1. THÔNG TIN DỰ ÁN: Website Bán Mỹ Phẩm (Cosmetic Store) - SV: Hà Kim Biên - TS02569 - Lớp SD21304. Công nghệ: Java 17, Servlet/JSP, JDBC, Tomcat.
> 2. QUY TẮC VÀ ĐẶC TẢ NGHIỆP VỤ: Đăng nhập (Customer/Admin/Lỗi sai thông tin), Đăng ký (trùng email, validate form), Quản lý Sản phẩm (Tên không trống, Giá > 0, Số lượng >= 0, chọn Danh mục).
> 3. CÁC ĐIỀU KIỆN BIÊN: Email rỗng, trim khoảng trắng; Giá âm, giá = 0, giá ký tự; Số lượng âm, số lượng = 0.
> Hãy áp dụng kỹ thuật Phân vùng tương đương và Phân tích giá trị biên để thiết kế Test Plan và Bộ Test Case chi tiết cho Controller và UI."

---

## 3. Kết quả do AI sinh ra (Raw Output)
* AI đã phân tích tài liệu và cấu trúc hóa toàn bộ quy trình kiểm thử thành:
  1. Bản kế hoạch kiểm thử chuẩn gồm Mục tiêu, Phạm vi In-Scope/Out-of-Scope, Chiến lược EP & BVA, Môi trường kiểm thử.
  2. Bảng ma trận kịch bản kiểm thử gồm 21 Test Cases chi tiết bao phủ các lớp tương đương và giá trị biên của 3 module: Đăng nhập, Đăng ký, CRUD Sản phẩm.
  3. Phân tách rõ ràng giữa cấp độ Controller/Unit Test và UI Automation Test.

---

## 4. Chỉnh sửa của Sinh viên & Lý do sửa
* **Điểm bổ sung/tối ưu:**
  * Bổ sung trường hợp biên `trim()` cho email và password ở chức năng Đăng nhập vì mã nguồn `LoginController.java` thực tế có lệnh `email.trim()` và `password.trim()`.
  * Chuẩn hóa mã Test Case ID theo tiền tố chuẩn nghiệp vụ (`TC_AUTH_LOG_*`, `TC_AUTH_REG_*`, `TC_PROD_ADD_*`, `TC_PROD_EDIT_*`, `TC_PROD_DEL_*`) để dễ dàng map vào các hàm kiểm thử JUnit 5 và TestNG ở Tuần 2 & Tuần 3.
  * Tách riêng trường hợp kiểm thử giá trị biên của `stock = 0` (hợp lệ - cho phép thêm sản phẩm hết hàng) và `stock = -1` (không hợp lệ - ném Exception) theo đúng logic nghiệp vụ trong `ProductServlet.java`.
