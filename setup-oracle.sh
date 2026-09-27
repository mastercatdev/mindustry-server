#!/bin/bash
# Installs and (re)starts the Mindustry server on an Oracle Cloud Ubuntu VM.
# Run from inside the cloned repo:  bash setup-oracle.sh
# Safe to re-run after "git pull" to update: settings, bans and admins are kept.
set -euo pipefail
PORT=6567

echo "== Installing updates, Docker and automatic security updates"
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y docker.io unattended-upgrades iptables-persistent
sudo systemctl enable --now docker

echo "== Opening port $PORT (TCP + UDP) in the VM firewall (only this port)"
for proto in tcp udp; do
  if ! sudo iptables -C INPUT -p "$proto" --dport "$PORT" -j ACCEPT 2>/dev/null; then
    # Oracle images end INPUT with a REJECT rule; the ACCEPT must go before it
    line=$(sudo iptables -L INPUT --line-numbers | awk '$2=="REJECT"{print $1; exit}')
    sudo iptables -I INPUT "${line:-1}" -p "$proto" --dport "$PORT" -j ACCEPT
  fi
done
sudo netfilter-persistent save

# Give Java half the VM's RAM, capped at 2 GB (works on both 1 GB and 24 GB VMs)
mem_mb=$(awk '/MemTotal/{print int($2/1024)}' /proc/meminfo)
xmx=$(( mem_mb / 2 < 2048 ? mem_mb / 2 : 2048 ))

echo "== Building the server image"
sudo docker build --pull -t mindustry-server .

echo "== (Re)starting the server"
sudo docker rm -f mindustry 2>/dev/null || true
sudo docker run -d -it \
  --name mindustry \
  --restart unless-stopped \
  --network host \
  -v mindustry-config:/server/config \
  -e JAVA_OPTS="-Xmx${xmx}m" \
  mindustry-server

sleep 15
sudo docker logs --tail 20 mindustry
echo
echo "Done. Connect in Mindustry to: <your VM public IP>:$PORT  (public IP is shown on the instance page in Oracle Cloud)"
echo "Server console: sudo docker attach mindustry   (leave it with Ctrl+P then Ctrl+Q, NOT Ctrl+C)"
