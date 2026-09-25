# Mindustry Server Dockerfile for Railway
# Headless mode for Docker

FROM eclipse-temurin:8-jre-jammy

# Install wget
RUN apt-get update && apt-get install -y wget

# Create server directory
RUN mkdir -p /server
WORKDIR /server

# Download server
RUN wget -O server.jar https://github.com/Anuken/Mindustry/releases/latest/download/server-release.jar || \
    wget -O server.jar https://github.com/Anuken/Mindustry/releases/download/v143/server-release.jar

# Copy config
COPY server.properties /server/

# Expose port
EXPOSE 6567

# Run server in headless mode
CMD ["java", "-Djava.net.preferIPv4Stack=true", "-Djava.net.preferIPv4Addresses=true", "-Xmx2G", "-jar", "server.jar", "-port", "6567"]