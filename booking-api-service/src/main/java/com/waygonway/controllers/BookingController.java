package com.waygonway.controllers;

import com.waygonway.entities.Booking;
import com.waygonway.services.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/v1/bookings")
@CrossOrigin(origins = "*")
public class BookingController {

    @Autowired
    private BookingService bookingService;

    @GetMapping("/paged")
    public Page<Booking> getAllBookingsPaged(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        return bookingService.getAllBookingsPaged(PageRequest.of(page, size));
    }

    @PutMapping("/status/{pnr}")
    public Map<String, Object> updateBookingStatus(@PathVariable String pnr, @RequestBody Map<String, String> statusData) {
        try {
            Booking booking = bookingService.updateBookingStatus(pnr, statusData.get("status"));
            return Map.of("success", true, "data", booking);
        } catch (Exception e) {
            return Map.of("success", false, "error", e.getMessage());
        }
    }

    @PostMapping
    public Map<String, Object> createBooking(@RequestBody Map<String, Object> bookingData) {
        try {
            Booking booking = bookingService.createBooking(bookingData);
            return Map.of("success", true, "data", booking);
        } catch (Exception e) {
            return Map.of("success", false, "error", e.getMessage());
        }
    }

    @GetMapping("/pnr/{pnr}")
    public Map<String, Object> getBookingByPnr(@PathVariable String pnr) {
        Optional<Booking> booking = bookingService.getBookingByPnr(pnr);
        return booking.map(value -> Map.of("success", true, "data", value))
                .orElseGet(() -> Map.of("success", false, "error", "Booking not found"));
    }

    @GetMapping("/user/{userId}")
    public Map<String, Object> getUserBookings(@PathVariable String userId) {
        List<Booking> bookings = bookingService.getUserBookings(userId);
        return Map.of("success", true, "data", bookings);
    }
}
