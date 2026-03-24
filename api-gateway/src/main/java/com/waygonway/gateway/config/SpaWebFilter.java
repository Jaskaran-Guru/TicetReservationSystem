package com.waygonway.gateway.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.server.ServerWebExchange;
import org.springframework.web.server.WebFilter;
import org.springframework.web.server.WebFilterChain;
import reactor.core.publisher.Mono;

@Configuration
public class SpaWebFilter implements WebFilter {
    @Override
    public Mono<Void> filter(ServerWebExchange exchange, WebFilterChain chain) {
        String path = exchange.getRequest().getURI().getPath();
        if (!path.startsWith("/api/v1/") && !path.contains(".") && !path.equals("/")) {
            return chain.filter(
                exchange.mutate().request(exchange.getRequest().mutate().path("/index.html").build()).build()
            );
        }
        return chain.filter(exchange);
    }
}
