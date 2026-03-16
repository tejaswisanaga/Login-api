package com.example.loginapi.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class HealthController {

    @GetMapping("/health")
    public ResponseEntity<Map<String, Object>> health() {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "UP");
        response.put("timestamp", LocalDateTime.now());
        response.put("application", "Login API");
        response.put("version", "1.0.0");
        response.put("port", 8081);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/info")
    public ResponseEntity<Map<String, String>> info() {
        Map<String, String> response = new HashMap<>();
        response.put("application", "Login API with JWT Authentication");
        response.put("description", "Spring Boot REST API for user authentication");
        response.put("endpoints", "/api/auth/register, /api/auth/login, /api/auth/test");
        response.put("documentation", "Available at /api/health and /api/info");
        return ResponseEntity.ok(response);
    }

    @GetMapping("/")
    public ResponseEntity<Map<String, String>> root() {
        Map<String, String> response = new HashMap<>();
        response.put("message", "Login API is running!");
        response.put("status", "Check /api/health for detailed status");
        response.put("docs", "Visit /api/info for API information");
        return ResponseEntity.ok(response);
    }
}
