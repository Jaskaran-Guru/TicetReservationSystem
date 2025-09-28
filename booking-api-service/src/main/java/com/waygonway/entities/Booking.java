package com.waygonway.entities;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "bookings")
public class Booking {

    @Id
    private String id;
    private String pnr;
    private String userId;
    private String passengerName;
    private String trainName;
    private String source;
    private String destination;
    private String status;
    private Double totalAmount;
    private String journeyDate;
    private String bookingDate;

    public Booking() {
        this.status = "CONFIRMED";
        this.pnr = "WW" + System.currentTimeMillis();
        this.bookingDate = java.time.LocalDate.now().toString();
    }

    // All getters and setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getPnr() { return pnr; }
    public void setPnr(String pnr) { this.pnr = pnr; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getPassengerName() { return passengerName; }
    public void setPassengerName(String passengerName) { this.passengerName = passengerName; }

    public String getTrainName() { return trainName; }
    public void setTrainName(String trainName) { this.trainName = trainName; }

    public String getSource() { return source; }
    public void setSource(String source) { this.source = source; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(Double totalAmount) { this.totalAmount = totalAmount; }

    public String getJourneyDate() { return journeyDate; }
    public void setJourneyDate(String journeyDate) { this.journeyDate = journeyDate; }

    public String getBookingDate() { return bookingDate; }
    public void setBookingDate(String bookingDate) { this.bookingDate = bookingDate; }
}
