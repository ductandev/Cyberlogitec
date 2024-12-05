package vn.io.ductandev.refeshtoken.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class RefeshTokenRequest {
    @NotBlank(message = "RefeshToken không được để trống !!!")
    private String refreshToken;
}
