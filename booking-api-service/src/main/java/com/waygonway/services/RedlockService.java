package com.waygonway.services;

import org.springframework.stereotype.Service;
import java.time.Duration;

/**
 * Simple in-memory lock service replacing Redis Redlock.
 * In production, swap back to Redis for distributed locking.
 */
@Service
public class RedlockService {

    /**
     * Always grants the lock in local/dev mode (no Redis needed).
     */
    public boolean acquireLock(String lockKey, Duration timeoutDuration) {
        // No-op: allow all operations in local mode without Redis
        return true;
    }

    /**
     * Releases the lock (no-op in local mode).
     */
    public void releaseLock(String lockKey) {
        // No-op in local mode
    }
}
