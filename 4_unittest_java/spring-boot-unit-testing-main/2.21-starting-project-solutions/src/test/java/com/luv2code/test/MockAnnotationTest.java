package com.luv2code.test;

import com.luv2code.component.MvcTestingExampleApplication;
import com.luv2code.component.dao.ApplicationDao;
import com.luv2code.component.models.CollegeStudent;
import com.luv2code.component.models.StudentGrades;
import com.luv2code.component.service.ApplicationService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.ApplicationContext;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@SpringBootTest(classes= MvcTestingExampleApplication.class)
public class MockAnnotationTest {

    @Autowired
    ApplicationContext context;

    @Autowired
    CollegeStudent studentOne;

    @Autowired
    StudentGrades studentGrades;

    // @Mock
    @MockBean
    private ApplicationDao applicationDao;

    // @InjectMocks
    @Autowired
    private ApplicationService applicationService;

    @BeforeEach
    public void beforeEach() {
        studentOne.setFirstname("Eric");
        studentOne.setLastname("Roby");
        studentOne.setEmailAddress("eric.roby@luv2code_school.com");
        studentOne.setStudentGrades(studentGrades);
    }

    @DisplayName("When & Verify")
    @Test
    public void assertEqualsTestAddGrades() {
        when(applicationDao.addGradeResultsForSingleClass(
                                    studentGrades.getMathGradeResults())).thenReturn(100.00);

        assertEquals(100, applicationService.addGradeResultsForSingleClass(
                                    studentOne.getStudentGrades().getMathGradeResults()));

        verify(applicationDao).addGradeResultsForSingleClass(studentGrades.getMathGradeResults());

        verify(applicationDao, times(1)).addGradeResultsForSingleClass(
                                                                    studentGrades.getMathGradeResults());
    }

    @DisplayName("Find Gpa")
    @Test
    public void assertEqualsTestFindGpa() {
        when(applicationDao.findGradePointAverage(studentGrades.getMathGradeResults()))
                .thenReturn(88.31);
        assertEquals(88.31, applicationService.findGradePointAverage(studentOne
                .getStudentGrades().getMathGradeResults()));
    }

    @DisplayName("Not Null")
    @Test
    public void testAssertNotNull() {
        when(applicationDao.checkNull(studentGrades.getMathGradeResults()))
                .thenReturn(true);
        assertNotNull(applicationService.checkNull(studentOne.getStudentGrades()
                .getMathGradeResults()), "Object should not be null");
    }

    @DisplayName("Throw runtime error")
    @Test
    public void throwRuntimeError() {
        // ✅ nullStudent : tạo đối tượng từ Spring container, có thể được cấu hình và tích hợp các tính năng của Spring.
        CollegeStudent nullStudent = (CollegeStudent) context.getBean("collegeStudent");

        // giả lập hành vi của một phương thức trong mock (mockito) nhằm mô phỏng tình huống xảy ra lỗi khi phương thức được gọi.
        doThrow(new RuntimeException()).when(applicationDao).checkNull(nullStudent);

        assertThrows(RuntimeException.class, () -> {
            applicationService.checkNull(nullStudent);
        });

        // 5 ✅: Kiểm tra số lần phương thức được gọi: Đảm bảo rằng checkNull đã được gọi 2 lần.
        verify(applicationDao, times(1)).checkNull(nullStudent);
    }

    @DisplayName("Multiple Stubbing")
    @Test
    public void stubbingConsecutiveCalls() {
        // 1 ✅ Khai báo đối tượng mock: Lấy một bean collegeStudent từ Spring Context.
        CollegeStudent nullStudent = (CollegeStudent) context.getBean("collegeStudent");

        // 2: ✅ Stubbing với hành vi khác nhau:
        when(applicationDao.checkNull(nullStudent))
                .thenThrow(new RuntimeException())                    // Lần gọi đầu tiên ném ngoại lệ RuntimeException
                .thenReturn("Do not throw exception second time"); // Lần gọi thứ hai trả về một chuỗi.


        // 3 ✅: Kiểm tra lần gọi đầu tiên: Xác minh rằng lần gọi đầu tiên đến checkNull ném RuntimeException.
        assertThrows(RuntimeException.class, () -> {
            applicationService.checkNull(nullStudent);
        });

        // 4 ✅: Kiểm tra lần gọi thứ hai: Xác minh rằng lần gọi thứ hai đến checkNull trả về chuỗi "Do not throw exception second time".
        assertEquals("Do not throw exception second time",
                applicationService.checkNull(nullStudent));

        // 5 ✅: Kiểm tra số lần phương thức được gọi: Đảm bảo rằng checkNull đã được gọi 2 lần.
        verify(applicationDao, times(2)).checkNull(nullStudent);
    }

}
















