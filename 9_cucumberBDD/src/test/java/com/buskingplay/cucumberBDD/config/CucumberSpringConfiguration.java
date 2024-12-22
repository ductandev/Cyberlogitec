package com.buskingplay.cucumberBDD.config;

import io.cucumber.spring.CucumberContextConfiguration;
import org.springframework.boot.test.context.SpringBootTest;
import com.buskingplay.cucumberBDD.runner.CucumberTestRunner;

@CucumberContextConfiguration
@SpringBootTest(classes = CucumberTestRunner.class) // Đảm bảo lớp chính xác
public class CucumberSpringConfiguration {
    // Cấu hình Spring Context cho Cucumber
}

