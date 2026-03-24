@echo off
echo Starting all WaygonWay services...

echo Starting api-gateway on port 8080...
start "API Gateway" java -jar api-gateway/target/api-gateway-1.0.0.jar

echo Starting auth-admin-service on port 8081...
start "Auth Admin Service" java -jar auth-admin-service/target/auth-admin-service-1.0.0.jar

echo Starting booking-api-service on port 8082...
start "Booking API Service" java -jar booking-api-service/target/booking-api-service-1.0.0.jar

echo Starting database-service on port 8083...
start "Database Service" java -jar database-service/target/database-service-1.0.0.jar

echo Starting frontend-service...
cd frontend-service/react-app
start "Frontend" npm run dev
cd ../..

echo All services started in separate windows!
pause
