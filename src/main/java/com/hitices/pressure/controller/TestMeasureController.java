package com.hitices.pressure.controller;

import com.hitices.pressure.common.MResponse;
import org.apache.commons.lang3.RandomUtils;
import org.springframework.web.bind.annotation.*;

import java.util.Random;

@CrossOrigin
@RestController
@RequestMapping("/testMeasure")
public class TestMeasureController {

    @GetMapping("/singleTest")
    public MResponse<Integer> getAllTestPlans() {
        Integer res = 1208;
        return new MResponse<Integer>().successMResponse().data(res);
    }

    @GetMapping("/getSystem")
    public MResponse<String> getSystem() {
//        System.out.println("Received");
        try {
            Thread.sleep(new Random().nextInt(401) + 100);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
        return new MResponse<String>().successMResponse().data(System.getProperty("os.name"));
    }
}
