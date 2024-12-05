package vn.io.ductandev.junit;

import org.junit.jupiter.api.*;

import static org.junit.jupiter.api.Assertions.*;

//@DisplayNameGeneration(DisplayNameGenerator.ReplaceUnderscores.class)
class DemoUtilsTest_0 {

    DemoUtils demoUtils;

    @BeforeEach                                     // Run 2, 5
    void setupBeforeEach() {
        demoUtils = new DemoUtils();
        System.out.println("✅@BeforeEach executes before the execution of each test method");
    }

    @AfterEach                                     // Run 4, 7
    void tearDownAfterEach() {
        System.out.println("🔰Running @AfterEach");
        System.out.println();
    }

    @BeforeAll                                     // Run 1
    static void setupBeforeEachClass() {           // static
        System.out.println("⭐@BeforeAll executes only once before all test methods execution in the class");
        System.out.println();
    }

    @AfterAll                                     // Run 8
    static void tearDownAfterAll() {              // static
        System.out.println("⭐@AfterAll executes only once after all test methods execution in the class");
    }


    @Test                                         // Run 3
//    @DisplayName("Equals and Not Equals")
    void testEqualsAndNotEquals() {

        System.out.println("Running test: testEqualsAndNotEquals");

        assertEquals(6, demoUtils.add(2, 4), "2+4 must be 6");
        assertNotEquals(6, demoUtils.add(1, 9), "1+9 must not be 6");
    }

    @Test                                         // Run 6
//    @DisplayName("Null and Not Null")
    void testNullAndNotNull() {

        System.out.println("Running test: testNullAndNotNull");

        String str1 = null;
        String str2 = "luv2code";

        assertNull(demoUtils.checkNull(str1), "Object should be null");
        assertNotNull(demoUtils.checkNull(str2), "Object should not be null");

    }

}






