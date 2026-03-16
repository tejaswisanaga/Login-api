FROM openjdk:17-jdk-slim

WORKDIR /app

COPY target/login-api-0.0.1-SNAPSHOT.jar app.jar

EXPOSE $PORT

CMD ["java", "-jar", "app.jar"]
