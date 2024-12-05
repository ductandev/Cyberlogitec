package vn.io.ductandev.refeshtoken.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import vn.io.ductandev.refeshtoken.response.ResponseObject;

import java.util.Collections;
import java.util.Date;
import java.util.List;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ResponseObject<?>> handleValidationExceptions(MethodArgumentNotValidException ex) {
        List<String> errorMessages = ex.getBindingResult()
                .getFieldErrors()
                .stream()
                .map(error -> error.getDefaultMessage())                            // Chỉ lấy thông báo lỗi
                .toList();

        ResponseObject<String> response = ResponseObject.<String>builder()
                .message(errorMessages)
                .statusCode(HttpStatus.BAD_REQUEST.value())
                .content("")
                .date(new Date())
                .build();

        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }


    @ExceptionHandler(AuthenException.class)
    public ResponseEntity<ResponseObject<?>> handleAuthenException(AuthenException ex) {
        ResponseObject<String> response = ResponseObject.<String>builder()
                .message(Collections.singletonList(ex.getMessage())) // Lấy thông báo từ AuthenException
                .statusCode(HttpStatus.UNAUTHORIZED.value())
                .content("")
                .date(new Date())
                .build();

        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ResponseObject<?>> handleGeneralException(Exception ex) {
        ResponseObject<String> response = ResponseObject.<String>builder()
                .message(Collections.singletonList("Đã xảy ra lỗi: " + ex.getMessage())) // Lấy thông báo lỗi chung
                .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                .content("")
                .date(new Date())
                .build();

        ex.printStackTrace();
        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
