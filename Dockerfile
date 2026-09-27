# Mindustry dedicated server (attack mode) - built for an Oracle Cloud VM.
# Works on both ARM (Ampere A1) and x86 (E2.1.Micro) instances.

FROM eclipse-temurin:17-jre-jammy

# Must match the game version players use (Mindustry > About). Bump this when the game updates.
ARG MINDUSTRY_VERSION=v160.5

# Built-in campaign attack maps with large pre-built enemy bases, used as the map rotation.
ARG ATTACK_MAPS="overgrowth extractionOutpost mycelialBastion atolls geothermalStronghold cruxscape"

RUN apt-get update \
 && apt-get install -y --no-install-recommends unzip \
 && rm -rf /var/lib/apt/lists/* \
 && useradd --system --create-home mindustry

WORKDIR /server

ADD https://github.com/Anuken/Mindustry/releases/download/${MINDUSTRY_VERSION}/server-release.jar server.jar

# Pull the attack maps out of the server jar so they can be hosted as normal custom maps
RUN chmod 644 server.jar \
 && mkdir -p maps \
 && for m in $ATTACK_MAPS; do unzip -j -q server.jar "maps/serpulo/$m.msav" -d maps; done

COPY rules.hjson start.sh ./

# Strip Windows line endings in case the script was edited on Windows
RUN sed -i 's/\r$//' start.sh \
 && chmod 755 start.sh \
 && mkdir -p config \
 && chown -R mindustry:mindustry config

# Never run the game server as root
USER mindustry

# Settings, bans, admins and autosaves live here (a Docker volume, so they survive rebuilds)
VOLUME /server/config

EXPOSE 6567/tcp 6567/udp

ENTRYPOINT ["./start.sh"]
