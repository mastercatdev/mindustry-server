# Mindustry Server Dockerfile for Render
# Uses OpenJDK 8 (required for Mindustry server compatibility)
# All files in root, no subdirectories

FROM adoptopenjdk:8-jre-hotspot

# Install wget for downloading the server
RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

# Create server directory
RUN mkdir -p /server
WORKDIR /server

# Download Mindustry server (latest stable version)
RUN wget -O server.jar https://github.com/Anuken/Mindustry/releases/download/v143/server-release.jar

# Copy all configuration files to /server/
COPY server.properties /server/
COPY map.properties /server/map.properties
COPY map.json /server/map.json
COPY adminlist.txt /server/
COPY banlist.txt /server/

# Expose the Mindustry server port
EXPOSE 6567

# Run the server with attack mode and custom map
CMD ["java", "-Xmx2G", "-Xms1G", "-jar", "server.jar", "-port", "6567", "-mode", "attack", "-map", "attack-complex"]