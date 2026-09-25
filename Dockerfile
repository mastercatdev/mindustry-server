# Mindustry Server Dockerfile for Railway
# Uses Java 17 (required for Mindustry server v143+)

FROM eclipse-temurin:17-jre-jammy

# Install wget
RUN apt-get update && apt-get install -y wget

# Create server directory
RUN mkdir -p /server
WORKDIR /server

# Download server
RUN wget -O server.jar https://github.com/Anuken/Mindustry/releases/latest/download/server-release.jar || \
    wget -O server.jar https://github.com/Anuken/Mindustry/releases/download/v143/server-release.jar

# Copy all files
COPY server.properties /server/
COPY start.sh /server/

# Make startup script executable
RUN chmod +x /server/start.sh

# Expose port
EXPOSE 6567

# Run the startup script
CMD ["/server/start.sh"]