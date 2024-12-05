package vn.io.ductandev.refeshtoken.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public record AuthenRequest(
        @NotBlank(message = "Email không được để trống")                                // Bao gồm kiểm tra null và empty
        @Email(message = "Email không đúng định dạng")
        @Schema(example = "string")                                                     // Xác định giá trị mặc định cho email trong Swagger
        String email,

        @NotBlank(message = "Password không được để trống")
        @Size(min = 8, max = 20, message = "Password phải từ 8 đến 20 ký tự")
        @Pattern(regexp = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$",
                message = "Password phải chứa ít nhất 1 chữ hoa, 1 chữ thường, 1 số và 1 ký tự đặc biệt")
        @Schema(example = "string")
        String password
) {
}
