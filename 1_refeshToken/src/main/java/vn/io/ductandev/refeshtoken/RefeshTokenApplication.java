package vn.io.ductandev.refeshtoken;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class RefeshTokenApplication {

	public static void main(String[] args) {
		SpringApplication.run(RefeshTokenApplication.class, args);
		System.out.println("http://localhost:8080/swagger");
	}

}
