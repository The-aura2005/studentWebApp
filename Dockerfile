# Stage 1: Build the application using Maven
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
# Copy the pom.xml and source code
COPY pom.xml .

COPY src ./src
# Build the application inside the container
RUN mvn clean package -DskipTests

# Stage 2: Run the application using Java Runtime
FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app
# Copy the compiled jar from the build stage explicitly
COPY --from=build /app/target/StudentWebApp-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
