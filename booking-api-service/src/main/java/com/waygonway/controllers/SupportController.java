package com.waygonway.controllers;

import com.waygonway.entities.SupportTicket;
import com.waygonway.repositories.SupportTicketRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/v1/support")
@CrossOrigin(origins = "*")
public class SupportController {

    @Autowired
    private SupportTicketRepository supportTicketRepository;

    @PostMapping
    public Map<String, Object> createTicket(@RequestBody SupportTicket ticket) {
        ticket.setStatus("OPEN");
        ticket.setCreatedAt(LocalDateTime.now());
        SupportTicket saved = supportTicketRepository.save(ticket);
        return Map.of("success", true, "data", saved);
    }

    @GetMapping("/user/{userId}")
    public Map<String, Object> getUserTickets(@PathVariable String userId) {
        List<SupportTicket> tickets = supportTicketRepository.findByUserId(userId);
        return Map.of("success", true, "data", tickets);
    }

    @GetMapping("/admin/all")
    public Map<String, Object> getAllTickets() {
        return Map.of("success", true, "data", supportTicketRepository.findAll());
    }

    @PutMapping("/admin/resolve/{id}")
    public Map<String, Object> resolveTicket(@PathVariable String id, @RequestBody Map<String, String> payload) {
        Optional<SupportTicket> opt = supportTicketRepository.findById(id);
        if (opt.isEmpty()) {
            return Map.of("success", false, "error", "Ticket not found");
        }
        SupportTicket ticket = opt.get();
        ticket.setStatus("RESOLVED");
        ticket.setResolutionNotes(payload.get("resolutionNotes"));
        ticket.setResolvedAt(LocalDateTime.now());
        
        return Map.of("success", true, "data", supportTicketRepository.save(ticket));
    }
}
