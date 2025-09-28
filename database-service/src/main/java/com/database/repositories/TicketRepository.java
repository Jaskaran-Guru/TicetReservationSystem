package com.database.repositories;

import com.database.models.Ticket;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface TicketRepository extends MongoRepository<Ticket, String> {

    // Find by PNR
    Optional<Ticket> findByPnr(String pnr);

    // Find tickets by user ID
    List<Ticket> findByUserId(String userId);
    Page<Ticket> findByUserId(String userId, Pageable pageable);

    // Find tickets by train ID
    List<Ticket> findByTrainId(String trainId);

    // Find tickets by booking status
    List<Ticket> findByBookingStatus(String bookingStatus);

    // Find tickets by payment status
    List<Ticket> findByPaymentStatus(String paymentStatus);

    // Find tickets by user and status
    List<Ticket> findByUserIdAndBookingStatus(String userId, String bookingStatus);

    // Find tickets by booking date range
    @Query("{ 'bookingDate': { $gte: ?0, $lte: ?1 } }")
    List<Ticket> findByBookingDateBetween(LocalDateTime startDate, LocalDateTime endDate);

    // Find tickets by travel date range
    @Query("{ 'travelDate': { $gte: ?0, $lte: ?1 } }")
    List<Ticket> findByTravelDateBetween(LocalDateTime startDate, LocalDateTime endDate);

    // Find tickets booked today
    @Query("{ 'bookingDate': { $gte: ?0, $lt: ?1 } }")
    List<Ticket> findTicketsBookedToday(LocalDateTime startOfDay, LocalDateTime endOfDay);

    // Find upcoming tickets for user
    @Query("{ 'userId': ?0, 'travelDate': { $gte: ?1 }, 'bookingStatus': 'CONFIRMED' }")
    List<Ticket> findUpcomingTicketsForUser(String userId, LocalDateTime currentTime);

    // Find past tickets for user
    @Query("{ 'userId': ?0, 'travelDate': { $lt: ?1 } }")
    List<Ticket> findPastTicketsForUser(String userId, LocalDateTime currentTime);

    // Find confirmed tickets
    @Query("{ 'bookingStatus': 'CONFIRMED' }")
    List<Ticket> findConfirmedTickets();

    // Find cancelled tickets
    @Query("{ 'bookingStatus': 'CANCELLED' }")
    List<Ticket> findCancelledTickets();

    // Count tickets by status
    long countByBookingStatus(String bookingStatus);

    // Count tickets by user
    long countByUserId(String userId);

    // Find tickets by train number
    List<Ticket> findByTrainNumber(String trainNumber);

    // Find tickets by route
    @Query("{ 'sourceStation': ?0, 'destinationStation': ?1 }")
    List<Ticket> findByRoute(String source, String destination);

    // Find tickets with total amount greater than
    @Query("{ 'totalAmount': { $gte: ?0 } }")
    List<Ticket> findTicketsWithAmountGreaterThan(double amount);

    // Search tickets by PNR pattern
    @Query("{ 'pnr': { $regex: ?0, $options: 'i' } }")
    List<Ticket> findByPnrContaining(String pnrPattern);

    // Find tickets by user and date range
    @Query("{ 'userId': ?0, 'travelDate': { $gte: ?1, $lte: ?2 } }")
    List<Ticket> findByUserIdAndTravelDateBetween(String userId, LocalDateTime startDate, LocalDateTime endDate);

    // Revenue calculation query
    @Query("{ 'bookingStatus': 'CONFIRMED', 'paymentStatus': 'PAID' }")
    List<Ticket> findPaidConfirmedTickets();
}
