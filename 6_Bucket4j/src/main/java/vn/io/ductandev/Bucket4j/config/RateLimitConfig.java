package vn.io.ductandev.Bucket4j.config;

import io.github.bucket4j.Bucket;
import io.github.bucket4j.Bucket4j;
import io.github.bucket4j.Bandwidth;
import io.github.bucket4j.Refill;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.Duration;

@Configuration
public class RateLimitConfig {
    /**
     * Configures a Bucket4j bucket with a capacity of 5 tokens that refills at a rate of 5 tokens per minute.
     * Each token represents the capacity to handle one request.
     */
    // ======================================================================
    /* Lớp này RateLimitConfigđịnh nghĩa cấu hình giới hạn tốc độ bằng Bucket4j.
    Nó tạo ra một bucket có sức chứa năm token, được nạp lại với tốc độ năm token mỗi phút.
    Cấu hình này sẽ được sử dụng để giới hạn số lượng yêu cầu API cho mỗi người dùng.*/
    // ======================================================================
//    @Bean                       // Đưa lên IOC
//    public Bucket bucket() {
//        // Define the bandwidth with a limit of 5 tokens, refilled every 1 minute
//        Bandwidth limit = Bandwidth.classic(5, Refill.greedy(5, Duration.ofSeconds(10)));
//
//        return Bucket4j.builder().addLimit(limit).build();
//    }

    @Bean
    public Bucket bucket() {
        Bandwidth limit = Bandwidth.classic(5, Refill.greedy(5, Duration.ofSeconds(10)));
        return Bucket4j.builder().addLimit(limit).build();
    }

}


