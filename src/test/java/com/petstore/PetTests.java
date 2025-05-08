package com.petstore;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;

public class PetTests {
    private static final int DEFAULT_THREAD_COUNT = 2;

    @Test
    void testParallel() {
        int threadCount;

        try{
            String threadCountValue = System.getProperty("threadCount");
            threadCount = Integer.parseInt(threadCountValue);
        } catch (Exception e){
            threadCount = DEFAULT_THREAD_COUNT;
        }

        Results results = Runner.path("classpath:karate/tests/pet")
                .outputJunitXml(true)
                .parallel(threadCount);
        assertThat(results.getFailCount()).as(results.getErrorMessages()).isZero();
    }
}
