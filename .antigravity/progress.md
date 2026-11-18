# Project Progress - SOF309 Assignment

## Thông tin Dự án
- **Sinh viên:** Hà Kim Biên (MSSV: TS02569)
- **Lớp:** SD21304
- **Dự án:** Website Bán Mỹ Phẩm (Cosmetic Store)

---

## Tổng quan Lộ trình 6 Tuần (Theo HUONG_DAN_CHI_TIET_6_TUAN.md)

- [x] **Y1 (Tuần 1): Tích hợp Web cũ vào repo cá nhân**
  - [x] Tích hợp mã nguồn Java Servlet / JSP vào `src/main/`
  - [x] Cấu hình `pom.xml` bổ sung JUnit 5, Selenium, TestNG
  - [x] Khởi chạy ứng dụng local kiểm tra chức năng Đăng nhập, Đăng ký, CRUD Sản phẩm

- [x] **Y2 (Tuần 1): Đặc tả nghiệp vụ & Thiết kế kịch bản kiểm thử (AI RAG)**
  - [x] Cập nhật `docs/SPECIFICATIONS.md` (Đặc tả Đăng nhập, Đăng ký, Quản lý sản phẩm)
  - [x] Cập nhật `docs/TEST_PLAN.md` (Kế hoạch kiểm thử JUnit 5, Selenium POM, CI/CD)
  - [x] Cập nhật `docs/TEST_CASES.md` (Ma trận kiểm thử EP & BVA 21 kịch bản)
  - [x] Tạo file nhật ký minh chứng AI `docs/ai-logs/01_test_design_ai.md` (Y6 Điểm A)

- [ ] **Y3 (Tuần 2): Viết Unit Test Controller với JUnit 5 nâng cao**
  - [ ] Parameterized Test (`@ParameterizedTest`, `@CsvSource`) kiểm tra validation form biên
  - [ ] Exception Testing (`assertThrows`) bắt lỗi nghiệp vụ trùng lặp dữ liệu
  - [ ] Timeout Testing (`@Timeout`)
  - [ ] Tạo file nhật ký minh chứng AI `docs/ai-logs/02_junit_script_ai.md`

- [ ] **Y4 (Tuần 3 & 4): Xây dựng khung kiểm thử tự động UI (Selenium POM + TestNG)**
  - [ ] Tuần 3: Phân tách Page Object Model (pages/ và tests/), viết LoginPage, RegisterPage, ProductPage
  - [ ] Tuần 4: Data-Driven `@DataProvider`, Groups (`@Test(groups = "smoke")`), ITestListener chụp ảnh lỗi `screenshots/`
  - [ ] Tạo file nhật ký minh chứng AI `docs/ai-logs/03_selenium_pom_ai.md`

- [ ] **Y5 (Tuần 5): CI/CD GitHub Actions & Báo cáo tự động**
  - [ ] Cấu hình `.github/workflows/test.yml` chạy Headless Chrome trên Ubuntu
  - [ ] Upload artifacts báo cáo test và screenshot
  - [ ] Tạo file nhật ký minh chứng AI `docs/ai-logs/05_github_actions_ai.md`

- [ ] **Y6 (Tuần 6): Hoàn thiện hồ sơ minh chứng AI & Slide bảo vệ**
  - [ ] AI Code Review, refactor code test
  - [ ] Hoàn thiện 6 file nhật ký minh chứng `docs/ai-logs/`
  - [ ] Tạo file nhật ký minh chứng AI `docs/ai-logs/06_code_review_ai.md`
  - [ ] Đóng gói và làm Slide bảo vệ

