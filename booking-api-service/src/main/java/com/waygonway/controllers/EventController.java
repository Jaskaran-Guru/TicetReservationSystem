package com.waygonway.controllers;

import com.waygonway.entities.Event;
import com.waygonway.repositories.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/events")
@CrossOrigin(origins = "*")
public class EventController {

    @Autowired
    private EventRepository eventRepository;

    @GetMapping("/paged")
    public Page<Event> getEventsPaged(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String category) {
        Pageable pageable = PageRequest.of(page, size);
        if (category != null && !category.isEmpty()) {
            return eventRepository.findByCategory(category, pageable);
        }
        return eventRepository.findAll(pageable);
    }

    @GetMapping
    @Cacheable(value = "eventsCache")
    public List<Event> getAllEvents() {
        return eventRepository.findAll();
    }

    @GetMapping("/category/{category}")
    @Cacheable(value = "eventsCache", key = "#category")
    public List<Event> getEventsByCategory(@PathVariable String category) {
        return eventRepository.findByCategory(category);
    }

    @GetMapping("/location/{location}")
    @Cacheable(value = "eventsCache", key = "#location")
    public List<Event> getEventsByLocation(@PathVariable String location) {
        return eventRepository.findByLocation(location);
    }

    @GetMapping("/{id}")
    public Event getEventById(@PathVariable String id) {
        return eventRepository.findById(id).orElseThrow(() -> new RuntimeException("Event not found"));
    }
}
