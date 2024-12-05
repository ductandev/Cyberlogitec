package vn.io.ductandev.javabasic.lesson_3_annotaion_IOC;


import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

@SpringBootApplication
public class Main {

    public static void main(String[] args) {
        // Cách 1: ✅ Contructor injection
//        SpringApplication.run(Main.class, args);
//        MessageService emailService = new EmailService();
//        Client client = new Client(emailService);
//        client.processMessage("Hello Word");

        // ✅ ApplicationContext: Thằng này chính là thằng quản lý tất cả đối tượng ở trong container  !!!!! ⭐⭐⭐⭐⭐
        ApplicationContext context = SpringApplication.run(Main.class, args);
        Client client = context.getBean(Client.class);    // Lấy đối tượng EmailService từ Spring Container (IoC Container)
        client.processMessage("ABC");                     // Gọi phương thức sendMessage
    }
}