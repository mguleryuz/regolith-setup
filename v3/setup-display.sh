#!/bin/bash

script_path=$(dirname "$0")
add_gnome_startup_command=$script_path/../add_gnome_startup_command.sh
add_and_set_resolution=$script_path/../add-and-set-resolution.sh
source $script_path/../utils/index.sh

#fix flickering
sudo apt update
sudo apt install linux-oem-20.04 -y
# ( note// buggy ) disabled
#sudo cp $script_path/../utils/20-intel.conf /etc/X11/xorg.conf.d/20-intel.conf

# Add Reselution Setter Script to sddm
SDDM_XSETUP_DIR=/usr/share/sddm/scripts
# Copy the script to the sddm scripts directory
sudo cp $add_and_set_resolution $SDDM_XSETUP_DIR/add-and-set-resolution.sh
# Make the script executable
sudo chmod +x $SDDM_XSETUP_DIR/add-and-set-resolution.sh

# Ask for width, height and refresh rate and set variables
echo "Enter the width of the resolution you want to set:"
read width
echo "Enter the height of the resolution you want to set:"
read height
echo "Enter the refresh rate of the resolution you want to set:"
read refresh_rate

# Define the new DisplayCommand
new_command="bash $SDDM_XSETUP_DIR/add-and-set-resolution.sh eDP-1 $width $height $refresh_rate"

# Add gnome startup script
add_gnome_startup_command "SetResolution" "Set the resolution to $width $height" "$new_command"

# Update the DisplayCommand in the Xsetup file
update_key_value "DisplayCommand=" "$new_command" "/usr/share/sddm/scripts/Xsetup"

sudo systemctl restart sddm
