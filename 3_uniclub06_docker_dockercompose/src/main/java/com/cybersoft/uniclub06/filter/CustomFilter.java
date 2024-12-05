package com.cybersoft.uniclub06.filter;

import com.cybersoft.uniclub06.dto.AuthorityDTO;
import com.cybersoft.uniclub06.utils.JwtHelper;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Component
public class CustomFilter extends OncePerRequestFilter {

    @Autowired
    private JwtHelper jwtHelper;

    private ObjectMapper objectMapper = new ObjectMapper();

    private Gson gson = new Gson();


    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String authorHeader = request.getHeader("Authorization");
        if(authorHeader != null && authorHeader.startsWith("Bearer ")){
            String token = authorHeader.substring(7);
            String data = jwtHelper.decodeToken(token);
            if(data != null){
                List<AuthorityDTO> authorityDTOS = objectMapper.readValue(data, new TypeReference<List<AuthorityDTO>>() {
                });

//                List<GrantedAuthority> authorityList = new ArrayList<>();
//                authorityDTOS.forEach(dataDTO ->{
//                    SimpleGrantedAuthority simpleGrantedAuthority = new SimpleGrantedAuthority(dataDTO.getAuthority());
//                    authorityList.add(simpleGrantedAuthority);
//                });

                List<SimpleGrantedAuthority> authorityList = authorityDTOS.stream()
                        .map(item -> new SimpleGrantedAuthority(item.getAuthority())).toList();

                UsernamePasswordAuthenticationToken authenToken =
                        new UsernamePasswordAuthenticationToken("","",authorityList);

                SecurityContext context = SecurityContextHolder.getContext();
                context.setAuthentication(authenToken);
            }
        }

        filterChain.doFilter(request,response);
    }
}
