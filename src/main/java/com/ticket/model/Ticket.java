package com.ticket.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "tickets")
public class Ticket {
    @Id
    private String id;
    private String username;
    private String trainName;
    private String source;
    private String destination;
    private String seat;


    private double price;

    public Ticket() {}

    public Ticket(String username, String trainName, String source, String destination) {
        this.username = username;
        this.trainName = trainName;
        this.source = source;
        this.destination = destination;
    }


    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getTrainName() { return trainName; }
    public void setTrainName(String trainName) { this.trainName = trainName; }

    public String getSource() { return source; }
    public void setSource(String source) { this.source = source; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }
    public String getSeat() { return seat; }
    public void setSeat(String seat) { this.seat = seat; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}
