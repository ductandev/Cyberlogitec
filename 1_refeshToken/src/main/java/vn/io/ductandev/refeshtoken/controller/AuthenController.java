package vn.io.ductandev.refeshtoken.controller;

import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vn.io.ductandev.refeshtoken.request.AuthenRequest;
import vn.io.ductandev.refeshtoken.request.RefeshTokenRequest;
import vn.io.ductandev.refeshtoken.response.ResponseObject;
import vn.io.ductandev.refeshtoken.service.AuthenService;

import java.util.Collections;
import java.util.Date;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthenController {

    private final AuthenService authenService;


    @PostMapping("/login")
    public ResponseEntity<?> authen(@Valid @RequestBody AuthenRequest authenRequest){

        ResponseObject<Object> response = ResponseObject.builder()
                .message(Collections.singletonList("Thành công !"))
                .statusCode(200)
                .content(authenService.login(authenRequest))
                .date(new Date())
                .build();

        return new ResponseEntity<>(response, HttpStatus.OK);
    }


    @PostMapping("/refresh-token")
    public ResponseEntity<?> refresh(@RequestBody RefeshTokenRequest refeshTokenRequest){

        ResponseObject<Object> response = ResponseObject.builder()
                .message(Collections.singletonList("Thành công !"))
                .statusCode(200)
                .content(authenService.newAccessToken(refeshTokenRequest))
                .date(new Date())
                .build();

        return new ResponseEntity<>(response, HttpStatus.OK);
    }


    @GetMapping("/test")
    @SecurityRequirement(name = "bearer-key")
    public String test(){

        return "Test Quyền !!!";
    }

}
