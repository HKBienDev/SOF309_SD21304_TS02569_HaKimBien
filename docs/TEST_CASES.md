# BỘ KỊCH BẢN KIỂM THỬ CHI TIẾT (TEST CASES)
> *Áp dụng kỹ thuật **Phân vùng tương đương (Equivalence Partitioning)** và **Phân tích giá trị biên (Boundary Value Analysis)** cho cả Controller Unit Test và UI Automation Test.*

---

## I. MODULE 1: ĐĂNG NHẬP (AUTHENTICATION - LOGIN)

| Test Case ID | Tầng kiểm thử | Kỹ thuật áp dụng | Mô tả ca kiểm thử | Loại (Pos/Neg) | Dữ liệu đầu vào (Test Data) | Kết quả mong đợi |
| :---: | :---: | :---: | :--- | :---: | :--- | :--- |
| **TC_AUTH_LOG_01** | UI / Controller | Equivalence (Valid) | Đăng nhập thành công tài khoản Khách hàng | Positive | `email`: `"customer@gmail.com"`, `password`: `"123456"` | Cấp role `CUSTOMER`, session `currentUser`, chuyển hướng sang `/home` |
| **TC_AUTH_LOG_02** | UI / Controller | Equivalence (Valid) | Đăng nhập thành công tài khoản Quản trị viên (Admin) | Positive | `email`: `"admin@cosmetic.com"`, `password`: `"admin123"` | Cấp role `ADMIN`, session `currentUser`, chuyển hướng sang `/admin/dashboard` |
| **TC_AUTH_LOG_03** | UI / Controller | Boundary (Trim) | Đăng nhập thành công khi email/mật khẩu có khoảng trắng đầu/cuối | Positive | `email`: `"  customer@gmail.com  "`, `password`: `"  123456  "` | Hệ thống tự trim khoảng trắng, đăng nhập thành công và chuyển hướng `/home` |
| **TC_AUTH_LOG_04** | UI / Controller | Equivalence (Invalid) | Đăng nhập thất bại do sai mật khẩu | Negative | `email`: `"customer@gmail.com"`, `password`: `"wrongpass"` | Giữ lại `oldEmail`, hiển thị thông báo lỗi: `"Sai email hoặc mật khẩu không đúng"` |
| **TC_AUTH_LOG_05** | UI / Controller | Equivalence (Invalid) | Đăng nhập thất bại do email chưa đăng ký trong hệ thống | Negative | `email`: `"notfound@gmail.com"`, `password`: `"123456"` | Hiển thị thông báo lỗi: `"Sai email hoặc mật khẩu không đúng"` |
| **TC_AUTH_LOG_06** | UI / Controller | Boundary (Empty) | Đăng nhập thất bại khi để trống cả email và mật khẩu | Negative | `email`: `""`, `password`: `""` | Báo lỗi `"Sai email hoặc mật khẩu không đúng"`, không chuyển hướng |
| **TC_AUTH_LOG_07** | UI / Controller | Boundary (Empty) | Đăng nhập thất bại khi chỉ để trống mật khẩu | Negative | `email`: `"customer@gmail.com"`, `password`: `""` | Báo lỗi `"Sai email hoặc mật khẩu không đúng"`, giữ lại `oldEmail` |

---

## II. MODULE 2: ĐĂNG KÝ TÀI KHOẢN (AUTHENTICATION - REGISTER)

| Test Case ID | Tầng kiểm thử | Kỹ thuật áp dụng | Mô tả ca kiểm thử | Loại (Pos/Neg) | Dữ liệu đầu vào (Test Data) | Kết quả mong đợi |
| :---: | :---: | :---: | :--- | :---: | :--- | :--- |
| **TC_AUTH_REG_01** | UI / Controller | Equivalence (Valid) | Đăng ký tài khoản khách hàng mới thành công | Positive | `name`: `"Nguyen Van A"`, `email`: `"newuser_valid@gmail.com"`, `phone`: `"0987654321"`, `password`: `"Pass@123"` | Lưu thành công vào DB với Address `"Chưa cập nhật"`, chuyển hướng sang `/login` |
| **TC_AUTH_REG_02** | UI / Controller | Equivalence (Invalid) | Đăng ký thất bại khi email đã tồn tại trong CSDL | Negative | `name`: `"Nguyen Van B"`, `email`: `"customer@gmail.com"` (đã tồn tại), `phone`: `"0912345678"`, `password`: `"Pass@123"` | Báo lỗi `"Email này đã được sử dụng"`, không lưu DB, ở lại trang `/register` |
| **TC_AUTH_REG_03** | UI / Controller | Boundary (Empty) | Đăng ký thất bại khi để trống trường Họ và tên | Negative | `name`: `""`, `email`: `"test_empty_name@gmail.com"`, `phone`: `"0987111222"`, `password`: `"Pass@123"` | Báo lỗi validation bắt buộc nhập họ tên, không insert DB |
| **TC_AUTH_REG_04** | UI / Controller | Boundary (Empty) | Đăng ký thất bại khi để trống số điện thoại | Negative | `name`: `"Tran Thi C"`, `email`: `"test_empty_phone@gmail.com"`, `phone`: `""`, `password`: `"Pass@123"` | Báo lỗi validation bắt buộc nhập số điện thoại |
| **TC_AUTH_REG_05** | UI / Controller | Equivalence (Invalid) | Đăng ký thất bại khi định dạng email không hợp lệ | Negative | `name`: `"Le Van D"`, `email`: `"invalid-email-format"`, `phone`: `"0933333333"`, `password`: `"Pass@123"` | Báo lỗi email không hợp lệ |

