package com.waygonway.repositories;

import com.waygonway.entities.Booking;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface BookingRepository extends MongoRepository<Booking, String> {
    Optional<Booking> findByPnr(String pnr);
    List<Booking> findByUserId(String userId);
    List<Booking> findByEventIdIn(List<String> eventIds);
}
