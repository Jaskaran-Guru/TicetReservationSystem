package com.waygonway.controllers;

import com.waygonway.entities.Booking;
import com.waygonway.services.TrainBookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.web.bind.annotation.*;
import java.util.*;

@RestController
@RequestMapping("/bookings")
@CrossOrigin(origins = "*")
public class BookingController {

    @Autowired
    private TrainBookingService trainBookingService;

    @Autowired(required = false) // Make it optional
    private MongoTemplate mongoTemplate;

    @PostMapping
    public Map<String, Object> createBooking(@RequestBody Map<String, Object> bookingData) {
        System.out.println("📝 Creating booking: " + bookingData);

        try {
            Booking booking = trainBookingService.createBooking(bookingData);
            return Map.of("success", true, "data", booking, "message", "Booking successful");
        } catch (Exception e) {
            System.err.println("Booking error: " + e.getMessage());
            return Map.of("success", false, "error", "Booking failed: " + e.getMessage());
        }
    }

    @GetMapping("/pnr/{pnr}")
    public Map<String, Object> getBookingByPNR(@PathVariable String pnr) {
        try {
            Booking booking = trainBookingService.getBookingByPNR(pnr);
            if (booking != null) {
                return Map.of("success", true, "data", booking);
            } else {
                return Map.of("success", false, "error", "PNR not found");
            }
        } catch (Exception e) {
            return Map.of("success", false, "error", "Error retrieving booking");
        }
    }

    @GetMapping("/user/{userId}")
    public Map<String, Object> getUserBookings(@PathVariable String userId) {
        try {
            List<Booking> bookings = trainBookingService.getUserBookings(userId);
            return Map.of("success", true, "data", bookings, "count", bookings.size());
        } catch (Exception e) {
            return Map.of("success", false, "error", "Error retrieving user bookings");
        }
    }

    @GetMapping("/debug")
    public Map<String, Object> debugInfo() {
        return trainBookingService.getDebugInfo();
    }

    @GetMapping("/test")
    public Map<String, Object> testSave() {
        Map<String, Object> testData = new HashMap<>();
        testData.put("userId", "test123");
        testData.put("passengerName", "Test Passenger");
        testData.put("trainName", "Test Train");
        testData.put("source", "Mumbai");
        testData.put("destination", "Delhi");
        testData.put("totalAmount", 1500.0);

        Booking booking = trainBookingService.createBooking(testData);
        return Map.of("success", true, "booking", booking);
    }

    @GetMapping("/mongodb-test")
    public Map<String, Object> testMongoDB() {
        if (mongoTemplate == null) {
            return Map.of(
                    "success", false,
                    "mongoConnected", false,
                    "error", "MongoDB not configured",
                    "message", "Using file-based storage"
            );
        }

        try {
            // Count documents
            long count = mongoTemplate.count(new Query(), Booking.class);

            // Get all bookings
            List<Booking> allBookings = mongoTemplate.findAll(Booking.class);

            return Map.of(
                    "success", true,
                    "mongoConnected", true,
                    "totalBookings", count,
                    "bookings", allBookings
            );
        } catch (Exception e) {
            return Map.of(
                    "success", false,
                    "mongoConnected", false,
                    "error", e.getMessage()
            );
        }
    }

    @GetMapping("/health")
    public Map<String, Object> healthCheck() {
        return Map.of("success", true, "service", "Booking Controller", "status", "Running");
    }
}
