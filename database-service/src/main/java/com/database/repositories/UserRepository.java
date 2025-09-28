package com.database.repositories;

import com.database.models.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends MongoRepository<User, String> {

    // Find by username or email
    Optional<User> findByUsername(String username);
    Optional<User> findByEmail(String email);
    Optional<User> findByUsernameOrEmail(String username, String email);

    // Check existence
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);

    // Find by status
    List<User> findByStatus(String status);

    // Find by role
    List<User> findByRole(String role);

    // Find active users
    @Query("{ 'status': 'ACTIVE' }")
    List<User> findActiveUsers();

    // Count users by status
    long countByStatus(String status);

    // Find users created between dates
    @Query("{ 'createdAt': { $gte: ?0, $lte: ?1 } }")
    List<User> findUsersCreatedBetween(LocalDateTime startDate, LocalDateTime endDate);

    // Search users
    @Query("{ $or: [ " +
            "{ 'firstName': { $regex: ?0, $options: 'i' } }, " +
            "{ 'lastName': { $regex: ?0, $options: 'i' } }, " +
            "{ 'username': { $regex: ?0, $options: 'i' } }, " +
            "{ 'email': { $regex: ?0, $options: 'i' } } ] }")
    List<User> searchUsers(String query);
}
