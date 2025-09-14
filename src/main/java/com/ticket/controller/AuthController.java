package com.ticket.controller;

import com.ticket.model.User;
import com.ticket.repository.UserRepository;
import com.ticket.security.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private UserRepository userRepo;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private PasswordEncoder passwordEncoder;


    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody User user) {
        if (userRepo.findByUsername(user.getUsername()).isPresent()) {
            return ResponseEntity.badRequest().body(Map.of("error", "Username already exists"));
        }


        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepo.save(user);

        return ResponseEntity.ok(Map.of("message", "User registered successfully"));
    }


    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody User user) {
        User dbUser = userRepo.findByUsername(user.getUsername())
                .orElseThrow(() -> new RuntimeException("Invalid username or password"));


        if (!passwordEncoder.matches(user.getPassword(), dbUser.getPassword())) {
            return ResponseEntity.status(401).body(Map.of("error", "Invalid username or password"));
        }

        String token = jwtUtil.generateToken(user.getUsername());
        return ResponseEntity.ok(Map.of("token", token));
    }
}
