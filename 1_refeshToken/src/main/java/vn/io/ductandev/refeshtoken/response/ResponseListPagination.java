package vn.io.ductandev.refeshtoken.response;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@AllArgsConstructor             // Tạo constructor với tất cả các thuộc tính
@Builder                        // Tạo builder pattern cho lớp
public class ResponseListPagination<T> {
    String message;
    int statusCode;
    List<T> data;
    int total;
    int page;
    int limit;
    Date date;
}



//ResponseListPagination<String> response = ResponseListPagination.<String>builder()
//        .message("Success")
//        .statusCode(200)
//        .data(List.of("item1", "item2"))
//        .total(100)
//        .page(1)
//        .limit(10)
//        .date(new Date())
//        .build();
