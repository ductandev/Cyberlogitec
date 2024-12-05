package vn.io.ductandev.refeshtoken.security;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Component;
import vn.io.ductandev.refeshtoken.exception.AuthenException;
import vn.io.ductandev.refeshtoken.service.AuthenService;

import java.util.ArrayList;

@Component
@RequiredArgsConstructor
public class CustomAuthenProvider implements AuthenticationProvider {

    private final AuthenService authenService;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        if(authenService.checkLogin(authentication)){
            // Tạo giấy thông hành
            return new UsernamePasswordAuthenticationToken(authentication.getName(),authentication.getCredentials(), new ArrayList<>());
        } else {
            throw new AuthenException("Đăng nhập thất bại! Username hoặc password không đúng.");
        }
    }


    // supports: Đây là phương thức khai báo loại chứng thực cho Security sử dụng khi muốn so sánh.
    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals((UsernamePasswordAuthenticationToken.class));
    }
}
