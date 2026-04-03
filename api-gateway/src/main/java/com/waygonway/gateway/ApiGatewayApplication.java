package com.waygonway.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ApiGatewayApplication {
    public static void main(String[] args) {
        // Disable the default Netty DNS resolver to use the native system resolver on Render
        System.setProperty("reactor.netty.http.server.accessLogEnabled", "true");
        // This is a common workaround for DNS resolution in containerized environments
        System.setProperty("sun.net.spi.nameservice.nameservers", "8.8.8.8,1.1.1.1"); // Fallback fallback (Render usually provides its own, but we want to ensure resolution)
        
        SpringApplication.run(ApiGatewayApplication.class, args);
    }
}
