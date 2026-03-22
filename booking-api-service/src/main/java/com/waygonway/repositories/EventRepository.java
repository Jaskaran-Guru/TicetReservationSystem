package com.waygonway.repositories;

import com.waygonway.entities.Event;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface EventRepository extends MongoRepository<Event, String> {
    List<Event> findByCategory(String category);
    Page<Event> findByCategory(String category, Pageable pageable);
    List<Event> findByLocation(String location);
    List<Event> findByOrganizerId(String organizerId);
}
