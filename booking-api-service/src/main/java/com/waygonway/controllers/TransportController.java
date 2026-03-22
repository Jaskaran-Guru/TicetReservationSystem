package com.waygonway.controllers;

import com.waygonway.entities.TransportBooking;
import com.waygonway.entities.TransportSchedule;
import com.waygonway.services.TransportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/transport")
@CrossOrigin(origins = "*")
public class TransportController {

    @Autowired
    private TransportService transportService;

    @GetMapping("/schedules")
    public Map<String, Object> searchSchedules(
            @RequestParam(required = false) String type,
            @RequestParam(required = false) String source,
            @RequestParam(required = false) String destination) {
        List<TransportSchedule> schedules = transportService.searchSchedules(type, source, destination);
        return Map.of("success", true, "data", schedules);
    }

    @PostMapping("/bookings")
    public Map<String, Object> createBooking(@RequestBody Map<String, Object> bookingData) {
        try {
            TransportBooking booking = transportService.createTransportBooking(bookingData);
            return Map.of("success", true, "data", booking);
        } catch (Exception e) {
            return Map.of("success", false, "error", e.getMessage());
        }
    }

    @PutMapping("/bookings/status/{pnr}")
    public Map<String, Object> updateBookingStatus(@PathVariable String pnr, @RequestBody Map<String, String> payload) {
        try {
            TransportBooking booking = transportService.confirmBookingStatus(pnr, payload.get("status"));
            return Map.of("success", true, "data", booking);
        } catch (Exception e) {
            return Map.of("success", false, "error", e.getMessage());
        }
    }

    @GetMapping("/bookings/user/{userId}")
    public Map<String, Object> getUserBookings(@PathVariable String userId) {
        List<TransportBooking> bookings = transportService.getUserBookings(userId);
        return Map.of("success", true, "data", bookings);
    }
    
    @GetMapping("/admin/bookings/all")
    public Map<String, Object> getAllBookings() {
        List<TransportBooking> bookings = transportService.getAllBookings();
        return Map.of("success", true, "data", bookings);
    }

    @PostMapping("/schedules")
    public Map<String, Object> createSchedule(@RequestBody TransportSchedule schedule) {
        return Map.of("success", true, "data", transportService.createSchedule(schedule));
    }

    @DeleteMapping("/schedules/{id}")
    public Map<String, Object> deleteSchedule(@PathVariable String id) {
        transportService.deleteSchedule(id);
        return Map.of("success", true, "message", "Schedule deleted");
    }
}

