package com.waygonway.config;

import com.waygonway.models.User;
import com.waygonway.repositories.UserRepository;
import com.waygonway.utils.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordUtil passwordUtil;

    @Override
    public void run(String... args) throws Exception {
        System.out.println("🗄️ DataInitializer: Checking for initial data...");

        // Create admin user if not exists
        if (!userRepository.existsByUsername("admin")) {
            System.out.println("👑 DataInitializer: Creating default admin user");

            User admin = new User();
            admin.setUsername("admin");
            admin.setEmail("admin@waygonway.com");
            admin.setPassword(passwordUtil.hashPassword("admin123"));
            admin.setFirstName("System");
            admin.setLastName("Administrator");
            admin.setPhone("9999999999");
            admin.setRole("ADMIN");
            admin.setStatus("ACTIVE");

            // Set address
            User.Address address = new User.Address();
            address.setCity("New Delhi");
            address.setState("Delhi");
            address.setCountry("India");
            address.setZipCode("110001");
            admin.setAddress(address);

            userRepository.save(admin);
            System.out.println("✅ DataInitializer: Default admin user created");
        }

        // Create demo user if not exists
        if (!userRepository.existsByUsername("user")) {
            System.out.println("👤 DataInitializer: Creating demo user");

            User user = new User();
            user.setUsername("user");
            user.setEmail("user@waygonway.com");
            user.setPassword(passwordUtil.hashPassword("user123"));
            user.setFirstName("Demo");
            user.setLastName("User");
            user.setPhone("8888888888");
            user.setRole("USER");
            user.setStatus("ACTIVE");

            // Set address
            User.Address address = new User.Address();
            address.setCity("Mumbai");
            address.setState("Maharashtra");
            address.setCountry("India");
            address.setZipCode("400001");
            user.setAddress(address);

            userRepository.save(user);
            System.out.println("✅ DataInitializer: Demo user created");
        }

        long userCount = userRepository.count();
        System.out.println("📊 DataInitializer: Total users in database: " + userCount);
        System.out.println("✅ DataInitializer: Initial data setup completed");
    }
}
