package com.waygonway.entities;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "events")
public class Event {

    @Id
    private String id;
    private String eventName;
    private String eventCode;
    private String eventType;
    private String source;
    private String destination;
    private Double price;
    private Integer availableSeats;
    private Integer totalSeats;
    private String description;
    private String vehicleNumber;
    private Double basePrice;

    public Event() {}

    // All getters and setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }

    public String getEventCode() { return eventCode; }
    public void setEventCode(String eventCode) { this.eventCode = eventCode; }

    public String getEventType() { return eventType; }
    public void setEventType(String eventType) { this.eventType = eventType; }

    public String getSource() { return source; }
    public void setSource(String source) { this.source = source; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public Integer getAvailableSeats() { return availableSeats; }
    public void setAvailableSeats(Integer availableSeats) { this.availableSeats = availableSeats; }

    public Integer getTotalSeats() { return totalSeats; }
    public void setTotalSeats(Integer totalSeats) { this.totalSeats = totalSeats; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getVehicleNumber() { return vehicleNumber; }
    public void setVehicleNumber(String vehicleNumber) { this.vehicleNumber = vehicleNumber; }

    public Double getBasePrice() { return basePrice; }
    public void setBasePrice(Double basePrice) { this.basePrice = basePrice; }
}
