package com.waygonway.services;

import com.waygonway.entities.Event;
import com.waygonway.entities.Booking;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;
import java.util.*;

@Service
public class TrainBookingService {

    @Autowired
    private MongoTemplate mongoTemplate;

    public Booking createBooking(Map<String, Object> bookingData) {
        System.out.println("📝 MongoDB Save - Booking Data: " + bookingData);

        try {
            Booking booking = new Booking();
            booking.setUserId((String) bookingData.get("userId"));
            booking.setPassengerName((String) bookingData.get("passengerName"));

            // Handle trainName properly
            String trainName = (String) bookingData.get("trainName");
            booking.setTrainName(trainName != null ? trainName : "Express Train");

            // Handle source and destination
            String source = (String) bookingData.get("source");
            String destination = (String) bookingData.get("destination");
            booking.setSource(source != null ? source : "Mumbai");
            booking.setDestination(destination != null ? destination : "Delhi");

            // Handle journey date
            String journeyDate = (String) bookingData.get("journeyDate");
            booking.setJourneyDate(journeyDate != null ? journeyDate : "2025-09-30");

            // Handle totalAmount with proper type conversion
            Object amountObj = bookingData.get("totalAmount");
            Double amount = convertToDouble(amountObj);
            booking.setTotalAmount(amount != null ? amount : 1500.0);

            // Set status as CONFIRMED
            booking.setStatus("CONFIRMED");

            System.out.println("💾 Saving to MongoDB: " + booking.getPnr());

            // Save to MongoDB
            Booking savedBooking = mongoTemplate.save(booking);
            System.out.println("✅ MongoDB Save Success: " + savedBooking.getId());
            System.out.println("📊 Booking Details: " + savedBooking.getPassengerName() + " - " + savedBooking.getPnr());

            return savedBooking;

        } catch (Exception e) {
            System.err.println("❌ MongoDB Save Failed: " + e.getMessage());
            e.printStackTrace();

            // Return error booking
            Booking booking = new Booking();
            booking.setPassengerName((String) bookingData.get("passengerName"));
            booking.setTotalAmount(1500.0);
            booking.setStatus("SAVE_FAILED");
            return booking;
        }
    }

    public Booking getBookingByPNR(String pnr) {
        System.out.println("🔍 MongoDB Query PNR: " + pnr);

        try {
            Query query = new Query(Criteria.where("pnr").is(pnr));
            Booking booking = mongoTemplate.findOne(query, Booking.class);

            if (booking != null) {
                System.out.println("✅ Found in MongoDB: " + booking.getPnr());
                return booking;
            } else {
                System.out.println("⚠️ PNR not found in MongoDB");
                return createSampleBooking(pnr);
            }

        } catch (Exception e) {
            System.err.println("❌ MongoDB Query Error: " + e.getMessage());
            return createSampleBooking(pnr);
        }
    }

