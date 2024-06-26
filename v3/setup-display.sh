#!/bin/bash

script_path=$(dirname "$0")
add_and_set_resolution=$script_path/../utils/add-and-set-resolution.sh
source $script_path/../utils/index.sh

# Add Reselution Setter Script to sddm
SDDM_XSETUP_DIR=/usr/share/sddm/scripts
# Copy the script to the sddm scripts directory
sudo cp $add_and_set_resolution $SDDM_XSETUP_DIR/add-and-set-resolution.sh
# Make the script executable
sudo chmod +x $SDDM_XSETUP_DIR/add-and-set-resolution.sh

# Edit grub video settings
update_key_value "GRUB_CMDLINE_LINUX_DEFAULT=" "quiet splash video=SVIDEO-1:d" "/etc/default/grub"

# Ask for width, height and refresh rate and set variables
echo "Enter the width of the resolution you want to set:"
read width
echo "Enter the height of the resolution you want to set:"
read height
echo "Enter the refresh rate of the resolution you want to set:"
read refresh_rate

# Define the new DisplayCommand
new_command="bash $SDDM_XSETUP_DIR/add-and-set-resolution.sh eDP-1 $width $height $refresh_rate"

# Update the DisplayCommand in the Xsetup file
update_key_value "DisplayCommand=" "$new_command" "/usr/share/sddm/scripts/Xsetup"

sudo update-grub

sudo systemctl restart sddm
