package com.waygonway.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Map;
import java.time.LocalDateTime;

@RestController
@RequestMapping("/api/v1/events")
public class PingController {

    @GetMapping("/ping")
    public Map<String, Object> ping() {
        return Map.of(
            "status", "UP",
            "message", "Booking API Service is reachable",
            "timestamp", LocalDateTime.now().toString(),
            "service", "booking-api-service"
        );
    }
}
