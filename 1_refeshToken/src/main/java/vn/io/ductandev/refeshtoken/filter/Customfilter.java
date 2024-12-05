package vn.io.ductandev.refeshtoken.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import vn.io.ductandev.refeshtoken.utils.JwtHelper;

import java.io.IOException;
import java.util.ArrayList;

@Component
@RequiredArgsConstructor
public class Customfilter extends OncePerRequestFilter {

    private final JwtHelper jwtHelper;


    // ============================================================
    //           HÀM KIỂM TRA TOKEN TRÊN HEADER
    // ============================================================
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String authorHeader = request.getHeader("Authorization");
        if(authorHeader != null && authorHeader.startsWith("Bearer ")){
            String token = authorHeader.substring(7);
            String data = jwtHelper.decodeToken(token);
            if (!jwtHelper.isTokenExpired(token)){
                if(data != null){

                    // Tạo chứng thực
                    UsernamePasswordAuthenticationToken authenToken =
                            new UsernamePasswordAuthenticationToken("", "", new ArrayList<>());

                    // Tạo giấy thông hành
                    SecurityContext context = SecurityContextHolder.getContext();
                    context.setAuthentication(authenToken);
                }
            }
        }

        // ✅ Cho phép filter tiếp theo chạy tiếp
        filterChain.doFilter(request,response);
    }
}
