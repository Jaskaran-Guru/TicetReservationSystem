# Stage 1: Build
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY database-service/pom.xml database-service/
COPY shared-config/pom.xml shared-config/
RUN mvn dependency:go-offline -B
COPY database-service/src database-service/src
COPY shared-config/src shared-config/src
RUN mvn package -pl database-service -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/database-service/target/database-service-1.0.0.jar app.jar
EXPOSE 8083
ENTRYPOINT ["java", "-jar", "app.jar"]
