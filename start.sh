#!/bin/bash

# Mindustry Server Startup Script for Docker
cd /server

# Set host to bind to all interfaces
export HOST=0.0.0.0

# Run server
exec java \
  -Djava.net.preferIPv4Stack=true \
  -Xmx2G \
  -Xms1G \
  -jar server.jar