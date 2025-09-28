package com.database.repositories;

import com.database.models.Train;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface TrainRepository extends MongoRepository<Train, String> {

    // Find by train number
    Optional<Train> findByTrainNumber(String trainNumber);

    // Find trains by source and destination
    List<Train> findBySourceAndDestination(String source, String destination);
    Page<Train> findBySourceAndDestination(String source, String destination, Pageable pageable);

    // Find trains by source
    List<Train> findBySource(String source);

    // Find trains by destination
    List<Train> findByDestination(String destination);

    // Find trains by status
    List<Train> findByStatus(String status);

    // Find active trains
    @Query("{ 'status': 'ACTIVE' }")
    List<Train> findActiveTrains();

    // Find trains with available seats
    @Query("{ 'availableSeats': { $gt: 0 }, 'status': 'ACTIVE' }")
    List<Train> findTrainsWithAvailableSeats();

    // Find trains by departure time range
    @Query("{ 'departureTime': { $gte: ?0, $lte: ?1 } }")
    List<Train> findByDepartureTimeBetween(LocalDateTime startTime, LocalDateTime endTime);

    // Find trains by price range
    @Query("{ 'price': { $gte: ?0, $lte: ?1 } }")
    List<Train> findByPriceRange(double minPrice, double maxPrice);

    // Search trains by name
    @Query("{ 'trainName': { $regex: ?0, $options: 'i' } }")
    List<Train> findByTrainNameContaining(String trainName);

    // Find trains by route (source and destination with available seats)
    @Query("{ 'source': ?0, 'destination': ?1, 'availableSeats': { $gt: 0 }, 'status': 'ACTIVE' }")
    List<Train> findAvailableTrainsByRoute(String source, String destination);

    // Find trains departing today
    @Query("{ 'departureTime': { $gte: ?0, $lt: ?1 } }")
    List<Train> findTrainsDepartingToday(LocalDateTime startOfDay, LocalDateTime endOfDay);

    // Count trains by status
    long countByStatus(String status);

    // Count active trains
    @Query(value = "{ 'status': 'ACTIVE' }", count = true)
    long countActiveTrains();

    // Find trains by train type
    List<Train> findByTrainType(String trainType);

    // Find trains with specific stoppage
    @Query("{ 'stoppages': { $in: [?0] } }")
    List<Train> findTrainsWithStoppage(String stoppage);

    // Complex search query
    @Query("{ $or: [ " +
            "{ 'trainName': { $regex: ?0, $options: 'i' } }, " +
            "{ 'trainNumber': { $regex: ?0, $options: 'i' } }, " +
            "{ 'source': { $regex: ?0, $options: 'i' } }, " +
            "{ 'destination': { $regex: ?0, $options: 'i' } } ] }")
    List<Train> searchTrains(String query);
}
