# Stage 1: Build
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY booking-api-service/pom.xml booking-api-service/
COPY shared-config/pom.xml shared-config/
RUN mvn dependency:go-offline -B
COPY booking-api-service/src booking-api-service/src
COPY shared-config/src shared-config/src
RUN mvn package -pl booking-api-service -DskipTests

# Stage 2: Runtime
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/booking-api-service/target/booking-api-service-1.0.0.jar app.jar
EXPOSE 8082
ENTRYPOINT ["java", "-jar", "app.jar"]
