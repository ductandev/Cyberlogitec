package vn.io.ductandev.refeshtoken.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity(name = "refresh_token")
public class RefreshTokenEntity extends BaseEntity {
    private String refreshToken;
}

