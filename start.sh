#!/bin/bash

# Mindustry Server Startup Script for Docker
cd /server

# Run server with all necessary arguments
exec java \
  -Xmx2G \
  -Xms1G \
  -jar server.jar \
  -port 6567 \
  -mode attack \
  -map attack