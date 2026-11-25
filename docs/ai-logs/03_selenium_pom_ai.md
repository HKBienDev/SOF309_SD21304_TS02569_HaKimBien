# Nhật ký AI: Xây dựng khung Selenium Page Object Model (Tuần 3 & 4 - Y4)

## 1. Ngữ cảnh & Mục tiêu
* **Mục tiêu:** Thiết kế và triển khai khung kiểm thử giao diện tự động (UI Automation Testing) bằng **Selenium WebDriver 4** theo mô hình kiến trúc **Page Object Model (POM)** cho dự án Website Bán Mỹ Phẩm (Cosmetic Store).
* **Yêu cầu kỹ thuật cốt lõi (Y4):**
  * Phân tách rõ ràng 2 tầng:
    * `src/test/java/com/poly/sof309/ui/pages/`: Quản lý các phần tử HTML (Locators) và các thao tác trên trang (`LoginPage.java`).
    * `src/test/java/com/poly/sof309/ui/tests/`: Chứa các kịch bản kiểm thử tự động trên trình duyệt Chrome (`LoginTest.java`).
  * Bắt buộc sử dụng **`WebDriverWait`** (`Explicit Wait`) để xử lý bất đồng bộ khi chờ phần tử DOM hiển thị hoặc sẵn sàng click, tuyệt đối không dùng `Thread.sleep()`.
  * Hỗ trợ cả chế độ chạy có giao diện ở máy Local và chế độ chạy ngầm (`--headless=new`) trên CI/CD GitHub Actions.

---

## 2. Câu lệnh đã gửi cho AI (Prompt)
> "Tôi đang làm Tuần 3 (Y4 - Selenium POM) môn SOF309 cho dự án Web Mỹ Phẩm (Java Servlet/JSP).
> Dưới đây là mã HTML thực tế của trang `src/main/webapp/views/auth/login.jsp`:
> - Ô nhập email: `<input type="email" name="email" required>`
> - Ô nhập mật khẩu: `<input type="password" name="password" required>`
> - Nút đăng nhập: `<button type="submit">Đăng nhập</button>`
> - Thông báo lỗi khi đăng nhập sai: `<div class="error-message">Sai email hoặc mật khẩu không đúng</div>`
> Hãy giúp tôi viết 2 file theo đúng chuẩn Page Object Model (POM):
> 1. `LoginPage.java`: Khai báo đúng các Locator theo `By.name` / `By.className` / `By.xpath` và dùng `WebDriverWait` (không dùng `Thread.sleep`).
> 2. `LoginTest.java`: Mở trình duyệt Chrome truy cập trang `/login`, kiểm thử luồng đăng nhập và kiểm tra kết quả hiển thị trên giao diện."

---

## 3. Kết quả do AI sinh ra (Raw Output)
* AI đã phân tích cấu trúc HTML của `login.jsp` và sinh ra bộ khung 2 class:
  1. **`LoginPage.java`:**
     * Định nghĩa 4 bộ định vị: `txtEmail = By.name("email")`, `txtPassword = By.name("password")`, `btnLogin = By.xpath("//button[@type='submit']")`, `lblErrorMessage = By.className("error-message")`.
     * Tích hợp `WebDriverWait(driver, Duration.ofSeconds(10))` cùng `ExpectedConditions.visibilityOfElementLocated(...)` và `ExpectedConditions.elementToBeClickable(...)`.
  2. **`LoginTest.java`:**
     * Thiết lập `@BeforeEach` khởi tạo `ChromeDriver` (có kiểm tra biến môi trường `CI` để bật `--headless=new`) và `@AfterEach` đóng trình duyệt bằng `driver.quit()`.
     * Xây dựng kịch bản kiểm thử đăng nhập thành công (`testLoginSuccessUI`) và đăng nhập thất bại (`testLoginFailureUI`).

---

## 4. Chỉnh sửa của Sinh viên & Lý do sửa
* **Những điểm phát hiện và tự chỉnh sửa trong quá trình chạy thực tế:**
  1. **Đồng bộ Locator với JSP thực tế:** Bản mẫu ban đầu dùng `By.id("username")` và `By.id("error-message")`, nhưng trang `login.jsp` của dự án không đặt thuộc tính `id` mà dùng `name="email"`, `name="password"` và `<div class="error-message">`. Đã sửa lại thành `By.name("email")`, `By.name("password")` và `By.className("error-message")`.
  2. **Cập nhật URL và Context Path thực tế:** Đổi `BASE_URL` từ `http://localhost:8080/login` sang đường dẫn đầy đủ khi chạy trên Apache Tomcat 11: `http://localhost:8080/SOF309_SD21304_TS02569_HaKimBien/login`.
  3. **Xử lý ràng buộc HTML5 `type="email"` và `@Disabled`:**
     * Phát hiện khi còn chú thích `@Disabled`, JUnit sẽ bỏ qua (`Skipped: 1`) khiến Chrome không bật lên $\rightarrow$ Đã xóa `@Disabled`.
     * Phát hiện ô nhập Email có `type="email"`, nếu truyền chuỗi `"admin"` (thiếu ký tự `@`) thì trình duyệt Chrome sẽ chặn submit ngay tại client $\rightarrow$ Đã đổi dữ liệu test sang đúng định dạng email có `@` và kiểm tra trạng thái dịch vụ SQL Server (`MSSQLSERVER`) trước khi chạy test.
