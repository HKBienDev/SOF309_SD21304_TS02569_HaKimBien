
package com.poly.sof309.controllers;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Timeout;
import java.math.BigDecimal;
import java.util.concurrent.TimeUnit;
import static org.junit.jupiter.api.Assertions.*;

public class ProductServletTest {
    private void validateProduct(String productName, String priceStr, String stockStr, String cateStr)
            throws Exception {
        if (productName == null || productName.trim().isEmpty()) {
            throw new Exception("Tên sản phẩm không được để trống.");
        }

        if (priceStr == null || priceStr.trim().isEmpty()) {
            throw new Exception("Vui lòng nhập giá.");
        }

        BigDecimal price = new BigDecimal(priceStr);
        if (price.compareTo(BigDecimal.ZERO) <= 0) {
            throw new Exception("Giá phải lớn hơn 0.");
        }

        if (stockStr == null || stockStr.trim().isEmpty()) {
            throw new Exception("Vui lòng nhập số lượng.");
        }

        int stock = Integer.parseInt(stockStr);
        if (stock < 0) {
            throw new Exception("Số lượng không được âm.");
        }

        if (cateStr == null || cateStr.trim().isEmpty()) {
            throw new Exception("Vui lòng chọn danh mục.");
        }
    }

    @Test
    @DisplayName("TC_PROD_ADD_01: Thêm sản phẩm hợp lệ đầy đủ các trường")
    @Timeout(value = 1, unit = TimeUnit.SECONDS)
    public void testValidProduct() {
        assertDoesNotThrow(() -> {
            validateProduct("Son dưỡng môi Dior", "850000", "50", "1");
        }, "Sản phẩm hợp lệ không được ném ra ngoại lệ");
    }

    @Test
    @DisplayName("TC_PROD_ADD_03: Thêm sản phẩm với số lượng bằng 0 (Biên hợp lệ)")
    public void testProductWithZeroStock() {
        assertDoesNotThrow(() -> {
            validateProduct("Kem chống nắng hết hàng", "250000", "0", "2");
        }, "Số lượng bằng 0 là trường hợp hợp lệ (hết hàng), không được ném ngoại lệ");
    }

    @Test
    @DisplayName("TC_PROD_ADD_04: Bắt ngoại lệ khi tên sản phẩm chỉ có khoảng trắng")
    public void testBlankProductNameThrowsException() {
        Exception exception = assertThrows(Exception.class, () -> {
            validateProduct("   ", "100000", "5", "1");
        });
        assertEquals("Tên sản phẩm không được để trống.", exception.getMessage());
    }

    @Test
    @DisplayName("TC_PROD_ADD_05: Bắt ngoại lệ khi giá bán bằng 0")
    public void testZeroPriceThrowsException() {
        Exception exception = assertThrows(Exception.class, () -> {
            validateProduct("Sữa rửa mặt Cetaphil", "0", "20", "1");
        });
        assertEquals("Giá phải lớn hơn 0.", exception.getMessage());
    }

    @Test
    @DisplayName("TC_PROD_ADD_06: Bắt ngoại lệ khi giá bán là số âm")
    public void testNegativePriceThrowsException() {
        Exception exception = assertThrows(Exception.class, () -> {
            validateProduct("Serum Trị Mụn", "-50000", "20", "1");
        });
        assertEquals("Giá phải lớn hơn 0.", exception.getMessage());
    }

    @Test
    @DisplayName("TC_PROD_ADD_07: Bắt ngoại lệ NumberFormatException khi giá không phải số")
    public void testNonNumericPriceThrowsException() {
        assertThrows(NumberFormatException.class, () -> {
            validateProduct("Kem dưỡng ẩm", "abc", "10", "1");
        });
    }

    @Test
    @DisplayName("TC_PROD_ADD_08: Bắt ngoại lệ khi số lượng tồn kho âm")
    public void testNegativeStockThrowsException() {
        Exception exception = assertThrows(Exception.class, () -> {
            validateProduct("Toner hoa cúc", "350000", "-1", "2");
        });
        assertEquals("Số lượng không được âm.", exception.getMessage());
    }

    @Test
    @DisplayName("TC_PROD_ADD_09: Bắt ngoại lệ khi không chọn danh mục sản phẩm")
    public void testMissingCategoryThrowsException() {
        Exception exception = assertThrows(Exception.class, () -> {
            validateProduct("Nước tẩy trang", "300000", "15", "");
        });
        assertEquals("Vui lòng chọn danh mục.", exception.getMessage());
    }
}
