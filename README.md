# Mindustry Attack Server

Attack-mode Mindustry server (v160.5) that rotates through the built-in campaign maps with large enemy bases:
Overgrowth → Extraction Outpost → Mycelial Bastion → Atolls → Geothermal Stronghold → Cruxscape.

- 12 minutes before the first wave, then 2.5 minutes between waves
- Extra starting resources and 1.5× build speed for players
- Enemy units are weaker (75% damage, 85% health), but enemy buildings are tougher (125% health)
- The game pauses automatically when nobody is online

## Files

| File | What it does |
|---|---|
| `Dockerfile` | Downloads the official server jar and extracts the attack maps |
| `start.sh` | Sets the server name/description and hosts the first map in attack mode |
| `rules.hjson` | Game rules (wave timing, resources, difficulty). Edit here |
| `setup-oracle.sh` | One-shot install/update script for the Oracle Cloud VM |

## Install / update on the VM

```bash
git clone https://github.com/<you>/<repo>.git mindustry && cd mindustry
bash setup-oracle.sh
```

To update later: `cd mindustry && git pull && bash setup-oracle.sh`.

## Admin

- Console: `sudo docker attach mindustry`. Leave it with **Ctrl+P then Ctrl+Q** (Ctrl+C stops the server).
- Make yourself admin: join the game, then in the console run `players` and `admin add <your name>`.
- Other useful commands: `status`, `maps`, `nextmap <name>`, `gameover`, `kick <name>`, `ban id <uuid>`, `help`.
- Logs: `sudo docker logs -f mindustry`.

## Game updates

When Mindustry updates, change `MINDUSTRY_VERSION` in `Dockerfile` to the new tag (e.g. `v161`),
push, then run the update command on the VM. Players on a different version cannot join.
