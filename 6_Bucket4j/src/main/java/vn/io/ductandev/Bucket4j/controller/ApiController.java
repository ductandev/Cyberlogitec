package vn.io.ductandev.Bucket4j.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class ApiController {

    /**
     * Handles GET requests to "/api/data".
     * This endpoint will be rate-limited by the Bucket4j filter.
     * @return A simple string response indicating successful access.
     */
    // =====================================================================
    /*  Lớp này ApiController định nghĩa một bộ điều khiển REST với điểm cuối tại /api/data.
        Điểm cuối này trả về một thông báo chuỗi đơn giản khi được truy cập.
        Bộ lọc giới hạn tốc độ sẽ áp dụng cho điểm cuối này, kiểm soát tần suất có thể truy cập. */
    // =====================================================================

    @GetMapping("/data")
    public String getData() {
        return "Here is the protected data!";
    }
}
