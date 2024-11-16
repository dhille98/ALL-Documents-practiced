## now try to spring petclinic application

* this java application 
* clont the code 
* `git clone https://github.com/dhille98/spring-petclinic.git`
* write docker file
```Docker
# Stage 1: Build the Spring Boot application
FROM maven:3.9.9-amazoncorretto-17 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and install dependencies
COPY pom.xml .
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# Stage 2: Create the final image
FROM openjdk:17-jdk-alpine

# Set the working directory in the final image
WORKDIR /app

# Copy the jar file from the build stage to the final image
COPY --from=build /app/target/*.jar ./my-spring-boot-app.jar

# Expose the port the Spring Boot app will run on
EXPOSE 8080

# Run the jar file
ENTRYPOINT ["java", "-jar", "/app/my-spring-boot-app.jar"]

```

