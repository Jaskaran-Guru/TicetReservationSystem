package com.waygonway.repositories;

import com.waygonway.entities.TransportBooking;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface TransportBookingRepository extends MongoRepository<TransportBooking, String> {
    Optional<TransportBooking> findByPnr(String pnr);
    List<TransportBooking> findByUserId(String userId);
}
