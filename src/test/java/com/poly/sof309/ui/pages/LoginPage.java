package com.poly.sof309.ui.pages;

import java.time.Duration;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

/**
 * =========================================================================
 * [Y4] MẪU PAGE OBJECT MODEL (POM) CHO TRANG ĐĂNG NHẬP
 * Class này chỉ quản lý các phần tử (Locator) và hành động trên trang Web.
 * =========================================================================
 */
public class LoginPage {
    private WebDriver driver;
    private WebDriverWait wait;

    // 1. Định nghĩa các Locator trên trang đăng nhập của web cá nhân
    private By txtEmail = By.name("email");
    private By txtPassword = By.name("password");
    private By btnLogin = By.xpath("//button[@type='submit']");
    private By lblErrorMessage = By.className("error-message");

    public LoginPage(WebDriver driver) {
        this.driver = driver;
        this.wait = new WebDriverWait(driver, Duration.ofSeconds(10));
    }

    // 2. Các hành động nghiệp vụ
    public void enterEmail(String email) {
        WebElement emailInput = wait.until(ExpectedConditions.visibilityOfElementLocated(txtEmail));
        emailInput.clear();
        emailInput.sendKeys(email);
    }

    public void enterPassword(String password) {
        WebElement passInput = wait.until(ExpectedConditions.visibilityOfElementLocated(txtPassword));
        passInput.clear();
        passInput.sendKeys(password);
    }

    public void clickLogin() {
        wait.until(ExpectedConditions.elementToBeClickable(btnLogin)).click();
    }

    public void login(String email, String password) {
        enterEmail(email);
        enterPassword(password);
        clickLogin();
    }

    public String getErrorMessage() {
        return wait.until(ExpectedConditions.visibilityOfElementLocated(lblErrorMessage)).getText();
    }
}
