package vn.io.ductandev.refeshtoken.dto;

import lombok.Data;

@Data
public class UserDTO extends BaseDTO {
    private String email;
    private String password;
    private String fullName;
    private RoleDTO role;
}
