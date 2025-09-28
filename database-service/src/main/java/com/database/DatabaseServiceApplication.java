package com.database;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DatabaseServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(DatabaseServiceApplication.class, args);

        System.out.println("\n🗃️ ===== DATABASE SERVICE STARTED =====");
        System.out.println("📍 Port: 8083");
        System.out.println("📍 Service: Database Management & Analytics");
        System.out.println("📍 Health: http://localhost:8083/actuator/health");
        System.out.println("📍 Users: GET http://localhost:8083/data/users");
        System.out.println("📍 Analytics: GET http://localhost:8083/data/analytics");
        System.out.println("======================================\n");
    }
}
