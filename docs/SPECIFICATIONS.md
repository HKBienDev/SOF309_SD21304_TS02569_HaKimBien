# ĐẶC TẢ NGHIỆP VỤ HỆ THỐNG WEB CÁ NHÂN (SPECIFICATIONS)
> *Tài liệu đặc tả nghiệp vụ dùng làm ngữ cảnh chuẩn (Context) cho AI sinh Test Plan & Test Case tự động.*

---

## 1. THÔNG TIN DỰ ÁN
* **Tên đề tài:** Website Bán Mỹ Phẩm (Cosmetic Store)
* **Sinh viên thực hiện:** Hà Kim Biên - TS02569 - Lớp SD21304
* **Công nghệ nền tảng:** Java 17, Jakarta Servlet 5/6, JSP, JSTL, JDBC / SQL Server, Tomcat Server
* **URL môi trường local:** `http://localhost:8080/`

---

## 2. QUY TẮC VÀ ĐẶC TẢ NGHIỆP VỤ CHI TIẾT (BUSINESS RULES)

### 2.1. Phân hệ Xác thực & Tài khoản (Authentication)

#### A. Chức năng Đăng nhập (`/login`)
* **Endpoint xử lý:** `LoginController` mapping `@WebServlet("/login")`
* **Giao diện:** `/views/auth/login.jsp`
* **Dữ liệu đầu vào:**
  * `email`: Chuỗi ký tự, cắt khoảng trắng đầu/cuối (`trim()`), định dạng email hợp lệ.
  * `password`: Chuỗi mật khẩu (`trim()`).
* **Quy tắc xử lý:**
  1. Kiểm tra tài khoản Khách hàng (`CustomerDAO.checkLogin(email, password)`):
     * Nếu khớp: Cấp quyền `role = "CUSTOMER"`, lưu session `currentUser`, chuyển hướng sang `/home`.
  2. Kiểm tra tài khoản Quản trị (`AccountDAO.login(email, password)`):
     * Nếu khớp: Cấp quyền `role = "ADMIN"`, lưu session `currentUser`, chuyển hướng sang `/admin/dashboard`.
  3. Nếu sai thông tin:
     * Giữ lại giá trị `oldEmail`.
     * Hiển thị thông báo lỗi: `"Sai email hoặc mật khẩu không đúng"`.
     * Giữ nguyên trang đăng nhập `/views/auth/login.jsp`.

#### B. Chức năng Đăng ký tài khoản Khách hàng (`/register`)
* **Endpoint xử lý:** `RegisterController` mapping `@WebServlet("/register")`
* **Giao diện:** `/views/auth/register.jsp`
* **Dữ liệu đầu vào:**
  * `name`: Họ và tên khách hàng (CustomerName) - bắt buộc.
  * `email`: Địa chỉ email - bắt buộc, duy nhất trong hệ thống.
  * `phone`: Số điện thoại - bắt buộc.
  * `password`: Mật khẩu đăng nhập - bắt buộc.
* **Quy tắc xử lý:**
  1. Kiểm tra trùng email trong bảng `Customer`:
     * Nếu email đã tồn tại: Báo lỗi `"Email này đã được sử dụng"`, không lưu vào DB.
  2. Thêm mới tài khoản:
     * Thực hiện thêm bản ghi vào DB với địa chỉ mặc định là `"Chưa cập nhật"`.
     * Thành công: Chuyển hướng thẳng sang trang đăng nhập (`/login`).
     * Thất bại hoặc lỗi hệ thống: Báo lỗi `"Đăng ký thất bại, vui lòng thử lại"` hoặc thông báo ngoại lệ tương ứng.

---

### 2.2. Phân hệ Quản trị (Admin) - Quản lý Sản phẩm (Product CRUD)
* **Endpoint xử lý:** `ProductServlet` mapping `/admin/product`, `/admin/products`
* **Giao diện:** Danh sách `/views/admin/products/list-sp.jsp`, Form thêm/sửa `/views/admin/products/form.jsp`

#### A. Ràng buộc trường dữ liệu (Validation Rules) khi Thêm / Sửa:
* **Tên sản phẩm (`productName`):**
  * Bắt buộc, không được để trống hoặc chỉ có khoảng trắng.
  * Báo lỗi: `"Tên sản phẩm không được để trống."`
* **Giá bán (`price`):**
  * Bắt buộc nhập, phải là kiểu số (`BigDecimal`).
  * Giá trị phải lớn hơn 0 (`price > 0`).
  * Báo lỗi: `"Vui lòng nhập giá."` hoặc `"Giá phải lớn hơn 0."`
* **Giá khuyến mãi (`discountPrice`):**
  * Tùy chọn (Optional), nếu nhập phải lớn hơn 0.
* **Số lượng kho (`stock`):**
  * Bắt buộc nhập, phải là số nguyên (`Integer`).
  * Giá trị không được âm (`stock >= 0`).
  * Báo lỗi: `"Vui lòng nhập số lượng."` hoặc `"Số lượng không được âm."`
* **Danh mục (`category`):**
  * Bắt buộc chọn mã danh mục hợp lệ (`categoryID`).
  * Báo lỗi nếu thiếu: `"Vui lòng chọn loại sản phẩm."`
* **Hình ảnh & Mô tả (`image`, `description`):** Tùy chọn.

#### B. Các luồng xử lý (Actions):
* `action = new`: Mở form tạo mới sản phẩm rỗng.
* `action = edit&id={id}`: Tìm sản phẩm theo `id`, đổ dữ liệu vào form cập nhật.
* `action = delete&id={id}`: Xóa sản phẩm khỏi DB, sau đó load lại danh sách.
* `POST` form:
  * Nếu không có `id`: Gọi `ProductDao.create(product)` (Thêm mới).
  * Nếu có `id`: Gọi `ProductDao.update(product)` (Cập nhật).
  * Thành công: Chuyển hướng về `/admin/product`.

---

## 3. CÁC ĐIỀU KIỆN BIÊN CẦN KIỂM THỬ (BOUNDARY & EQUIVALENCE)
1. **Email / Username:** Chuỗi rỗng, định dạng sai (`abc@`, `abc.com`), chuỗi chứa khoảng trắng đầu/cuối, email trùng lặp đã có trong DB.
2. **Giá bán:** Số âm (`-1000`), số 0, số dương cực lớn, ký tự chữ (`abc`).
3. **Số lượng:** Số âm (`-1`), số 0, ký tự không phải số.
