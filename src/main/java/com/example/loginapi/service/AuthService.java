package com.example.loginapi.service;

import com.example.loginapi.dto.LoginRequest;
import com.example.loginapi.dto.LoginResponse;
import com.example.loginapi.dto.RegisterRequest;
import com.example.loginapi.model.User;
import com.example.loginapi.repository.UserRepository;
import com.example.loginapi.util.JwtUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    private static final Logger logger = LoggerFactory.getLogger(AuthService.class);

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtUtil jwtUtil;

    public LoginResponse login(LoginRequest loginRequest) {
        logger.info("Attempting login for user: {}", loginRequest.getUsername());
        
        try {
            // Find user by username
            User user = userRepository.findByUsername(loginRequest.getUsername())
                    .orElseThrow(() -> new RuntimeException("User not found"));

            // Check password (simple comparison for now)
            if (!passwordEncoder.matches(loginRequest.getPassword(), user.getPassword())) {
                logger.error("Login failed for user {}: Invalid credentials", loginRequest.getUsername());
                throw new RuntimeException("Invalid username or password");
            }

            // Generate JWT token
            String token = jwtUtil.generateToken(user);
            
            logger.info("Login successful for user: {}", loginRequest.getUsername());

            return new LoginResponse(
                    token,
                    user.getId(),
                    user.getUsername(),
                    user.getEmail(),
                    user.getRole()
            );
        } catch (Exception e) {
            logger.error("Login failed for user {}: {}", loginRequest.getUsername(), e.getMessage());
            throw new RuntimeException("Login failed: " + e.getMessage(), e);
        }
    }
    
    public User register(RegisterRequest registerRequest) {
        if (userRepository.existsByUsername(registerRequest.getUsername())) {
            throw new RuntimeException("Username already exists");
        }

        if (userRepository.existsByEmail(registerRequest.getEmail())) {
            throw new RuntimeException("Email already exists");
        }

        User user = new User();
        user.setUsername(registerRequest.getUsername());
        user.setPassword(passwordEncoder.encode(registerRequest.getPassword()));
        user.setEmail(registerRequest.getEmail());

        return userRepository.save(user);
    }
}
