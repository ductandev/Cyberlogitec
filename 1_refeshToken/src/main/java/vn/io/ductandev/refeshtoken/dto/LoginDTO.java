package vn.io.ductandev.refeshtoken.dto;

import lombok.Data;

@Data
public class LoginDTO {
    private UserDTO user;
    private String accessToken;
    private String refreshToken;
}
