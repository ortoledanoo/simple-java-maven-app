# Use an official Maven image as the build stage
FROM maven:3.9.4-openjdk-11 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the source code to the container
COPY . .

# Build the Maven project and package the JAR
RUN mvn clean package

# Use a lightweight base image for running the application
FROM openjdk:11-jre-slim

# Set the working directory for the runtime container
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=builder /app/target/*.jar app.jar

# Define the entry point for the application
ENTRYPOINT ["java", "-jar", "app.jar"]
