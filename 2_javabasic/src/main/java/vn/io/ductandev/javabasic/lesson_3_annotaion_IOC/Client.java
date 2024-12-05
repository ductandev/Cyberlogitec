package vn.io.ductandev.javabasic.lesson_3_annotaion_IOC;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Client {

    // 🟩 Loose-coupling
    @Autowired
    private MessageService messageService;

    // Constructor  => Cách 1: ✅ Contructor injection
//    public Client(MessageService messageServiceParam){
//        this.messageService = messageServiceParam;
//    }

    // Method
    public void processMessage(String message){
        messageService.sendMessage(message);
    }
}