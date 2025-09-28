package com.frontend.controllers;

import com.frontend.services.ApiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ApiService apiService;

    // Admin Dashboard
    @GetMapping("/dashboard")
    public String adminDashboard(Model model) {
        // Get system statistics
        Map<String, Object> stats = apiService.getSystemHealth();
        model.addAttribute("systemStats", stats);

        return "admin/dashboard";
    }

    // Events Management Page
    @GetMapping("/events")
    public String eventsManagement(Model model) {
        // Get all events for admin view
        Map<String, Object> eventsData = apiService.getAllEvents();
        model.addAttribute("events", eventsData.get("data"));

        return "admin/events";
    }

    // Add New Event Form
    @GetMapping("/events/add")
    public String addEventForm() {
        return "admin/add-event";
    }

    // Add New Event - POST
    @PostMapping("/events/add")
    @ResponseBody
    public Map<String, Object> addEvent(@RequestBody Map<String, Object> eventData) {
        System.out.println("🚂 Admin adding new event: " + eventData);

        try {
            Map<String, Object> response = apiService.createEvent(eventData);
            return response;
        } catch (Exception e) {
            return Map.of("success", false, "error", "Failed to add event: " + e.getMessage());
        }
    }

    // Edit Event
    @GetMapping("/events/edit/{id}")
    public String editEventForm(@PathVariable String id, Model model) {
        Map<String, Object> eventData = apiService.getEventById(id);
        model.addAttribute("event", eventData.get("data"));
        model.addAttribute("eventId", id);

        return "admin/edit-event";
    }

    // Update Event - POST
    @PostMapping("/events/edit/{id}")
    @ResponseBody
    public Map<String, Object> updateEvent(@PathVariable String id,
                                           @RequestBody Map<String, Object> eventData) {
        System.out.println("✏️ Admin updating event " + id + ": " + eventData);

        try {
            Map<String, Object> response = apiService.updateEvent(id, eventData);
            return response;
        } catch (Exception e) {
            return Map.of("success", false, "error", "Failed to update event: " + e.getMessage());
        }
    }

    // Delete Event
    @DeleteMapping("/events/{id}")
    @ResponseBody
    public Map<String, Object> deleteEvent(@PathVariable String id) {
        System.out.println("🗑️ Admin deleting event: " + id);

        try {
            Map<String, Object> response = apiService.deleteEvent(id);
            return response;
        } catch (Exception e) {
            return Map.of("success", false, "error", "Failed to delete event: " + e.getMessage());
        }
    }

    // Bookings Management
    @GetMapping("/bookings")
    public String bookingsManagement(Model model) {
        Map<String, Object> bookingsData = apiService.getAllBookings();
        model.addAttribute("bookings", bookingsData.get("data"));

        return "admin/bookings";
    }

    // Create Demo Data
    @PostMapping("/create-demo-data")
    @ResponseBody
    public Map<String, Object> createDemoData() {
        System.out.println("🎯 Admin creating demo data");

        try {
            Map<String, Object> response = apiService.createDemoData();
            return response;
        } catch (Exception e) {
            return Map.of("success", false, "error", "Failed to create demo data: " + e.getMessage());
        }
    }

    // System Health Check
    @GetMapping("/system-health")
    @ResponseBody
    public Map<String, Object> systemHealth() {
        return apiService.getSystemHealth();
    }
}
