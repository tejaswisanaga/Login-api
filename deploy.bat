@echo off
echo Building and deploying Login API...
echo.

echo Cleaning previous build...
call mvn clean

echo Building application...
call mvn package -DskipTests

echo.
echo Application built successfully!
echo.
echo To run the application:
echo java -jar target/login-api-0.0.1-SNAPSHOT.jar
echo.
echo To run with production profile:
echo java -jar target/login-api-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
echo.
echo Your API will be available at: http://0.0.0.0:8081
echo.
pause
