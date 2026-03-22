package com.waygonway.controllers;

import com.waygonway.entities.Event;
import com.waygonway.repositories.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/admin/events")
@CrossOrigin(origins = "*")
public class AdminEventController {

    @Autowired
    private EventRepository eventRepository;

    @GetMapping("/paged")
    public Page<Event> getEventsPaged(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        return eventRepository.findAll(pageable);
    }

    @PostMapping
    public Event createEvent(@RequestBody Event event) {
        return eventRepository.save(event);
    }

    @PutMapping("/{id}")
    public Event updateEvent(@PathVariable String id, @RequestBody Event eventDetails) {
        Event event = eventRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Event not found"));
        
        event.setEventName(eventDetails.getEventName());
        event.setCategory(eventDetails.getCategory());
        event.setVenue(eventDetails.getVenue());
        event.setLocation(eventDetails.getLocation());
        event.setDescription(eventDetails.getDescription());
        event.setBasePrice(eventDetails.getBasePrice());
        event.setAvailableSeats(eventDetails.getAvailableSeats());
        event.setTotalSeats(eventDetails.getTotalSeats());
        event.setStartDateTime(eventDetails.getStartDateTime());
        event.setEndDateTime(eventDetails.getEndDateTime());
        
        return eventRepository.save(event);
    }

    @DeleteMapping("/{id}")
    public Map<String, Boolean> deleteEvent(@PathVariable String id) {
        Event event = eventRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Event not found"));
        
        eventRepository.delete(event);
        return Map.of("deleted", true);
    }

    @PostMapping("/seed")
    public Map<String, Object> seedDemoData() {
        eventRepository.deleteAll();

        Event movie = new Event();
        movie.setEventName("Inception: Special Screening");
        movie.setCategory("Movies");
        movie.setVenue("Grand Cinema Hall");
        movie.setLocation("Los Angeles");
        movie.setDescription("Experience Christopher Nolan's masterpiece on the big screen once again.");
        movie.setBasePrice(15.0);
        movie.setTotalSeats(100);
        movie.setAvailableSeats(85);
        movie.setStartDateTime(LocalDateTime.now().plusDays(2).withHour(20).withMinute(0));

        Event concert = new Event();
        concert.setEventName("The Midnight Echo - Live");
        concert.setCategory("Concerts");
        concert.setVenue("Starlight Arena");
        concert.setLocation("New York");
        concert.setDescription("A night of synth-pop and neon vibes.");
        concert.setBasePrice(45.0);
        concert.setTotalSeats(500);
        concert.setAvailableSeats(120);
        concert.setStartDateTime(LocalDateTime.now().plusDays(5).withHour(21).withMinute(0));

        Event comedy = new Event();
        comedy.setEventName("Laugh Out Loud: Comedy Night");
        comedy.setCategory("Comedy");
        comedy.setVenue("The Joker's Den");
        comedy.setLocation("Chicago");
        comedy.setDescription("Five top-tier comedians, one hilarious night.");
        comedy.setBasePrice(25.0);
        comedy.setTotalSeats(80);
        comedy.setAvailableSeats(40);
        comedy.setStartDateTime(LocalDateTime.now().plusDays(3).withHour(19).withMinute(30));

        eventRepository.saveAll(List.of(movie, concert, comedy));

        return Map.of("success", true, "message", "Demo data seeded successfully");
    }
}
