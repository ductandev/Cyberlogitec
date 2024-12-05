package vn.io.ductandev.javabasic.lesson_3_annotaion_IOC;


import org.springframework.stereotype.Component;

@Component
public class EmailService implements MessageService {

    @Override
    public void sendMessage(String message) {
        System.out.println("Sending email: " + message);
    }
}
