package vn.io.ductandev.Bucket4j.config;

import io.github.bucket4j.Bucket;
import io.github.bucket4j.ConsumptionProbe;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class RateLimitingFilter implements Filter {

    private final Bucket bucket;                // Lấy Bucket từ IOC xuống sử dụng

    @Autowired
    public RateLimitingFilter(Bucket bucket) {
        this.bucket = bucket;
    }

    /**
     * Intercepts incoming requests and applies rate limiting.
     * If a token is available, the request is processed; otherwise, a 429 status code is returned.
     */

    // =========================================================================================
    /*  Lớp này RateLimitingFilterlà một bộ lọc servlet chặn các yêu cầu đến.
        Nó kiểm tra xem có mã thông báo nào khả dụng trong thùng không;
        nếu có, yêu cầu sẽ được xử lý, nếu không, nó sẽ trả về mã 429 Too Many Requeststrạng thái.
        Bộ lọc này thực thi các quy tắc giới hạn tốc độ được xác định trong RateLimitConfiglớp. */
    // =========================================================================================
//    @Override
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
//            throws IOException, ServletException {
//
//        // Để theo dõi chính xác số token còn lại và hành vi tiêu thụ, bạn nên sử dụng ConsumptionProbe
//        if (bucket.tryConsume(1)) {
//            // Forward request nếu còn token
//            chain.doFilter(request, response);               // ⭐ Forward the request if rate limiting is not hit
//        } else {
//            ((HttpServletResponse) response).setStatus(429); // ⭐ Return 429 if rate limit is exceeded
//        }
//    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // Sử dụng ConsumptionProbe để kiểm tra trạng thái bucket
        ConsumptionProbe probe = bucket.tryConsumeAndReturnRemaining(1);

        if (probe.isConsumed()) {
            // Nếu token được tiêu thụ thành công, ghi log và tiếp tục xử lý request
            long remainingTokens = probe.getRemainingTokens();
            System.out.println("Time: " + System.currentTimeMillis() + ", Remaining tokens: " + remainingTokens);

            // Forward request nếu còn token
            chain.doFilter(request, response);
        } else {
            // Nếu hết token, trả về HTTP 429
            long remainingTokens = probe.getRemainingTokens();
            System.out.println("Time: " + System.currentTimeMillis() + ", Request rejected. Tokens remaining: " + remainingTokens);

            HttpServletResponse httpServletResponse = (HttpServletResponse) response;
            httpServletResponse.setStatus(429);
            httpServletResponse.getWriter().write("Too Many Requests");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}
