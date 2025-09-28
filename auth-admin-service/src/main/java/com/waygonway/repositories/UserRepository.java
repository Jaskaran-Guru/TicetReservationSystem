package com.waygonway.repositories;

import com.waygonway.models.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends MongoRepository<User, String> {

    // Find by username or email (for login)
    Optional<User> findByUsername(String username);
    Optional<User> findByEmail(String email);
    Optional<User> findByUsernameOrEmail(String username, String email);

    // Check if user exists
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);

    // Find by status
    List<User> findByStatus(String status);
    Page<User> findByStatus(String status, Pageable pageable);

    // Find by role
    List<User> findByRole(String role);
    Page<User> findByRole(String role, Pageable pageable);

    // Find by city/state
    @Query("{ 'address.city': ?0 }")
    List<User> findByCity(String city);

    @Query("{ 'address.state': ?0 }")
    List<User> findByState(String state);

    // Search users by multiple criteria
    @Query("{ $or: [ " +
            "{ 'firstName': { $regex: ?0, $options: 'i' } }, " +
            "{ 'lastName': { $regex: ?0, $options: 'i' } }, " +
            "{ 'username': { $regex: ?0, $options: 'i' } }, " +
            "{ 'email': { $regex: ?0, $options: 'i' } }, " +
            "{ 'phone': { $regex: ?0, $options: 'i' } } ] }")
    List<User> searchUsers(String query);

    @Query("{ $or: [ " +
            "{ 'firstName': { $regex: ?0, $options: 'i' } }, " +
            "{ 'lastName': { $regex: ?0, $options: 'i' } }, " +
            "{ 'username': { $regex: ?0, $options: 'i' } }, " +
            "{ 'email': { $regex: ?0, $options: 'i' } }, " +
            "{ 'phone': { $regex: ?0, $options: 'i' } } ] }")
    Page<User> searchUsers(String query, Pageable pageable);

    // Find users created today
    @Query("{ 'createdAt': { $gte: ?0, $lt: ?1 } }")
    List<User> findUsersCreatedBetween(LocalDateTime startDate, LocalDateTime endDate);

    // Count users by status
    long countByStatus(String status);

    // Count users by role
    long countByRole(String role);

    // Find active users
    @Query("{ 'status': 'ACTIVE' }")
    List<User> findActiveUsers();

    // Find users with phone number
    @Query("{ 'phone': { $exists: true, $ne: null } }")
    List<User> findUsersWithPhone();

    // Find users by multiple status
    @Query("{ 'status': { $in: ?0 } }")
    List<User> findByStatusIn(List<String> statuses);

    // Custom aggregation for statistics
    @Query(value = "{ }", count = true)
    long getTotalUserCount();
}
