#!/bin/bash

# Mindustry Server Startup Script for Docker
cd /server

# Set headless mode explicitly
export HEADLESS=true

# Run server with all necessary arguments
exec java \
  -Djava.net.preferIPv4Stack=true \
  -Djava.net.preferIPv4Addresses=true \
  -Xmx2G \
  -Xms1G \
  -jar server.jar \
  -port 6567 \
  -mode attack \
  -map attack