package vn.io.ductandev.javabasic.lesson_2_dependency_injection_DI.service;

public class SMSService implements MessageService {

    public void sendMessage(String message){
        System.out.println("Send SMS: " + message);
    }
}
