#!/bin/bash

# Nginx with RTMP module installation script
# This script compiles and installs Nginx with RTMP streaming support

set -e  # Exit on any error

echo "=== Starting Nginx RTMP Installation ==="

# Update package list and install dependencies
echo "Installing dependencies..."
sudo apt update
sudo apt install build-essential libpcre3 libpcre3-dev libssl-dev zlib1g-dev unzip wget -y

# Download Nginx and RTMP module
echo "Downloading Nginx and RTMP module..."
cd /tmp
wget http://nginx.org/download/nginx-1.28.0.tar.gz
wget https://github.com/arut/nginx-rtmp-module/archive/master.zip

# Extract archives
echo "Extracting archives..."
tar -zxvf nginx-1.28.0.tar.gz
unzip master.zip

# Compile Nginx with RTMP module
echo "Compiling Nginx with RTMP module..."
cd nginx-1.28.0
./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master
make
sudo make install

# Copy stat.xml
sudo cp /tmp/nginx-rtmp-module-master/stat.xsl /usr/local/nginx/html/

echo "=== Installation completed successfully! ==="
echo "Nginx installed at: /usr/local/nginx"
echo "To start Nginx: sudo /usr/local/nginx/sbin/nginx"
echo "To stop Nginx: sudo /usr/local/nginx/sbin/nginx -s stop"
