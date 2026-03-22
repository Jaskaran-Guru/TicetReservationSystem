package com.waygonway.repositories;

import com.waygonway.entities.TransportSchedule;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TransportScheduleRepository extends MongoRepository<TransportSchedule, String> {
    List<TransportSchedule> findByType(String type);
    List<TransportSchedule> findBySourceAndDestination(String source, String destination);
    List<TransportSchedule> findByTypeAndSourceAndDestination(String type, String source, String destination);
}
