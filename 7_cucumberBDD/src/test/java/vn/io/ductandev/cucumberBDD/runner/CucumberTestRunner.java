package vn.io.ductandev.cucumberBDD.runner;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

/******************************************************************************************
 * features:	Chỉ định đường dẫn đến các file .feature.
 * glue:	    Chỉ định package chứa các step definitions cần sử dụng.
 * plugin:	    Cấu hình cách ghi lại kết quả chạy test (console, JSON, HTML, XML, v.v.).
 * dryRun	    Kiểm tra ánh xạ step definitions mà không chạy thực tế.
 * monochrome:	Kiểm soát định dạng và độ dễ đọc của log trên console.
 *******************************************************************************************/

@RunWith(Cucumber.class)
@CucumberOptions(
        features = "src/test/resources/feature",
        glue = {"vn.io.ductandev.cucumberBDD.steps", "vn.io.ductandev.cucumberBDD.config"},
        plugin = {"pretty", "html:target/cucumber.html"},   // {"pretty", "json:target/cucumber.json"}
        dryRun = false,
        monochrome = false
)
public class CucumberTestRunner {

}
