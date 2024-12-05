package vn.io.ductandev.javabasic.lesson_2_dependency_injection_DI;


import vn.io.ductandev.javabasic.lesson_2_dependency_injection_DI.service.EmailService;
import vn.io.ductandev.javabasic.lesson_2_dependency_injection_DI.service.SMSService;

public class Main {
    public static void main(String[] args) {
        EmailService emailService = new EmailService();
        SMSService smsService = new SMSService();

        // Cách 1: ✅ Contructor injection
        Client client_1 = new Client(emailService);

        // Cách 2: ✅ Setter injection
        Client client_2 = new Client();
        client_2.setMessageService(smsService);

        // Cách 3: ✅ Interface injection
        Client client_3 = new Client();
        client_3.setMessageService(emailService);


        client_1.processMessage("Hello World 1!");
        client_2.processMessage("Hello World 2!");
        client_3.processMessage("Hello World 3!");
    }
}