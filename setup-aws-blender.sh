#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"  # Current directory containing blender files
CERTIFICATE_SOURCE="/.../ENTER_KEY_HERE.pem"  # Source of AWS certificate
SERVER_ADDRESS="ubuntu@ec2-ENTER_SERVER_ADDRESS_HERE" 

# Create working directory for Blender on server
ssh -X -i $CERTIFICATE_SOURCE $SERVER_ADDRESS <<EOF
mkdir blender;
mkdir ~/blender/tmp;
EOF

# Copy blender files, and python setting files to AWS server
scp -i $CERTIFICATE_SOURCE $DIR/* $SERVER_ADDRESS:~/blender/  

# Set up AWS for blender rendering
ssh -X -i $CERTIFICATE_SOURCE $SERVER_ADDRESS <<EOF
sudo add-apt-repository -y ppa:thomas-schiex/blender;
sudo apt-get update -y;        # Get list of available updates
sudo apt-get upgrade -y;       # Upgrade current packages
sudo apt-get dist-upgrade -y;  # Install updates

sudo apt install blender -y;
sudo apt-get install nvidia-cuda-toolkit nvidia-modprobe -y  # Needed for GPU rendering
sudo reboot
EOF

echo "AWS Server ready as soon as reboot has completed..."

