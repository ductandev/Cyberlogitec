package vn.io.ductandev.javabasic.lesson_4_bean;


import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import vn.io.ductandev.javabasic.lesson_3_annotaion_IOC.Client;

@SpringBootApplication
public class Main {

    public static void main(String[] args) {
        // ✅ ApplicationContext: Thằng này chính là thằng quản lý tất cả đối tượng ở trong container  !!!!! ⭐⭐⭐⭐⭐
        ApplicationContext context = SpringApplication.run(Main.class, args);

        Boy boy1 = context.getBean(Boy.class);
        System.out.println("BOY1: " + boy1);

        Boy boy2 = context.getBean(Boy.class);
        System.out.println("BOY2: " + boy2);
    }
}