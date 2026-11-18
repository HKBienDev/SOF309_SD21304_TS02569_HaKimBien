---
name: sof309-assignment
description: Cẩm nang hướng dẫn thực hiện trọn vẹn 6 tuần Assignment môn SOF309 (Kiểm thử nâng cao cùng AI) từ Y1 đến Y6.
---

# Kỹ Năng Thực Hiện Assignment SOF309 - Kiểm Thử Nâng Cao Cùng AI

Kỹ năng này cung cấp hướng dẫn chi tiết, các tiêu chí nghiệm thu và mẫu code kiểm thử chuẩn cho từng tuần thực hiện môn học SOF309.

## Lộ Trình 6 Tuần Tổng Quan

```
Tuần 1 (Y1 & Y2): Khởi tạo repo, tích hợp web cũ & thiết kế Test Plan / Test Cases bằng AI RAG
Tuần 2 (Y3): Viết Unit Test Controller với JUnit 5 nâng cao (@ParameterizedTest, assertThrows, @Timeout)
Tuần 3 (Y4 - P1): Khung Selenium POM cơ bản (pages/ và tests/, WebDriverWait)
Tuần 4 (Y4 - P2): Nâng cấp TestNG (groups, Data-Driven @DataProvider, ITestListener chụp ảnh lỗi)
Tuần 5 (Y5): CI/CD GitHub Actions trên Ubuntu Headless Chrome & upload artifacts
Tuần 6 (Y6): AI Code Review, hoàn thiện hồ sơ minh chứng điểm A & Slide bảo vệ
```

---

## Chi Tiết Kỹ Thuật Từng Giai Đoạn

### 1. Tuần 2: Unit Test Controller với JUnit 5 (Y3)
- **Vị trí code:** `src/test/java/.../controllers/`
- **Kỹ thuật bắt buộc:**
  - `@ParameterizedTest` kết hợp `@CsvSource` để quét các giá trị biên của form.
  - Exception Testing: `assertThrows(ExpectedException.class, () -> ...)` bắt lỗi trùng lặp dữ liệu hoặc vi phạm validation.
  - Timeout: `@Timeout(value = 2, unit = TimeUnit.SECONDS)` chống treo vòng lặp.
- **Tiêu chí nghiệm thu:** `mvn test` đạt 100% Pass (BUILD SUCCESS).
- **Minh chứng:** Ghi vào `docs/ai-logs/02_junit_script_ai.md`.

### 2. Tuần 3 & 4: Selenium Page Object Model & TestNG (Y4)
- **Kiến trúc:**
  - `pages/`: Chứa các class trang (ví dụ: `LoginPage.java`, `ProductPage.java`), đóng gói các By locator và method hành động.
  - `tests/`: Kịch bản kiểm thử kế thừa base test.
- **Quy tắc quan trọng:**
  - Dùng `WebDriverWait` và `ExpectedConditions`, tuyệt đối không dùng `Thread.sleep()`.
  - Tuần 4: Thêm `@Test(groups = "smoke")`, Data-Driven `@DataProvider`, và Listener chụp ảnh lỗi lưu vào thư mục `screenshots/`.
- **Minh chứng:** Ghi vào `docs/ai-logs/03_selenium_pom_ai.md`.

### 3. Tuần 5: GitHub Actions CI/CD (Y5)
- **File workflow:** `.github/workflows/test.yml`
- Chạy trên `ubuntu-latest`, kích hoạt Chrome headless `--headless=new`.
- Tự động đóng gói báo cáo surefire-reports và screenshots upload lên GitHub Artifacts.
- **Minh chứng:** Ghi vào `docs/ai-logs/05_github_actions_ai.md`.

### 4. Tuần 6: AI Code Review & Nghiệm Thu (Y6)
- Review chất lượng code kiểm thử và tối ưu hóa selector.
- Đảm bảo đủ các file log trong `docs/ai-logs/` theo mẫu 4 phần.
- Đóng gói file zip và chuẩn bị slide bảo vệ.

