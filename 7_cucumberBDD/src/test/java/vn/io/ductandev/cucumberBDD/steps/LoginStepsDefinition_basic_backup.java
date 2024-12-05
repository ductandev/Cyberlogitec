/*
package vn.io.ductandev.cucumberBDD.steps;

import io.cucumber.java.Before;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.Objects;

public class LoginStepsDefinition_basic_backup {

    private static final String LOGIN_URL = "http://203.205.26.244:4000/login";
    private static final String HOMEPAGE_URL_FRAGMENT = "/home";
    private static final String EMAIL = "nguyenductan998@gmail.com";
    private static final String PASSWORD = "Ductan123@";
    private static final Duration TIMEOUT = Duration.ofSeconds(10);

    private WebDriver driver;

    @Before
    public void setUp() {
        WebDriverManager.chromedriver().setup();    // Sử dụng WebDriverManager để tự động tải và cấu hình driver
        driver = new ChromeDriver();
        driver.manage().window().maximize();        //đảm bảo giao diện hiển thị đầy đủ
    }

    @Given("the user is on the login page")
    public void userIsOnLoginPage() {
        // Mở URL
        driver.get("http://203.205.26.244:4000/login");

        // Kiểm tra xem URL có chính xác không
        if (!Objects.equals(driver.getCurrentUrl(), "http://203.205.26.244:4000/login")) {
            throw new RuntimeException("Không thể mở trang Login đúng URL");
        }
    }

    @When("the user enters valid credentials")
    public void userEntersValidCredentials() {
        // Tìm và nhập thông tin đăng nhập
        driver.findElement(By.name("email")).sendKeys("nguyenductan998@gmail.com");     // Thay thẻ name phù hợp
        driver.findElement(By.name("password")).sendKeys("Ductan123@");                 // Thay thẻ name phù hợp
    }

    @And("clicks the {string} button")
    public void clicks_the_button(String buttonName) {
        try {
            // Sử dụng XPath để tìm nút dựa trên tên
            driver.findElement(By.xpath(String.format("//button[contains(text(),'%s')]", buttonName))).click();
            //driver.findElement(By.xpath("//button[contains(text(),'로그인')]")).click(); // Thay id phù hợp
        } catch (NoSuchElementException e) {
            throw new RuntimeException("Nút không tìm thấy: " + buttonName);
        }

    }

    @Then("the user should be redirected to the home page")
    public void userShouldBeRedirectedToHome() {
        // Chờ đến khi URL chuyển hướng
        new WebDriverWait(driver, Duration.ofSeconds(10))
                .until(ExpectedConditions.urlContains("/home"));

        // Kiểm tra chuyển hướng đúng tới Home
        if (!Objects.requireNonNull(driver.getCurrentUrl()).contains("/home")) {
            throw new RuntimeException("Không chuyển hướng đúng tới Home");
        }

        // Kiểm tra một element cụ thể trên Home
//        boolean isHomeLoaded = driver.findElement(By.xpath("//a[contains(text(),'홈')]")).isDisplayed();// Thay id phù hợp
//        if (!isHomeLoaded) {
//            throw new RuntimeException("Trang Home không tải thành công");
//        }

        // Sử dụng WebDriverWait thay vì kiểm tra trực tiếp để tránh lỗi xảy ra khi DOM chưa sẵn sàng:
        new WebDriverWait(driver, Duration.ofSeconds(10))
                .until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//a[contains(text(),'홈')]")));

    }

    @And("see a welcome message")
    public void seeAWelcomeMessage() {
        // Kiểm tra tin nhắn chào mừng hiển thị
        boolean isWelcomeMessageDisplayed = new WebDriverWait(driver, Duration.ofSeconds(10))
                .until(ExpectedConditions.textToBePresentInElementLocated(
                        By.xpath("//div[@class='welcome-message']"),
                        "Chào mừng bạn!"));

        if (!isWelcomeMessageDisplayed) {
            throw new RuntimeException("Tin nhắn chào mừng không hiển thị đúng");
        }
    }

    // Đóng driver sau khi test xong
    @io.cucumber.java.After
    public void tearDown() {
        if (driver != null) {
            driver.quit(); // Đóng trình duyệt
        }
    }

}


*/
