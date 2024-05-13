#!/bin/bash

# Get the directory of the currently running script
script_path=$(dirname "$0")

# Create a backup of the sources.list file
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

# Add 'non-free' to the sources.list if it's not already there
"$script_path/non-free.sh"

# Update the package lists
sudo apt update

# Install libfdk-aac-dev
sudo apt install -y libfdk-aac-dev

# Run the build-libspa-codec-bluez5-aac.sh script
"$script_path/build-libspa-codec-bluez5-aac.sh"

# Install the generated .deb file
sudo dpkg -i libspa-codec-bluez5-aac_0.3.65_amd64.deb

echo "libspa-codec-bluez5-aac has been installed."
echo "Restart your system to apply the changes."
