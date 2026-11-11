# KẾ HOẠCH KIỂM THỬ (TEST PLAN)

* **Dự án:** Website Bán Mỹ Phẩm (Cosmetic Store)
* **Sinh viên thực hiện:** Hà Kim Biên - TS02569 - Lớp SD21304
* **Môn học:** SOF309 - Kiểm thử nâng cao cùng AI
* **Vai trò:** QA Lead

---

## 1. TỔNG QUAN & MỤC TIÊU KIỂM THỬ
* **Mục tiêu chất lượng:**
  * Đảm bảo tính toàn vẹn và chính xác của logic nghiệp vụ tại tầng Controller/Servlet (`LoginController`, `RegisterController`, `ProductServlet`).
  * Tự động hóa kiểm thử giao diện người dùng (End-to-End UI Automation) với mô hình Page Object Model (POM) trên Selenium WebDriver.
  * Tích hợp kiểm thử liên tục (CI/CD) thông qua GitHub Actions nhằm phát hiện lỗi sớm khi có thay đổi mã nguồn.
* **Tiêu chuẩn hoàn thành:**
  * 100% kịch bản kiểm thử Controller (Unit Test) chạy Pass (`mvn test`).
  * 100% kịch bản UI Test với Selenium/TestNG thực thi ổn định trên môi trường local và CI Headless.
  * Pipeline GitHub Actions báo xanh (Success) và upload đầy đủ Artifacts (báo cáo + screenshots lỗi nếu có).

---

## 2. PHẠM VI KIỂM THỬ (TEST SCOPE)

### 2.1. Trong phạm vi (In-Scope)
* **Module Xác thực (Authentication):**
  * Đăng nhập: Đăng nhập Khách hàng (`role = CUSTOMER`), Đăng nhập Quản trị (`role = ADMIN`), xử lý thông tin sai/để trống.
  * Đăng ký: Đăng ký thành công, xử lý trùng lặp email, kiểm tra validation các trường bắt buộc (`name`, `email`, `phone`, `password`).
* **Module Quản lý Sản phẩm (Admin Product CRUD):**
  * Thêm mới sản phẩm (Create): Ràng buộc tên sản phẩm, giá bán (`> 0`), số lượng tồn (`>= 0`), danh mục.
  * Cập nhật sản phẩm (Update): Chỉnh sửa thông tin hợp lệ/không hợp lệ theo ID.
  * Xóa sản phẩm (Delete): Xóa bản ghi theo ID và cập nhật lại danh sách.
* **Cấp độ kiểm thử:**
  * **Unit Test / Controller Test:** Kiểm thử logic Servlet với JUnit 5, Mockito/HttpServletRequest mock, `@ParameterizedTest`, `@CsvSource`, kiểm thử ngoại lệ `assertThrows()`.
  * **UI / Integration Test:** Kiểm thử tương tác trình duyệt (Chrome) với Selenium WebDriver 4, TestNG DataProvider, POM pattern.

### 2.2. Ngoài phạm vi (Out-of-Scope)
* Kiểm thử hiệu năng chịu tải quy mô lớn (Stress Test, Load Test với JMeter).
* Kiểm thử thâm nhập bảo mật chuyên sâu (Penetration Testing, SQL Injection bypass firewall).
* Kiểm thử cổng thanh toán trực tuyến bên thứ ba (VNPay, Momo Sandbox).

---

## 3. CHIẾN LƯỢC VÀ PHƯƠNG PHÁP KIỂM THỬ (TEST STRATEGY)
Áp dụng hai kỹ thuật thiết kế ca kiểm thử hộp đen chuẩn công nghiệp:
1. **Phân vùng tương đương (Equivalence Partitioning - EP):**
   * Chia miền dữ liệu thành các vùng Hợp lệ (Valid Class) và Không hợp lệ (Invalid Class) để tối ưu số lượng test case cần chạy.
2. **Phân tích giá trị biên (Boundary Value Analysis - BVA):**
   * Tập trung kiểm tra các điểm biên: Giá trị cực tiểu hợp lệ, cận dưới không hợp lệ, giá trị 0, giá trị âm, chuỗi rỗng (`""`), chuỗi khoảng trắng (`"   "`).

---

## 4. MÔI TRƯỜNG KIỂM THỬ (TEST ENVIRONMENT)
* **Ngôn ngữ & Runtime:** Java JDK 17 (LTS)
* **Testing Framework:** JUnit 5 (Jupiter), TestNG 7.x
* **Automation Tool:** Selenium WebDriver 4.x, WebDriverManager
* **Trình duyệt thực thi:** Google Chrome (Local UI & GitHub Actions Chrome Headless `--headless=new`)
* **Hệ điều hành kiểm thử:** Windows 11 (Local) & Ubuntu Latest (GitHub Actions Runner)
* **Build Tool:** Apache Maven 3.9+

---

## 5. QUẢN LÝ RỦI RO & TIÊU CHÍ DỪNG TEST
* **Tiêu chí đình chỉ (Suspension Criteria):** Ứng dụng web không khởi động được local (lỗi kết nối CSDL, cổng 8080 bị chiếm dụng).
* **Tiêu chí nối lại (Resumption Criteria):** Khắc phục xong cấu hình DB, server khởi động thành công và truy cập được trang `/login`.
* **Tiêu chí nghiệm thu (Acceptance Criteria):** Toàn bộ test case trong `TEST_CASES.md` được tự động hóa, kết quả thực thi đạt 100% Pass.
