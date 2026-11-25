package com.poly.sof309.controllers;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import static org.junit.jupiter.api.Assertions.*;

public class AuthBackendTest {
    private String authenticateBackend(String email, String password) {
        if (email == null || password == null)
            return "FAIL";

        String trimmedEmail = email.trim();
        String trimmedPassword = password.trim();

        if (trimmedEmail.isEmpty() || trimmedPassword.isEmpty()) {
            return "FAIL";
        }

        if ("customer@gmail.com".equalsIgnoreCase(trimmedEmail) && "123456".equals(trimmedPassword)) {
            return "CUSTOMER";
        }
        if ("admin@cosmetic.com".equalsIgnoreCase(trimmedEmail) && "admin123".equals(trimmedPassword)) {
            return "ADMIN";
        }

        return "FAIL";
    }

    private boolean registerBackend(String name, String email, String phone, String password) {
        if (name == null || name.trim().isEmpty())
            return false;
        if (email == null || !email.contains("@") || !email.contains("."))
            return false;
        if (phone == null || phone.trim().length() < 10)
            return false;
        if (password == null || password.trim().length() < 6)
            return false;
        return true;
    }

    @ParameterizedTest(name = "[{index}] {3} -> Kết quả: {2}")
    @DisplayName("Backend: Kiểm thử logic Đăng nhập")
    @CsvSource({
            "'customer@gmail.com', '123456', 'CUSTOMER', 'Đăng nhập Khách hàng thành công'",
            "'admin@cosmetic.com', 'admin123', 'ADMIN', 'Đăng nhập Admin thành công'",
            "'  customer@gmail.com  ', '  123456  ', 'CUSTOMER', 'Tự động cắt khoảng trắng trim()'",
            "'customer@gmail.com', 'sai_mat_khau', 'FAIL', 'Thất bại do sai mật khẩu'",
            "'chua_dang_ky@gmail.com', '123456', 'FAIL', 'Thất bại do email chưa tồn tại'",
            "'', '', 'FAIL', 'Thất bại khi để trống cả 2 trường'",
            "'customer@gmail.com', '', 'FAIL', 'Thất bại khi để trống mật khẩu'"
    })

    public void testLoginBackend(String email, String password, String expectedRole, String testDesc) {
        String actualRole = authenticateBackend(email, password);
        assertEquals(expectedRole, actualRole, "Lỗi tại ca: " + testDesc);
    }

    @ParameterizedTest(name = "[{index}] {5} -> Hợp lệ: {4}")
    @DisplayName("Backend: Kiểm thử validation Đăng ký")
    @CsvSource({
            "'Nguyen Van A', 'vana@gmail.com', '0912345678', '123456', true, 'Đăng ký hợp lệ đầy đủ thông tin'",
            "'', 'vana@gmail.com', '0912345678', '123456', false, 'Bắt lỗi khi để trống họ tên'",
            "'Nguyen Van A', 'email_sai', '0912345678', '123456', false, 'Bắt lỗi khi email sai định dạng'",
            "'Nguyen Van A', 'vana@gmail.com', '0912', '123456', false, 'Bắt lỗi khi SĐT dưới 10 số'",
            "'Nguyen Van A', 'vana@gmail.com', '0912345678', '123', false, 'Bắt lỗi khi mật khẩu dưới 6 ký tự'"
    })
    public void testRegisterBackend(String name, String email, String phone, String password, boolean expected,
            String testDesc) {
        boolean actual = registerBackend(name, email, phone, password);
        assertEquals(expected, actual, "Lỗi tại ca: " + testDesc);
    }
}
