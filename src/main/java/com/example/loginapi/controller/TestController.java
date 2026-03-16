package com.example.loginapi.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @GetMapping("/ping")
    public String ping() {
        return "Pong - Application is running!";
    }

    @GetMapping("/status")
    public String status() {
        return "Login API Status: OK";
    }
}
