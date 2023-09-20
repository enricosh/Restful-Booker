package bdd;

import com.bcp.jiraxray.api.AccessJiraXray;
import com.bcp.jiraxray.util.GherkinUtil;
import com.bcp.jiraxray.util.LoggerUtil;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static util.ReportsUtil.generateCucumberReport;

class LabsTest {

    private static final Logger logger = LoggerUtil.getLogger(LabsTest.class);

    @Test
    void pruebasParalelas() {
        Results results =
                //Runner.path("classpath:bdd/demo")
                Runner.path("src/test/resources/features/Booker/Ping.feature")
                        .outputCucumberJson(true)
                        .parallel(2);
        generateCucumberReport(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @BeforeAll
    static void beforeClass() {
        logger.info("BEFORE >>>>>>>>>>>");
    }

    @AfterAll
    static void afterAll() {
        logger.info("AFTER >>>>>>>>>>>");
        AccessJiraXray.saveResultsJiraXray();
    }
}
