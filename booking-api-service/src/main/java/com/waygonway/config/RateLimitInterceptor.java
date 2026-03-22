package com.waygonway.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

@Component
public class RateLimitInterceptor implements HandlerInterceptor {

    private final ConcurrentHashMap<String, AtomicInteger> requestCounts = new ConcurrentHashMap<>();
    private final ConcurrentHashMap<String, Long> timestamps = new ConcurrentHashMap<>();

    // Limit configuration: 100 requests per minute
    private static final int MAX_REQUESTS = 100;
    private static final long TIME_WINDOW_MS = 60000;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String ip = request.getRemoteAddr();
        // In a real cloud env, use X-Forwarded-For
        String forwardedFor = request.getHeader("X-Forwarded-For");
        if (forwardedFor != null && !forwardedFor.isEmpty()) {
            ip = forwardedFor.split(",")[0];
        }

        long currentTime = System.currentTimeMillis();

        timestamps.putIfAbsent(ip, currentTime);
        requestCounts.putIfAbsent(ip, new AtomicInteger(0));

        // Reset window
        if (currentTime - timestamps.get(ip) > TIME_WINDOW_MS) {
            timestamps.put(ip, currentTime);
            requestCounts.get(ip).set(0);
        }

        // Increment and restrict
        if (requestCounts.get(ip).incrementAndGet() > MAX_REQUESTS) {
            response.setStatus(HttpStatus.TOO_MANY_REQUESTS.value());
            response.getWriter().write("Too Many Requests. Please try again later.");
            return false;
        }

        return true;
    }
}
