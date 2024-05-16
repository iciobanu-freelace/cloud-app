# Stage 1 build the java app
FROM openjdk:22-slim as base
COPY app/ /usr/src/app
WORKDIR /usr/src/app

# Build the application
RUN ./gradlew bootJar

# Stage 2 run only the java app in a new image
FROM openjdk:22-slim as app_snapshot
COPY --from=base /usr/src/app/ /usr/src/app

# Expose the application port
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "./build/libs/cloud-app-0.0.1-SNAPSHOT.jar"]

# Command for debugging
ENTRYPOINT ["tail", "-f", "/dev/null"]

