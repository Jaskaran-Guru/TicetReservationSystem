package com.waygonway.controllers;

import com.waygonway.entities.Event;
import com.waygonway.services.TrainBookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.*;

@RestController
@RequestMapping("/events")
@CrossOrigin(origins = "*")
public class EventController {

    @Autowired
    private TrainBookingService trainBookingService;

    @GetMapping("/search")
    public Map<String, Object> searchEvents(@RequestParam String source,
                                            @RequestParam String destination,
                                            @RequestParam(required = false) String travelDate) {
        System.out.println("🔍 Search: " + source + " → " + destination);

        List<Event> trains = trainBookingService.searchTrains(source, destination);
        List<Map<String, Object>> trainMaps = new ArrayList<>();

        for (Event train : trains) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", train.getId());
            map.put("eventName", train.getEventName());
            map.put("eventCode", train.getEventCode());
            map.put("eventType", train.getEventType());
            map.put("source", train.getSource());
            map.put("destination", train.getDestination());
            map.put("description", train.getDescription());
            map.put("price", train.getPrice());
            map.put("totalSeats", train.getTotalSeats());
            map.put("availableSeats", train.getAvailableSeats());
            map.put("vehicleNumber", train.getVehicleNumber());
            map.put("basePrice", train.getBasePrice());
            trainMaps.add(map);
        }

        return Map.of("success", true, "data", trainMaps, "count", trainMaps.size());
    }

    @PostMapping("/create-demo-data")
    public Map<String, Object> createDemoData() {
        System.out.println("🚂 Creating demo data...");

        List<Event> trains = trainBookingService.createDemoData();
        List<Map<String, Object>> trainMaps = new ArrayList<>();

        for (Event train : trains) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", train.getId());
            map.put("eventName", train.getEventName());
            map.put("eventCode", train.getEventCode());
            map.put("source", train.getSource());
            map.put("destination", train.getDestination());
            map.put("price", train.getPrice());
            map.put("availableSeats", train.getAvailableSeats());
            trainMaps.add(map);
        }

        return Map.of("success", true, "message", trains.size() + " trains created", "data", trainMaps);
    }

    @GetMapping("/{id}")
    public Map<String, Object> getEventById(@PathVariable String id) {
        Event event = trainBookingService.getEventById(id);

        Map<String, Object> map = new HashMap<>();
        map.put("id", event.getId());
        map.put("eventName", event.getEventName());
        map.put("eventCode", event.getEventCode());
        map.put("source", event.getSource());
        map.put("destination", event.getDestination());
        map.put("price", event.getPrice());
        map.put("availableSeats", event.getAvailableSeats());

        return Map.of("success", true, "data", map);
    }

    @GetMapping("/health")
    public Map<String, Object> healthCheck() {
        return Map.of("success", true, "service", "Booking API Service", "status", "Running");
    }
}
