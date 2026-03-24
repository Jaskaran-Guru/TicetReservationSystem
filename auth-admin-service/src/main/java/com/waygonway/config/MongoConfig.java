package com.waygonway.config;

import com.mongodb.ConnectionString;
import com.mongodb.MongoClientSettings;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.config.AbstractMongoClientConfiguration;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.convert.DefaultMongoTypeMapper;
import org.springframework.data.mongodb.core.convert.MappingMongoConverter;
import jakarta.annotation.PostConstruct; // ✅ FIXED: jakarta instead of javax
import java.util.concurrent.TimeUnit;

@Configuration
public class MongoConfig extends AbstractMongoClientConfiguration {

    @Value("${spring.data.mongodb.uri:mongodb://localhost:27017/waygonway_db}")
    private String connectionString;

    @Override
    protected String getDatabaseName() {
        return "waygonway_db";
    }

    @Bean
    @Override
    public MongoClient mongoClient() {
        System.out.println("🗄️ MongoConfig: Configuring MongoDB client");
        System.out.println("🔗 Connection String: " + connectionString);

        ConnectionString connString = new ConnectionString(connectionString);

        MongoClientSettings settings = MongoClientSettings.builder()
                .applyConnectionString(connString)
                .applyToConnectionPoolSettings(builder ->
                        builder.maxSize(100)
                                .minSize(5)
                                .maxWaitTime(30, TimeUnit.SECONDS)
                                .maxConnectionLifeTime(30, TimeUnit.MINUTES))
                .applyToSocketSettings(builder ->
                        builder.connectTimeout(10, TimeUnit.SECONDS)
                                .readTimeout(10, TimeUnit.SECONDS))
                .build();

        MongoClient client = MongoClients.create(settings);
        System.out.println("✅ MongoConfig: MongoDB client configured successfully");

        return client;
    }

    @Bean
    public MongoTemplate mongoTemplate() {
        System.out.println("🗄️ MongoConfig: Creating MongoTemplate");

        MongoTemplate template = new MongoTemplate(mongoClient(), getDatabaseName());

        // Remove _class field from documents
        MappingMongoConverter converter = (MappingMongoConverter) template.getConverter();
        converter.setTypeMapper(new DefaultMongoTypeMapper(null));

        System.out.println("✅ MongoConfig: MongoTemplate created successfully");
        return template;
    }

    @PostConstruct // ✅ NOW WORKS
    public void init() {
        System.out.println("🗄️ MongoConfig: Initializing MongoDB configuration");
        System.out.println("📊 Database: " + getDatabaseName());
        System.out.println("🔗 URI: " + connectionString);

        try {
            // Test connection
            mongoClient().getDatabase(getDatabaseName()).runCommand(org.bson.Document.parse("{ ping: 1 }"));
            System.out.println("✅ MongoConfig: Database connection successful");
        } catch (Exception e) {
            System.err.println("❌ MongoConfig: Database connection failed - " + e.getMessage());
        }
    }

    @Override
    protected boolean autoIndexCreation() {
        return true;
    }
}
