# Use a compatible Maven version as the build stage
FROM maven:3.9.4-openjdk-11 AS builder

WORKDIR /app

# Copy source code into the container
COPY . .

# Build the Maven project
RUN mvn clean package

# Use a lightweight runtime image for the application
FROM openjdk:11-jre-slim

WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Set the entry point for the application
ENTRYPOINT ["java", "-jar", "app.jar"]
