package vn.io.ductandev.javabasic.lesson_4_bean;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;


//@Component
//@Scope("prototype")
public class Boy {

    @Autowired
    private ObjectMapper objectMapper;

    public void useObjectMapper() {
        System.out.println("objectMapper: " + objectMapper);
    }
}
