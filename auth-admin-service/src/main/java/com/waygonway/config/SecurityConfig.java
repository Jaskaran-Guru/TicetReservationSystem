package com.waygonway.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        System.out.println("🔒 SecurityConfig: Configuring security for auth-admin service");

        http
                .csrf(csrf -> csrf.disable())
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests(auth -> auth
                        // Public endpoints
                        .requestMatchers("/auth/**").permitAll()
                        .requestMatchers("/demo/**").permitAll()
                        .requestMatchers("/health").permitAll()
                        .requestMatchers("/actuator/**").permitAll()
                        // Admin endpoints (for future JWT implementation)
                        .requestMatchers("/admin/**").permitAll() // For now, allow all
                        .anyRequest().authenticated()
                );

        System.out.println("✅ SecurityConfig: Auth-admin service security configured");
        return http.build();
    }
}
