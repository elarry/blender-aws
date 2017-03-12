#!/bin/bash

BLENDER_FILE="$(find * -maxdepth 0 -type f -name "*.blend")"  # Name of blender file to be rendered 

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"  # Current directory containing blender files
CERTIFICATE_SOURCE="/.../ENTER_KEY_HERE.pem"  # Source of AWS certificate
SERVER_ADDRESS="ubuntu@ec2-ENTER_SERVER_ADDRESS_HERE" 

# Create working directory for Blender on server
ssh -X -i $CERTIFICATE_SOURCE $SERVER_ADDRESS <<EOF
mkdir blender;
mkdir ~/blender/tmp;
EOF

# Copy blender files from current directory to AWS server
scp -i $CERTIFICATE_SOURCE $DIR/* $SERVER_ADDRESS:~/blender/

# Execute Blender rendering
ssh -X -i $CERTIFICATE_SOURCE $SERVER_ADDRESS <<EOF 
blender -b ~/blender/$BLENDER_FILE -E CYCLES -o ~/blender/tmp/ -P ~/blender/blender_gpu_settings.py -a;

# If instance is not GPU enabled, comment the above and use the one below instead.
#blender -b ~/blender/$BLENDER_FILE -E CYCLES -o ~/blender/tmp/ -P ~/blender/blender_cpu_settings.py -a;
EOF

# Download rendered images from server to local
scp -i $CERTIFICATE_SOURCE -r $SERVER_ADDRESS:~/blender/tmp $DIR