    public List<Booking> getUserBookings(String userId) {
        System.out.println("👤 MongoDB Query User: " + userId);

        try {
            Query query = new Query(Criteria.where("userId").is(userId));
            List<Booking> bookings = mongoTemplate.find(query, Booking.class);

            System.out.println("📊 Found " + bookings.size() + " bookings in MongoDB");
            return bookings;

        } catch (Exception e) {
            System.err.println("❌ MongoDB User Query Error: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    public List<Event> searchTrains(String source, String destination) {
        System.out.println("🔍 MongoDB Train Search: " + source + " → " + destination);

        try {
            Query query = new Query();
            query.addCriteria(Criteria.where("source").is(source).and("destination").is(destination));

            List<Event> trains = mongoTemplate.find(query, Event.class);

            if (trains.isEmpty()) {
                System.out.println("⚠️ No trains in MongoDB, creating samples");
                trains = createSampleTrains(source, destination);
                // Save sample trains to MongoDB
                for (Event train : trains) {
                    mongoTemplate.save(train);
                }
                System.out.println("💾 Saved " + trains.size() + " sample trains to MongoDB");
            }

            return trains;
        } catch (Exception e) {
            System.err.println("❌ MongoDB Train Search Error: " + e.getMessage());
            return createSampleTrains(source, destination);
        }
    }

    public List<Event> createDemoData() {
        System.out.println("🚂 Creating demo data in MongoDB");

        List<Event> trains = new ArrayList<>();
        String[] cities = {"Mumbai", "Delhi", "Bangalore", "Chennai", "Pune", "Kolkata", "Hyderabad"};
        String[] trainNames = {"Rajdhani Express", "Shatabdi Express", "Duronto Express", "Deccan Express", "Pragati Express"};

        try {
            for (int i = 0; i < 20; i++) {
                Event train = new Event();
                train.setId(UUID.randomUUID().toString());
                train.setEventName(trainNames[i % trainNames.length]);
                train.setEventCode("12" + String.format("%03d", 100 + i));
                train.setEventType("EXPRESS");
                train.setSource(cities[i % cities.length]);
                train.setDestination(cities[(i + 1) % cities.length]);
                train.setPrice(500.0 + (i * 200));
                train.setAvailableSeats(50 - (i % 25));
                train.setTotalSeats(50);
                train.setDescription("Comfortable journey with modern amenities");
                train.setVehicleNumber("TRN-" + train.getEventCode());
                train.setBasePrice(train.getPrice());

                // Save to MongoDB
                Event savedTrain = mongoTemplate.save(train);
                trains.add(savedTrain);
                System.out.println("💾 Saved train: " + savedTrain.getEventName() + " (ID: " + savedTrain.getId() + ")");
            }

            System.out.println("✅ MongoDB Demo Data Created: " + trains.size() + " trains");
            return trains;

        } catch (Exception e) {
            System.err.println("❌ MongoDB Demo Data Error: " + e.getMessage());
            e.printStackTrace();
            return createSampleTrains("Mumbai", "Delhi");
        }
    }

    public Event getEventById(String id) {
        try {
            Event event = mongoTemplate.findById(id, Event.class);
            if (event != null) {
                System.out.println("✅ Found event in MongoDB: " + event.getEventName());
                return event;
            } else {
                return createSampleEvent(id);
            }
        } catch (Exception e) {
            System.err.println("❌ MongoDB Get Event Error: " + e.getMessage());
            return createSampleEvent(id);
        }
    }

    // Admin Methods
    public List<Event> getAllEvents() {
        try {
            List<Event> allEvents = mongoTemplate.findAll(Event.class);
            System.out.println("📊 Found " + allEvents.size() + " events in database");
            return allEvents;
        } catch (Exception e) {
            System.err.println("❌ Error fetching all events: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    public Event createEvent(Map<String, Object> eventData) {
        try {
            Event newEvent = new Event();
            newEvent.setId(UUID.randomUUID().toString());
            newEvent.setEventName((String) eventData.get("eventName"));
            newEvent.setEventCode((String) eventData.get("eventCode"));
            newEvent.setEventType((String) eventData.get("eventType"));
            newEvent.setSource((String) eventData.get("source"));
            newEvent.setDestination((String) eventData.get("destination"));

            Double price = convertToDouble(eventData.get("price"));
            newEvent.setPrice(price != null ? price : 1000.0);

            Integer availableSeats = (Integer) eventData.get("availableSeats");
            newEvent.setAvailableSeats(availableSeats != null ? availableSeats : 50);

            Integer totalSeats = (Integer) eventData.get("totalSeats");
            newEvent.setTotalSeats(totalSeats != null ? totalSeats : 50);

            newEvent.setDescription((String) eventData.get("description"));
            newEvent.setVehicleNumber((String) eventData.get("vehicleNumber"));
            newEvent.setBasePrice(newEvent.getPrice());

            Event savedEvent = mongoTemplate.save(newEvent);
            System.out.println("✅ Admin created event: " + savedEvent.getEventName());
            return savedEvent;

        } catch (Exception e) {
            System.err.println("❌ Error creating event: " + e.getMessage());
            throw e;
        }
    }

    public Event updateEvent(String id, Map<String, Object> eventData) {
        try {
            Event existingEvent = mongoTemplate.findById(id, Event.class);
            if (existingEvent == null) {
                throw new RuntimeException("Event not found with ID: " + id);
            }

            // Update fields
            if (eventData.containsKey("eventName")) {
                existingEvent.setEventName((String) eventData.get("eventName"));
            }
            if (eventData.containsKey("price")) {
                Double price = convertToDouble(eventData.get("price"));
                existingEvent.setPrice(price);
                existingEvent.setBasePrice(price);
            }
            if (eventData.containsKey("availableSeats")) {
                existingEvent.setAvailableSeats((Integer) eventData.get("availableSeats"));
            }
            if (eventData.containsKey("totalSeats")) {
                existingEvent.setTotalSeats((Integer) eventData.get("totalSeats"));
            }
            if (eventData.containsKey("description")) {
                existingEvent.setDescription((String) eventData.get("description"));
            }
            if (eventData.containsKey("eventType")) {
                existingEvent.setEventType((String) eventData.get("eventType"));
            }

            Event updatedEvent = mongoTemplate.save(existingEvent);
            System.out.println("✅ Admin updated event: " + updatedEvent.getEventName());
            return updatedEvent;

        } catch (Exception e) {
            System.err.println("❌ Error updating event: " + e.getMessage());
            throw e;
        }
    }

    public boolean deleteEvent(String id) {
        try {
            Event existingEvent = mongoTemplate.findById(id, Event.class);
            if (existingEvent == null) {
                return false;
            }

            mongoTemplate.remove(existingEvent);
            System.out.println("✅ Admin deleted event: " + existingEvent.getEventName());
            return true;

        } catch (Exception e) {
            System.err.println("❌ Error deleting event: " + e.getMessage());
            return false;
        }
    }

    public Event updateEventAvailability(String id, int availableSeats) {
        try {
            Event existingEvent = mongoTemplate.findById(id, Event.class);
            if (existingEvent == null) {
                throw new RuntimeException("Event not found");
            }

            existingEvent.setAvailableSeats(availableSeats);
            Event updatedEvent = mongoTemplate.save(existingEvent);

            System.out.println("✅ Updated availability for " + updatedEvent.getEventName() + " to " + availableSeats);
            return updatedEvent;

        } catch (Exception e) {
            System.err.println("❌ Error updating availability: " + e.getMessage());
            throw e;
        }
    }

    // MongoDB Status Check
    public Map<String, Object> getDebugInfo() {
        try {
            long bookingCount = mongoTemplate.count(new Query(), Booking.class);
            long eventCount = mongoTemplate.count(new Query(), Event.class);

            return Map.of(
                    "mongoConnected", true,
                    "totalBookings", bookingCount,
                    "totalEvents", eventCount,
                    "collections", Arrays.asList("bookings", "events")
            );
        } catch (Exception e) {
            return Map.of(
                    "mongoConnected", false,
                    "error", e.getMessage()
            );
        }
    }

    // Helper method for proper type conversion
    private Double convertToDouble(Object obj) {
        if (obj == null) return null;

        if (obj instanceof Double) {
            return (Double) obj;
        } else if (obj instanceof Integer) {
            return ((Integer) obj).doubleValue();
        } else if (obj instanceof Long) {
            return ((Long) obj).doubleValue();
        } else if (obj instanceof Float) {
            return ((Float) obj).doubleValue();
        } else if (obj instanceof String) {
            try {
                return Double.parseDouble((String) obj);
            } catch (NumberFormatException e) {
                System.err.println("⚠️ Could not parse amount: " + obj);
                return null;
            }
        }

        System.err.println("⚠️ Unknown amount type: " + obj.getClass().getSimpleName());
        return null;
    }

    // Helper methods
    private List<Event> createSampleTrains(String source, String destination) {
        List<Event> trains = new ArrayList<>();

        for (int i = 1; i <= 3; i++) {
            Event train = new Event();
            train.setId(UUID.randomUUID().toString());
            train.setEventName("Express Train " + i);
            train.setEventCode("1200" + i);
            train.setEventType("EXPRESS");
            train.setSource(source);
            train.setDestination(destination);
            train.setPrice(400.0 + (i * 100));
            train.setAvailableSeats(30 + i);
            train.setTotalSeats(50);
            train.setDescription("Fast express service");
            train.setVehicleNumber("TRN-1200" + i);
            train.setBasePrice(train.getPrice());
            trains.add(train);
        }

        return trains;
    }

    private Booking createSampleBooking(String pnr) {
        Booking booking = new Booking();
        booking.setPnr(pnr);
        booking.setPassengerName("Demo Passenger");
        booking.setTrainName("Demo Express");
        booking.setSource("Delhi");
        booking.setDestination("Mumbai");
        booking.setTotalAmount(2500.0);
        booking.setJourneyDate("2025-09-30");
        return booking;
    }

    private Event createSampleEvent(String id) {
        Event event = new Event();
        event.setId(id);
        event.setEventName("Sample Train");
        event.setEventCode("12345");
        event.setEventType("EXPRESS");
        event.setSource("Delhi");
        event.setDestination("Mumbai");
        event.setPrice(1000.0);
        event.setAvailableSeats(25);
        event.setTotalSeats(50);
        event.setDescription("Sample train service");
        event.setVehicleNumber("TRN-12345");
        event.setBasePrice(1000.0);
        return event;
    }
}
