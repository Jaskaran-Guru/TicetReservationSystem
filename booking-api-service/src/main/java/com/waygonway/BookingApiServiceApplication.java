package com.waygonway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class BookingApiServiceApplication {

    public static void main(String[] args) {
        System.setProperty("server.port", "8082");
        SpringApplication.run(BookingApiServiceApplication.class, args);
        System.out.println("🎫 Booking API Service started on http://localhost:8082");
    }
}
