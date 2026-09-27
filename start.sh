#!/bin/sh
# Container entrypoint: installs maps + rules into the data folder, then starts hosting.
set -e
cd /server

SERVER_NAME="${SERVER_NAME:-Attack Server}"
SERVER_DESC="${SERVER_DESC:-Attack mode vs a big enemy base. Calm start - build up first!}"
START_MAP="${START_MAP:-Overgrowth}"
JAVA_OPTS="${JAVA_OPTS:--Xmx2g}"

mkdir -p config/maps
cp -f maps/*.msav config/maps/
# rules.hjson from the repo always wins; edit it there and rebuild to change rules
cp -f rules.hjson config/rules.hjson

# Startup commands are comma-separated (so no commas inside the name/description)
exec java $JAVA_OPTS -jar server.jar \
  "config name $SERVER_NAME,config desc $SERVER_DESC,config autoPause true,shuffle custom,host $START_MAP attack"
