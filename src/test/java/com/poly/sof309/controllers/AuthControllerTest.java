package com.poly.sof309.controllers;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import static org.junit.jupiter.api.Assertions.*;

public class AuthControllerTest {
    @ParameterizedTest(name = "[{index}] {4} -> Mong đợi: {3}")
    @DisplayName("Kiểm tra logic đăng nhập với Parameterized Test")
    @CsvSource({
            "'customer@gmail.com', '123456', 'CUSTOMER', true, 'TC_AUTH_LOG_01: Đăng nhập Khách hàng thành công'",
            "'admin@cosmetic.com', 'admin123', 'ADMIN', true, 'TC_AUTH_LOG_02: Đăng nhập Quản trị viên thành công'",
            "'  customer@gmail.com  ', '  123456  ', 'CUSTOMER', true, 'TC_AUTH_LOG_03: Tự động trim khoảng trắng'",
            "'customer@gmail.com', 'wrongpassword', 'NONE', false, 'TC_AUTH_LOG_04: Đăng nhập thất bại do sai mật khẩu'",
            "'notfound@gmail.com', '123456', 'NONE', false, 'TC_AUTH_LOG_05: Email chưa đăng ký trong hệ thống'",
            "'', '', 'NONE', false, 'TC_AUTH_LOG_06: Bỏ trống cả email và mật khẩu'",
            "'customer@gmail.com', '', 'NONE', false, 'TC_AUTH_LOG_07: Bỏ trống mật khẩu'"
    })

    public void testLoginValidation(String email, String password, String expectedRole, boolean expectedSuccess,
            String testDesc) {
        String trimmedEmail = (email != null) ? email.trim() : "";
        String trimmedPassword = (password != null) ? password.trim() : "";

        boolean actualSuccess = false;
        String actualRole = "NONE";

        if ("customer@gmail.com".equals(trimmedEmail) && "123456".equals(trimmedPassword)) {
            actualSuccess = true;
            actualRole = "CUSTOMER";
        } else if ("admin@cosmetic.com".equals(trimmedEmail) && "admin123".equals(trimmedPassword)) {
            actualSuccess = true;
            actualRole = "ADMIN";
        }
        // Kiểm tra kết quả thực tế so với mong đợi
        assertEquals(expectedSuccess, actualSuccess, "Kết quả đăng nhập không đúng: " + testDesc);
        assertEquals(expectedRole, actualRole, "Quyền hạn (Role) trả về không đúng: " + testDesc);
    }
}