---

## III. MODULE 3: QUẢN LÝ SẢN PHẨM ADMIN (PRODUCT CRUD)

| Test Case ID | Tầng kiểm thử | Kỹ thuật áp dụng | Mô tả ca kiểm thử | Loại (Pos/Neg) | Dữ liệu đầu vào (Test Data) | Kết quả mong đợi |
| :---: | :---: | :---: | :--- | :---: | :--- | :--- |
| **TC_PROD_ADD_01** | UI / Controller | Equivalence (Valid) | Thêm mới sản phẩm hợp lệ đầy đủ các trường | Positive | `name`: `"Son dưỡng môi Dior"`, `price`: `"850000"`, `discountPrice`: `"790000"`, `stock`: `"50"`, `category`: `"1"` | Gọi `create(p)` thành công, chuyển hướng về `/admin/product` |
| **TC_PROD_ADD_02** | UI / Controller | Boundary (Valid Min) | Thêm sản phẩm với giá tối thiểu biên dương (`price = 1000`) | Positive | `name`: `"Mặt nạ giấy mini"`, `price`: `"1000"`, `discountPrice`: `""`, `stock`: `"10"`, `category`: `"1"` | Tạo sản phẩm thành công |
| **TC_PROD_ADD_03** | UI / Controller | Boundary (Valid Min) | Thêm sản phẩm với số lượng tồn kho bằng 0 (Biên hợp lệ `stock = 0`) | Positive | `name`: `"Kem chống nắng hết hàng"`, `price`: `"250000"`, `discountPrice`: `""`, `stock`: `"0"`, `category`: `"2"` | Tạo sản phẩm thành công, số lượng kho lưu 0 |
| **TC_PROD_ADD_04** | Controller / Unit | Boundary (Empty/Space) | Thêm sản phẩm thất bại do tên sản phẩm chỉ chứa khoảng trắng | Negative | `name`: `"   "`, `price`: `"100000"`, `stock`: `"5"`, `category`: `"1"` | Ném ngoại lệ / báo lỗi: `"Tên sản phẩm không được để trống."` |
| **TC_PROD_ADD_05** | Controller / Unit | Boundary (BVA 0) | Thêm sản phẩm thất bại khi giá bán bằng 0 (`price = 0`) | Negative | `name`: `"Sữa rửa mặt Cetaphil"`, `price`: `"0"`, `stock`: `"20"`, `category`: `"1"` | Báo lỗi ngoại lệ: `"Giá phải lớn hơn 0."` |
| **TC_PROD_ADD_06** | Controller / Unit | Boundary (BVA Negative) | Thêm sản phẩm thất bại khi giá bán số âm (`price = -50000`) | Negative | `name`: `"Serum Trị Mụn"`, `price`: `"-50000"`, `stock`: `"20"`, `category`: `"1"` | Báo lỗi ngoại lệ: `"Giá phải lớn hơn 0."` |
| **TC_PROD_ADD_07** | Controller / Unit | Equivalence (Invalid) | Thêm sản phẩm thất bại khi giá bán không phải dạng số (`price = "abc"`) | Negative | `name`: `"Kem dưỡng ẩm Nivea"`, `price`: `"abc"`, `stock`: `"10"`, `category`: `"1"` | Bắt `NumberFormatException`, thông báo định dạng giá không hợp lệ |
| **TC_PROD_ADD_08** | Controller / Unit | Boundary (BVA Negative) | Thêm sản phẩm thất bại khi số lượng âm (`stock = -1`) | Negative | `name`: `"Toner hoa cúc"`, `price`: `"350000"`, `stock`: `"-1"`, `category`: `"2"` | Báo lỗi ngoại lệ: `"Số lượng không được âm."` |
| **TC_PROD_ADD_09** | Controller / Unit | Equivalence (Invalid) | Thêm sản phẩm thất bại do không chọn loại danh mục | Negative | `name`: `"Nước tẩy trang Bioderma"`, `price`: `"300000"`, `stock`: `"15"`, `category`: `""` | Báo lỗi ngoại lệ: `"Vui lòng chọn loại sản phẩm."` |
| **TC_PROD_EDIT_01** | UI / Controller | Equivalence (Valid) | Cập nhật thông tin sản phẩm thành công theo ID | Positive | `id`: `"1"`, `name`: `"Son dưỡng môi Dior Rose"`, `price`: `"900000"`, `stock`: `"40"`, `category`: `"1"` | Gọi `update(p)`, cập nhật thông tin trong DB, redirect `/admin/product` |
| **TC_PROD_EDIT_02** | Controller / Unit | Boundary (Invalid) | Cập nhật sản phẩm thất bại khi đổi giá về 0 hoặc số âm | Negative | `id`: `"1"`, `name`: `"Son dưỡng Dior"`, `price`: `"-100"`, `stock`: `"40"`, `category`: `"1"` | Báo lỗi ngoại lệ `"Giá phải lớn hơn 0."`, không lưu DB |
| **TC_PROD_DEL_01** | UI / Controller | Equivalence (Valid) | Xóa sản phẩm thành công với ID hợp lệ | Positive | `action = "delete"`, `id = "5"` (tồn tại) | Xóa bản ghi trong DB, load lại danh sách không còn sản phẩm ID 5 |
