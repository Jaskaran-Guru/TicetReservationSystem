package com.frontend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.RestTemplate;

@SpringBootApplication
public class FrontendServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(FrontendServiceApplication.class, args);
        System.out.println("🌐 Frontend Service started on http://localhost:8080");
    }



}
