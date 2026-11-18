---
name: ai-log-recorder
description: Quy trình tự động ghi chép nhật ký minh chứng tương tác AI (AI Logs) vào thư mục docs/ai-logs/ theo thể thức 4 phần đạt điểm A môn SOF309.
---

# Kỹ Năng Ghi Nhật Ký Minh Chứng AI (AI-Log Recorder)

Kỹ năng này hướng dẫn quy chuẩn ghi chép và lưu vết các yêu cầu (prompt) và phản hồi từ AI vào thư mục `docs/ai-logs/` theo yêu cầu môn học SOF309 - Kiểm thử nâng cao cùng AI.

## 1. Cấu Trúc File Nhật Ký Theo Tuần

| Giai đoạn / Tuần | File nhật ký đích | Nội dung ghi nhận |
| :--- | :--- | :--- |
| Khởi tạo (Y1) | `docs/ai-logs/00_project_integration_ai.md` | Tích hợp mã nguồn web cũ, cấu hình pom.xml |
| Tuần 1 (Y2) | `docs/ai-logs/01_test_design_ai.md` | Sinh Test Plan và Ma trận Test Case EP/BVA |
| Tuần 2 (Y3) | `docs/ai-logs/02_junit_script_ai.md` | Sinh mã Unit Test Controller với JUnit 5 |
| Tuần 3 & 4 (Y4) | `docs/ai-logs/03_selenium_pom_ai.md` | Xây dựng Selenium Page Object Model & TestNG |
| Bất kỳ lúc nào | `docs/ai-logs/04_debug_logs_ai.md` | Xử lý lỗi, gỡ lỗi test fail hoặc build fail |
| Tuần 5 (Y5) | `docs/ai-logs/05_github_actions_ai.md` | Cấu hình CI/CD workflow GitHub Actions |
| Tuần 6 (Y6) | `docs/ai-logs/06_code_review_ai.md` | AI Code Review, tối ưu hóa kịch bản kiểm thử |

---

## 2. Thể Thức Ghi Chép 4 Phần Chuẩn Điểm A

Mỗi lượt ghi nhật ký phải tuân theo cấu trúc 4 phần rõ ràng:

```markdown
## Lần [X]: [Tên nghiệp vụ hoặc chức năng kiểm thử]

### 1. Ngữ cảnh & Mục tiêu
- **Mục tiêu:** Nêu rõ yêu cầu cần đạt (ví dụ: tạo 5 test case giá trị biên cho form đăng nhập).
- **Phạm vi:** Class/Method kiểm thử, URL màn hình liên quan.

### 2. Câu lệnh đã gửi cho AI (Prompt)
> Trích dẫn nguyên văn câu lệnh hoặc prompt mà người dùng đã gửi cho AI.

### 3. Kết quả do AI sinh ra (Raw Output)
- Đoạn mã Java/XML/Script hoặc kế hoạch do AI tạo ra.

### 4. Đánh giá & Chỉnh sửa của Sinh viên
- Xác nhận kiểm thử kết quả (Test Pass hay Fail).
- Điểm chỉnh sửa, bổ sung hoặc tối ưu hóa của sinh viên cùng lý do điều chỉnh.
```

---

## 3. Quy Tắc Loại Trừ

1. **Tuyệt đối không ghi:** Mọi trao đổi liên quan đến việc viết, chỉnh sửa tài liệu đặc tả nghiệp vụ `docs/SPECIFICATIONS.md`.
2. **Yêu cầu dừng:** Khi người dùng nói *"không cần ghi log prompt này"*, bỏ qua việc ghi chép.

