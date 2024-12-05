package vn.io.ductandev.refeshtoken.service;

import org.springframework.security.core.Authentication;
import vn.io.ductandev.refeshtoken.dto.LoginDTO;
import vn.io.ductandev.refeshtoken.dto.RefreshTokenDTO;
import vn.io.ductandev.refeshtoken.request.AuthenRequest;
import vn.io.ductandev.refeshtoken.request.RefeshTokenRequest;

public interface AuthenService {
    boolean checkLogin(Authentication authentication);
    LoginDTO login(AuthenRequest authenRequest);
    RefreshTokenDTO newAccessToken(RefeshTokenRequest refeshTokenRequest);
}
