package com.database.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity; // FIXED: Now available
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy; // FIXED: Now available
import org.springframework.security.web.SecurityFilterChain; // FIXED: Now available

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception { // FIXED: Now all classes available
        http.csrf(csrf -> csrf.disable())
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)) // FIXED
                .authorizeHttpRequests(authz -> authz
                        .requestMatchers("/actuator/**", "/data/health", "/data/analytics").permitAll()
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .anyRequest().permitAll()
                );

        return http.build();
    }
}
