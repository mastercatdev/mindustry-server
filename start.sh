#!/bin/bash

# Mindustry Server Startup Script for Docker
# Note: Mindustry server reads ALL settings from server.properties
# Do NOT pass command-line arguments - they cause errors

cd /server

exec java \
  -Xmx2G \
  -Xms1G \
  -jar server.jar