# Nhật ký AI: Viết Unit Test Controller với JUnit 5 nâng cao (Tuần 2 - Y3)

## 1. Ngữ cảnh & Mục tiêu
* **Mục tiêu:** Xây dựng bộ Unit Test tự động cho tầng Controller/Servlet của Website Bán Mỹ Phẩm (Cosmetic Store) bằng JUnit 5.
* **Yêu cầu kỹ thuật cốt lõi (Y3):**
  * Áp dụng `@ParameterizedTest` kết hợp `@CsvSource` để quét các giá trị biên của form Đăng nhập và Đăng ký.
  * Áp dụng kiểm thử ngoại lệ `assertThrows()` để bắt các lỗi vi phạm nghiệp vụ (tên sản phẩm để trống, giá bán <= 0, số lượng âm, email trùng lặp).
  * Áp dụng `@Timeout` để kiểm soát hiệu năng thực thi của các phương thức kiểm thử.
  * Đạt tỷ lệ thực thi thành công 100% Pass (`mvn test`).

---

## 2. Câu lệnh đã gửi cho AI (Prompt)
> "Tôi đang làm Assignment môn SOF309 cho dự án Web Mỹ Phẩm (Servlet/JSP).
> Dưới đây là bộ Test Cases từ file docs/TEST_CASES.md:
> - Đăng nhập: Kiểm tra hợp lệ (Customer/Admin), trim khoảng trắng, mật khẩu trống, sai thông tin.
> - Sản phẩm: Tên không để trống, Giá > 0, Số lượng >= 0, chọn Danh mục hợp lệ.
> Hãy viết 2 class Unit Test bằng JUnit 5:
> 1. AuthControllerTest.java: Dùng @ParameterizedTest và @CsvSource kiểm tra biên đăng nhập.
> 2. ProductServletTest.java: Dùng assertThrows() kiểm tra bắt ngoại lệ khi dữ liệu sản phẩm không hợp lệ, và dùng @Timeout.
> Code cần dễ đọc, có chú thích chi tiết tương ứng với từng mã Test Case ID."

---

## 3. Kết quả do AI sinh ra (Raw Output)
* AI đã tạo ra khung mã nguồn cho 2 class kiểm thử:
  * `AuthControllerTest.java` với hàm `testLoginValidation()` nhận 5 tham số từ `@CsvSource`, mô phỏng chính xác logic xác thực tài khoản và kiểm tra cơ chế `trim()`.
  * `ProductServletTest.java` chứa các hàm kiểm thử độc lập sử dụng `assertThrows(Exception.class, ...)` để kiểm tra các ngoại lệ nghiệp vụ: `validateProductName()`, `validatePrice()`, `validateStockQuantity()`, `validateCategory()`.

---

## 4. Chỉnh sửa của Sinh viên & Lý do sửa
* **Tinh chỉnh mã nguồn:**
  * Đồng bộ chính xác thông điệp ngoại lệ trong test với mã nguồn gốc của `ProductServlet.java`:
    * Thông điệp tên rỗng: `"Tên sản phẩm không được để trống."`
    * Thông điệp giá sai: `"Giá phải lớn hơn 0."`
    * Thông điệp số lượng âm: `"Số lượng không được âm."`
  * Bổ sung trường hợp biên `stock = 0` (hợp lệ - sản phẩm hết hàng) không bị ném ngoại lệ.
  * Bổ sung chú thích `@DisplayName` rõ ràng hiển thị mã Test Case ID (`TC_AUTH_LOG_*`, `TC_PROD_ADD_*`) để khi chạy test trên IDE hoặc Maven Surefire Report nhìn thấy rõ ràng từng kịch bản.
