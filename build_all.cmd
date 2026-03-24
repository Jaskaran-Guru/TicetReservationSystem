@echo off
echo Building all WaygonWay services...

echo Building api-gateway...
call mvn clean package -pl api-gateway -DskipTests

echo Building auth-admin-service...
call mvn clean package -pl auth-admin-service -DskipTests

echo Building booking-api-service...
call mvn clean package -pl booking-api-service -DskipTests

echo Building database-service...
call mvn clean package -pl database-service -DskipTests

echo Building frontend-service...
cd frontend-service/react-app
call npm install
call npm run build
echo Copying frontend to api-gateway...
if not exist "..\..\api-gateway\src\main\resources\static" mkdir "..\..\api-gateway\src\main\resources\static"
powershell -Command "Remove-Item -Path '..\..\api-gateway\src\main\resources\static\*' -Force -Recurse -ErrorAction SilentlyContinue"
xcopy /E /I /Y "dist\*" "..\..\api-gateway\src\main\resources\static\"
cd ../..

echo All services built and frontend integrated!
pause
