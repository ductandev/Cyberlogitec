package vn.io.ductandev.javabasic.lesson_2_dependency_injection_DI;


import vn.io.ductandev.javabasic.lesson_2_dependency_injection_DI.service.EmailService;
import vn.io.ductandev.javabasic.lesson_2_dependency_injection_DI.service.InjectionMesses;
import vn.io.ductandev.javabasic.lesson_2_dependency_injection_DI.service.MessageService;

public class Client implements InjectionMesses {
    // 🟥 Tight-coupling
    // EmailService được định nghĩa cụ thể ở trong các class Cilent luôn thì như thế này được gọi là ràng buộc Tight-Coupling
    // private EmailService emailService = new EmailService();



    // 🟩 Loose-coupling
    private MessageService messageService;

    // Constructor ko có tham số
    public Client(){}

    // Constructor  => Cách 1: ✅ Contructor injection
    public Client(MessageService messageServiceParam){
        this.messageService = messageServiceParam;          // MessageService hiện tại = SMSService
    }

    // Setter => Cách 2: ✅ Setter injection
    public void setMessageService(MessageService messageService) {
        this.messageService = messageService;
    }

    // Method
    public void processMessage(String message){
        messageService.sendMessage(message);
    }

    // implements InjectionMesses =>  Cách 3: ✅ Interface injection
    @Override
    public void setService(MessageService messageService) {
        this.messageService = messageService;
    }
}