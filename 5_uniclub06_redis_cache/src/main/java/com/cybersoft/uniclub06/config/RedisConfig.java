package com.cybersoft.uniclub06.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.redis.connection.RedisStandaloneConfiguration;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;

@Configuration
public class RedisConfig {

    @Value("${redis.port}")
    private int port;

    @Value("${redis.host}")
    private String host;


    // =================================================
    //          TẠO KẾT NỐI ĐẾN REDIS
    // =================================================
    @Bean
    public LettuceConnectionFactory lettuceConnectionFactory() {
        RedisStandaloneConfiguration config = new RedisStandaloneConfiguration();
        config.setHostName(host);
        config.setPort(port);
        // Nếu ko set Database thì mặc định nó sẽ sài vị trí 0
        //config.setDatabase(0);

        return new LettuceConnectionFactory(config);
    }


    // Đoạn code này dùng để biến dữ liệu thành kiểu string CHUẨN HẾT để có thể chia sẽ dữ liệu cho các ứng dụng khác ngoài java
    // =================================================
    //        TẠO TEMPLATE MỚI ĐỂ LƯU TRỮ DỮ LIỆU
    // =================================================
    @Bean
    @Primary
    public RedisTemplate<String, String> redisTemplate(LettuceConnectionFactory lettuceConnectionFactory) {
        RedisTemplate<String, String> template = new RedisTemplate<>();
        template.setConnectionFactory(lettuceConnectionFactory);
        template.setKeySerializer(new StringRedisSerializer());
        template.setHashKeySerializer(new StringRedisSerializer());
        template.setHashValueSerializer(new StringRedisSerializer());
        template.setValueSerializer(new StringRedisSerializer());

        return template;
    }

//    @Bean
//    @Primary
//    public RedisTemplate<Object, Object> redisTemplate(RedisConnectionFactory redisConnectionFactory) {
//        // tạo ra một RedisTemplate
//        // Với Key là Object
//        // Value là Object
//        // RedisTemplate giúp chúng ta thao tác với Redis
//        RedisTemplate<Object, Object> template = new RedisTemplate<>();
//        template.setConnectionFactory(redisConnectionFactory);
//        return template;
//    }
}
