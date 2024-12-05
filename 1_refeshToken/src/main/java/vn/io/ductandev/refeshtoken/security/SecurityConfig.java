package vn.io.ductandev.refeshtoken.security;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.security.SecurityScheme;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import vn.io.ductandev.refeshtoken.filter.Customfilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    };

    @Bean
    public AuthenticationManager authenticationManager(HttpSecurity http, CustomAuthenProvider customAuthenProvider) throws Exception {
        return http.getSharedObject(AuthenticationManagerBuilder.class)
                .authenticationProvider(customAuthenProvider)     // Khai báo để sài CustomAuthenProvider
                .build();
    }


    private final String[] PUBLIC_ENDPOINT_SWAGGER = {
            "/swagger-ui/**",
            "/api-docs/**",
            "/swagger",
            "/swagger-ui/index.html#/",
            "/api-docs/swagger-config"
    };

    // ===============================================
    //                  SECURITY
    // ===============================================
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http, Customfilter customfilter) throws Exception {
        return http
                .csrf(csrf -> csrf.disable())
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests(request -> {
                    request.requestMatchers(PUBLIC_ENDPOINT_SWAGGER).permitAll();
                    request.requestMatchers("api/auth/test").authenticated();          // Test Bear-key call API
                    request.requestMatchers("/api/auth/**").permitAll();               // link Ko cần chứng thực
                    request.anyRequest().authenticated();                                // Tất cả các link còn lại đều cần xác thực.
                })

                // ✅✅ Khai báo customfilter nằm trước, sử dụng trước UsernamePasswordAuthenticationFilter của security
                .addFilterBefore(customfilter, UsernamePasswordAuthenticationFilter.class)
                .build();
    }

    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
                .components(new Components()
                        .addSecuritySchemes("bearer-key",
                                new SecurityScheme()
                                        .type(SecurityScheme.Type.HTTP)
                                        .scheme("bearer")
                                        .bearerFormat("JWT")));
    }
}
