#!/bin/bash

# Mindustry Server Startup Script
cd /server

# Run server with proper arguments
exec java \
  -Djava.net.preferIPv4Stack=true \
  -Djava.net.preferIPv4Addresses=true \
  -Xmx2G \
  -Xms1G \
  -jar server.jar \
  -port 6567