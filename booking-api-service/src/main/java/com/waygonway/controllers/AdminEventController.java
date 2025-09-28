package com.waygonway.controllers;

import com.waygonway.entities.Event;
import com.waygonway.services.TrainBookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.*;

@RestController
@RequestMapping("/admin/events")
@CrossOrigin(origins = "*")
public class AdminEventController {

    @Autowired
    private TrainBookingService trainBookingService;

    // Get All Events for Admin
    @GetMapping("/all")
    public Map<String, Object> getAllEvents() {
        System.out.println("👨‍💼 Admin: Getting all events");

        try {
            List<Event> allEvents = trainBookingService.getAllEvents();
            return Map.of("success", true, "data", allEvents, "count", allEvents.size());
        } catch (Exception e) {
            return Map.of("success", false, "error", "Failed to fetch events");
        }
    }

    // Add New Event
    @PostMapping("/add")
    public Map<String, Object> addEvent(@RequestBody Map<String, Object> eventData) {
        System.out.println("➕ Admin: Adding new event - " + eventData);

        try {
            Event newEvent = trainBookingService.createEvent(eventData);
            return Map.of("success", true, "data", newEvent, "message", "Event added successfully");
        } catch (Exception e) {
            return Map.of("success", false, "error", "Failed to add event: " + e.getMessage());
        }
    }

    // Update Event
    @PutMapping("/update/{id}")
    public Map<String, Object> updateEvent(@PathVariable String id,
                                           @RequestBody Map<String, Object> eventData) {
        System.out.println("✏️ Admin: Updating event " + id + " - " + eventData);

        try {
            Event updatedEvent = trainBookingService.updateEvent(id, eventData);
            return Map.of("success", true, "data", updatedEvent, "message", "Event updated successfully");
        } catch (Exception e) {
            return Map.of("success", false, "error", "Failed to update event: " + e.getMessage());
        }
    }

    // Delete Event
    @DeleteMapping("/delete/{id}")
    public Map<String, Object> deleteEvent(@PathVariable String id) {
        System.out.println("🗑️ Admin: Deleting event " + id);

        try {
            boolean deleted = trainBookingService.deleteEvent(id);
            if (deleted) {
                return Map.of("success", true, "message", "Event deleted successfully");
            } else {
                return Map.of("success", false, "error", "Event not found");
            }
        } catch (Exception e) {
            return Map.of("success", false, "error", "Failed to delete event: " + e.getMessage());
        }
    }

    // Update Event Availability
    @PatchMapping("/availability/{id}")
    public Map<String, Object> updateEventAvailability(@PathVariable String id,
                                                       @RequestParam int availableSeats) {
        System.out.println("🎫 Admin: Updating availability for event " + id + " to " + availableSeats);

        try {
            Event updatedEvent = trainBookingService.updateEventAvailability(id, availableSeats);
            return Map.of("success", true, "data", updatedEvent, "message", "Availability updated");
        } catch (Exception e) {
            return Map.of("success", false, "error", "Failed to update availability: " + e.getMessage());
        }
    }

    // Create Demo Data
    @PostMapping("/create-demo-data")
    public Map<String, Object> createDemoData() {
        System.out.println("🎯 Admin: Creating demo data");

        try {
            List<Event> demoEvents = trainBookingService.createDemoData();
            return Map.of("success", true, "data", demoEvents, "count", demoEvents.size(),
                    "message", "Demo data created successfully");
        } catch (Exception e) {
            return Map.of("success", false, "error", "Failed to create demo data: " + e.getMessage());
        }
    }
}
