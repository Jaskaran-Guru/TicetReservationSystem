package com.ticket.controller;

import com.ticket.model.Ticket;
import com.ticket.repository.TicketRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/tickets")
@CrossOrigin(origins = "*")
public class TicketController {

    @Autowired
    private TicketRepository ticketRepository;


    @GetMapping("/user/{username}")
    public List<Ticket> getTicketsByUser(@PathVariable String username) {
        return ticketRepository.findByUsername(username);
    }


    @PostMapping
    public Ticket addTicket(@RequestBody Ticket ticket) {
        return ticketRepository.save(ticket);
    }


    @PutMapping("/{id}")
    public ResponseEntity<Ticket> updateTicket(@PathVariable String id, @RequestBody Ticket ticketDetails) {
        Optional<Ticket> optionalTicket = ticketRepository.findById(id);
        if (optionalTicket.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        Ticket ticket = optionalTicket.get();
        ticket.setTrainName(ticketDetails.getTrainName());
        ticket.setSource(ticketDetails.getSource());
        ticket.setDestination(ticketDetails.getDestination());

        Ticket updatedTicket = ticketRepository.save(ticket);
        return ResponseEntity.ok(updatedTicket);
    }

    @PostMapping("/book")
    public ResponseEntity<?> bookTicket(@RequestBody Ticket ticketRequest) {
        Ticket ticket = new Ticket();
        ticket.setUsername(ticketRequest.getUsername());
        ticket.setSeat(ticketRequest.getSeat());


        ticket.setPrice(200.0);

        ticketRepository.save(ticket);
        return ResponseEntity.ok("Ticket booked with price: " + ticket.getPrice());
    }



    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteTicket(@PathVariable String id) {
        if (!ticketRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        ticketRepository.deleteById(id);
        return ResponseEntity.ok().build();
    }


    @GetMapping
    public List<Ticket> getAllTickets() {
        return ticketRepository.findAll();
    }





    }


