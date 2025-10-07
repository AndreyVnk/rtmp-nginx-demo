# Lab 1: Basic RTMP Server with Nginx (Local Setup)

## Objective
Set up a local RTMP server and learn how to stream with OBS Studio.

## Requirements
* Ubuntu/Debian Linux (or WSL2 on Windows)
* 2 GB RAM
* 10 GB HDD space

## Step 1: Install Nginx with RTMP Module

```bash
# Installation 
Use nginx-rtmp-installation.sh
```

## Step 2: Configure Nginx

Copy the configuration file nginx.conf to `/usr/local/nginx/conf/nginx.conf`:

## Step 3: Start the Server

```bash
# Start 
Use nginx-rtmp-start-check.sh
```

## Step 4: Streaming with OBS

1. Download OBS Studio: https://obsproject.com/
2. Go to Settings → Stream:
   * Service: Custom
   * Server: `rtmp://localhost:1935/live`
   * Stream Key: `test_stream`
3. Add a source (screen capture, camera, etc.)
4. Click "Start Streaming"

## Step 5: View the Stream

### Option 1: Using VLC Media Player
Install VLC and open the stream with this URL:
```
rtmp://localhost:1935/live/test_stream
```

### Option 2: View Statistics
Open the statistics page in your browser:
```
http://localhost:8080/stat
```

## Troubleshooting

### Nginx won't start
```bash
# Check for errors in the configuration
sudo /usr/local/nginx/sbin/nginx -t

# Check if port 1935 is already in use
sudo netstat -tlnp | grep 1935
```

### Can't connect from OBS
- Verify Nginx is running: `ps aux | grep nginx`
- Check firewall settings
- Ensure the RTMP URL is correct: `rtmp://localhost:1935/live`

### Stream not visible in VLC
- Make sure you've started streaming from OBS first
- Verify the stream key matches: `test_stream`
- Check the statistics page to confirm the stream is active

## Security Notes

The commented lines in the configuration restrict publishing to localhost only. Uncomment these lines for added security:
```nginx
allow publish 127.0.0.1;
deny publish all;
```

## Stopping the Server

```bash
# Stop Nginx
sudo /usr/local/nginx/sbin/nginx -s stop
```

## Next Steps

- Configure stream recording
- Add authentication
- Set up HLS (HTTP Live Streaming) for web playback
- Implement stream transcoding for multiple quality options# rtmp-nginx-demo
