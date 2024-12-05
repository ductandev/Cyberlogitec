package com.cybersoft.uniclub06.utils;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Date;

@Component
public class JwtHelper {

    @Value("${jwts.key}")
    private String strKey;

    private int expriredTime = 8 * 60 * 60 * 1000;
//LocalDateTime

    public String generateToken(String data){
        //Biến key kiểu string đã lưu trữ trước đó thành SecrectKey
        SecretKey secretKey = Keys.hmacShaKeyFor(Decoders.BASE64URL.decode(strKey));
        Date currentDate = new Date();
        long miliSecondFuture = currentDate.getTime() + expriredTime;
        Date dateFuture = new Date(miliSecondFuture);

        String token = Jwts.builder().signWith(secretKey).expiration(dateFuture).subject(data).compact();

        return token;
    }

    public String decodeToken(String token){
        SecretKey secretKey = Keys.hmacShaKeyFor(Decoders.BASE64URL.decode(strKey));
        return Jwts.parser()
                .verifyWith(secretKey).build()
                .parseSignedClaims(token)
                .getPayload()
                .getSubject();
    }

}
