# Mindustry Attack Server on Render

This repository contains a Dockerized Mindustry server configured for **Attack mode** with:
- Complex enemy base
- 3-minute first wave timer
- Lenient starting waves
- Public access

## Features
- **Mode:** Attack (Players vs Complex Enemy Base)
- **First Wave Timer:** 3 minutes (180 seconds)
- **Wave Interval:** Normal after first wave
- **Enemy Base:** Extremely complex (10/10 complexity)
- **Public:** Yes
- **Permanent:** Yes (as long as service is running)

## Deployment on Render

### Step 1: Create a GitHub Repository
1. Go to [GitHub](https://github.com/new)
2. Create a new **public** repository (e.g., `mindustry-server`)
3. Upload all files from this folder:
   - `Dockerfile`
   - `server.properties`
   - `maps/` directory
   - `.gitignore`
   - `README_RENDER.md`

### Step 2: Deploy on Render
1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Click **"New" → "Web Service"**
3. **Connect your GitHub account** and select your repository
4. Configure the service:
   - **Name:** `mindustry-attack-server` (or any name you prefer)
   - **Region:** Choose the closest to you and your players
   - **Branch:** `main` (or `master`)
   - **Root Directory:** (leave blank if files are in root)
   - **Build Command:** (leave blank)
   - **Start Command:** (leave blank - uses Dockerfile CMD)
   - **Environment:** **Docker**
   - **Auto-Deploy:** ✅ Enable (optional)

5. **Advanced Settings:**
   - **Internal Port:** `6567`
   - **External Port:** `6567`
   - **Protocol:** **TCP** (IMPORTANT!)

6. Click **"Create Web Service"**

### Step 3: Wait for Deployment
- Deployment takes **2-5 minutes**
- You'll see the build logs in the Render dashboard
- Once complete, your server will be live!

### Step 4: Connect to Your Server
- Your server URL will be: `[your-service-name].onrender.com:6567`
- Example: `mindustry-attack-server-abc123.onrender.com:6567`
- Share this with your friends to join

## Server Configuration

The server is pre-configured with:
- **Wave Timer:** 180 seconds (3 minutes for first wave)
- **Mode:** Attack
- **Map:** attack-complex (custom map with complex enemy base)
- **Max Players:** 64
- **Public:** true
- **Pausable:** false (runs permanently)

### Customizing Settings
Edit `server.properties` to change:
- Server name
- Max players
- Wave settings
- Enemy base complexity
- And more...

### Adding Custom Maps
1. Add map files to the `maps/` directory
2. Update `server.properties` to use your map
3. Re-deploy on Render

## Important Notes

### Render Free Tier Limitations
- **Sleeps after 15 minutes of inactivity** (server stops)
- **512MB RAM** (may be tight for many players)
- **0.1 CPU** (may be slow with many players)

### Preventing Sleep
To keep your server awake:
1. Use a **free uptime monitor** like:
   - [UptimeRobot](https://uptimerobot.com/) (free for 50 monitors)
   - [Pingdom](https://www.pingdom.com/) (free trial)
   - [Cron-job.org](https://cron-job.org/) (free)

2. Set up a **HTTP ping** every **10 minutes** to:
   ```
   http://[your-service-name].onrender.com
   ```

### Upgrading for Better Performance
For a better experience, consider upgrading to:
- **Starter plan ($7/month):**
  - 1GB RAM
  - 1 CPU
  - No sleeping
  - Custom domains

## Connecting to the Server

### From Mindustry Client:
1. Open Mindustry
2. Go to **Multiplayer → Connect**
3. Enter: `[your-service-name].onrender.com:6567`
4. Click **Connect**

### Troubleshooting
- **"Connection refused"**: Server might be sleeping. Wake it up by visiting the URL in a browser.
- **"Connection timed out"**: Check if the service is running in Render dashboard.
- **"Invalid server"**: Make sure you're using the correct port (6567).

## Custom Maps

The `maps/attack-complex` directory contains a custom map configuration with:
- Extremely complex enemy base (complexity: 10)
- 50 turrets
- 300 walls
- 25 factories
- Shields, regeneration, and boss spawns enabled

### Creating Custom Maps
1. Create a new directory in `maps/`
2. Add a `map.properties` file with your settings
3. Update `server.properties` to use your map name
4. Re-deploy on Render

## Administration

### RCON (Remote Console)
The server has RCON enabled:
- **Port:** 6568
- **Password:** `changeme` (CHANGE THIS in server.properties!)

Connect using an RCON client or telnet:
```
telnet [your-service-name].onrender.com 6568
```

### Admin Commands
Add your name to `adminlist.txt` to gain admin privileges in-game.

## Support

For issues with:
- **Render:** https://render.com/docs
- **Mindustry Server:** https://github.com/Anuken/Mindustry
- **This configuration:** Check the README or open an issue

## License

Mindustry is licensed under the [Mindustry License](https://github.com/Anuken/Mindustry/blob/master/LICENSE).
This configuration is provided as-is for personal use.
