#!/bin/bash

# Nginx RTMP start and status check script
# This script starts Nginx and verifies it's running correctly

echo "=== Starting Nginx RTMP Server ==="

# Start Nginx
echo "Starting Nginx..."
sudo /usr/local/nginx/sbin/nginx

# Wait a moment for Nginx to start
sleep 2

# Check Nginx processes
echo ""
echo "=== Checking Nginx processes ==="
ps aux | grep nginx | grep -v grep

# Check RTMP port (1935)
echo ""
echo "=== Checking RTMP port 1935 ==="
if command -v netstat &> /dev/null; then
    sudo netstat -tlnp | grep 1935
else
    echo "netstat not found, installing net-tools..."
    sudo apt install net-tools -y
    sudo netstat -tlnp | grep 1935
fi

echo ""
echo "=== Nginx RTMP Server Status ==="
if pgrep -x "nginx" > /dev/null; then
    echo "✓ Nginx is running"
else
    echo "✗ Nginx is not running"
    exit 1
fi

if sudo netstat -tlnp 2>/dev/null | grep -q 1935; then
    echo "✓ RTMP port 1935 is listening"
else
    echo "✗ RTMP port 1935 is not listening"
    echo "  Make sure RTMP is configured in nginx.conf"
fi

echo ""
echo "Useful commands:"
echo "  Stop Nginx:    sudo /usr/local/nginx/sbin/nginx -s stop"
echo "  Reload config: sudo /usr/local/nginx/sbin/nginx -s reload"
echo "  Check config:  sudo /usr/local/nginx/sbin/nginx -t"
