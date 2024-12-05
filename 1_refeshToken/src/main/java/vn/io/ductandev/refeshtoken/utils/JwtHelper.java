package vn.io.ductandev.refeshtoken.utils;

import io.jsonwebtoken.ClaimJwtException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import vn.io.ductandev.refeshtoken.entity.UserEntity;

import javax.crypto.SecretKey;
import java.util.Date;
import java.util.function.Function;

@Component
public class JwtHelper {

    @Value("${jwts.key}")
    private String strKey;

    private int expriredTimeAccessToken = 3 * 60 * 1000;
    private int expriredTimeRefreshToken = 5 * 60 * 1000;

    public String generateAccessToken(UserEntity userEntity){
        SecretKey secretKey = Keys.hmacShaKeyFor(Decoders.BASE64URL.decode(strKey));

        Date currentDate = new Date();
        long miliSecondFuture = currentDate.getTime() + expriredTimeAccessToken;
        Date dateFuture = new Date(miliSecondFuture);

        String token =
                Jwts.builder()
                        .signWith(secretKey)
                        .subject(String.valueOf(userEntity.getId()))
                        .expiration(dateFuture)
                        .compact();

        return token;
    }

    public String generateRefreshToken(UserEntity userEntity){
        SecretKey secretKey = Keys.hmacShaKeyFor(Decoders.BASE64URL.decode(strKey));

        Date currentDate = new Date();
        long miliSecondFuture = currentDate.getTime() + expriredTimeRefreshToken;
        Date dateFuture = new Date(miliSecondFuture);

        String token =
                Jwts.builder()
                        .signWith(secretKey)
                        .subject(String.valueOf(userEntity.getId()))
                        .expiration(dateFuture)
                        .compact();

        return token;
    }

    public String decodeToken(String token){
        SecretKey secretKey = Keys.hmacShaKeyFor(Decoders.BASE64URL.decode(strKey));
        return Jwts.parser()
                .verifyWith(secretKey)
                .build()
                .parseSignedClaims(token)   // truyền token cần giải mã
                .getPayload()               // Token gồm 3 phần, Header, Payload, Signature thì GetPayload để lấy dữ liệu ở phần Payload
                .getSubject();              // Lấy dữ liệu ở phần Subject đã lưu trước đó.
    }

    public boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }

    private Claims extractAllClaims(String token) {
        SecretKey secretKey = Keys.hmacShaKeyFor(Decoders.BASE64URL.decode(strKey));
        Claims claims = null;
        try {
            claims = Jwts.parser()
                    .verifyWith(secretKey)
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        } catch (ClaimJwtException ex) {
            claims = ex.getClaims();

        }
        return claims;
    }

    private Date extractExpiration(String token) {
        return extractClaim(token, Claims::getExpiration);
    }

    private <T> T extractClaim(String token, Function<Claims, T> claimsResolver) {
        final Claims claims = extractAllClaims(token);
        return claimsResolver.apply(claims);
    }

    public String extractUsername(String token) {
        return extractClaim(token, Claims::getSubject);
    }

}

