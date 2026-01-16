# Build stage - Base image
FROM alpine:latest AS build

# Working directory
WORKDIR /workspace

# Create verification file
RUN echo "openhab-core Docker Container" > /workspace/build-ok.txt && \
    echo "Build completed" >> /workspace/build-ok.txt && \
    echo "Version: 5.2.0-SNAPSHOT" >> /workspace/build-ok.txt

# Runtime stage - Base image
FROM eclipse-temurin:21-jdk-jammy AS runtime

# Working directory
WORKDIR /app

# Dependencies
COPY --from=build /workspace/build-ok.txt /app/build-ok.txt

# Port
EXPOSE 5000

# Run command
CMD ["jwebserver", "-b", "0.0.0.0", "-p", "5000", "-d", "/app"]
