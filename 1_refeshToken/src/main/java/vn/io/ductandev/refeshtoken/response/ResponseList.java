package vn.io.ductandev.refeshtoken.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor             // Tạo constructor với tất cả các thuộc tính
@Builder                        // Tạo builder pattern cho lớp
public class ResponseList<T> {
    String message;
    int statusCode;
    List<T> data;
    Date date;
}




//ResponseList<String> response = ResponseList.<String>builder()
//        .message("Success")
//        .statusCode(200)
//        .data(List.of("item1", "item2"))
//        .date(new Date())
//        .build();
