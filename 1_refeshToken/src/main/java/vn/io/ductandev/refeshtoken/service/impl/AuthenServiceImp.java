package vn.io.ductandev.refeshtoken.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import vn.io.ductandev.refeshtoken.dto.LoginDTO;
import vn.io.ductandev.refeshtoken.dto.RefreshTokenDTO;
import vn.io.ductandev.refeshtoken.dto.RoleDTO;
import vn.io.ductandev.refeshtoken.dto.UserDTO;
import vn.io.ductandev.refeshtoken.entity.RefreshTokenEntity;
import vn.io.ductandev.refeshtoken.entity.UserEntity;
import vn.io.ductandev.refeshtoken.exception.AuthenException;
import vn.io.ductandev.refeshtoken.repository.RefreshTokenRepository;
import vn.io.ductandev.refeshtoken.repository.UserRepository;
import vn.io.ductandev.refeshtoken.request.AuthenRequest;
import vn.io.ductandev.refeshtoken.request.RefeshTokenRequest;
import vn.io.ductandev.refeshtoken.service.AuthenService;
import vn.io.ductandev.refeshtoken.utils.JwtHelper;


@Service
@RequiredArgsConstructor
public class AuthenServiceImp implements AuthenService {
    @Autowired
    @Lazy
    private AuthenticationManager authenticationManager;
    private final JwtHelper jwtHelper;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final RefreshTokenRepository refreshTokenRepository;



    @Override
    public boolean checkLogin(Authentication authentication) {
        UserEntity user = userRepository.findUserEntityByEmail(authentication.getName())
                .orElseThrow(() -> new AuthenException("Email không tồn tại hoặc chưa đăng ký !!!"));

        if (user != null && passwordEncoder.matches(authentication.getCredentials().toString(), user.getPassword())) {
            return true;
        }

        throw new AuthenException("Mật khẩu không đúng !!!");
    }

    @Override
    public LoginDTO login(AuthenRequest authenRequest) {
        UsernamePasswordAuthenticationToken authenToken = new UsernamePasswordAuthenticationToken(authenRequest.email(), authenRequest.password());
        Authentication authentication = authenticationManager.authenticate(authenToken);

        if (authentication.isAuthenticated()) {
            UserEntity user = userRepository.findUserEntityByEmail(authentication.getName()).get(); // Đã kiểm tra ở trên

            LoginDTO dto = new LoginDTO();
            dto.setUser(toDTO(user));

            dto.setAccessToken(jwtHelper.generateAccessToken(user));         // ⭐ generateToken: TẠO RA TOKEN CHỈ VỚI USER DETAIL
            dto.setRefreshToken(jwtHelper.generateRefreshToken(user));

            // Lưu lại RefreshToken
            RefreshTokenEntity refreshToken = new RefreshTokenEntity();
            refreshToken.setRefreshToken(dto.getRefreshToken());
            refreshTokenRepository.save(refreshToken);

            return dto;
        }
        return null;
    }


    public UserDTO toDTO(UserEntity userEntity) {
        if (userEntity == null) {
            return null;
        }

        UserDTO userDTO = new UserDTO();

        userDTO.setId(userEntity.getId());
        userDTO.setIsDeleted(userEntity.getIsDeleted());
        userDTO.setEmail(userEntity.getEmail());
        userDTO.setFullName(userEntity.getFullName());
        userDTO.setRole(new RoleDTO(userEntity.getRole().getName()));

        return userDTO;
    }

    @Override
    public RefreshTokenDTO newAccessToken(RefeshTokenRequest refeshTokenRequest) {
        RefreshTokenEntity rs = validateRefreshToken(refeshTokenRequest.getRefreshToken());
        RefreshTokenDTO dto = new RefreshTokenDTO();

        UserEntity user = userRepository.findUserEntityById(
                Integer.valueOf(jwtHelper.extractUsername(rs.getRefreshToken()))).get(); // Đã kiểm tra ở trên
        // Generate AccessToken
        dto.setAccessToken(jwtHelper.generateAccessToken(user));

        return dto;
    }


    private RefreshTokenEntity validateRefreshToken(String token) {
        RefreshTokenEntity rs = refreshTokenRepository.findByRefreshToken(token)
                .orElseThrow(() -> new RuntimeException("Token not found !"));

        if (jwtHelper.isTokenExpired(token)) {
            refreshTokenRepository.delete(rs);
            throw new RuntimeException("Refresh-Token đã hết hạn !!!");
        }

        return rs;
    }
}
