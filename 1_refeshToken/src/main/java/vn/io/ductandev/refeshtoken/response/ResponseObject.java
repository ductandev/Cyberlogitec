package vn.io.ductandev.refeshtoken.response;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@Builder
public class ResponseObject<T> {
    private List<String> message;
    private int statusCode;
    private T content;
    private Date date;
}