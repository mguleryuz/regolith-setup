#!/bin/bash

script_dir=$(dirname "$0")
source $script_dir/../utils.sh

# Get the directory of the current script
script_dir=$(dirname "$0")

#fix flickering
#sudo cp $script_dir/20-intel.conf /etc/X11/xorg.conf.d/20-intel.conf

# Add Reselution Setter Script to sddm
SDDM_XSETUP_DIR=/usr/share/sddm/scripts
# Copy the script to the sddm scripts directory
sudo cp $script_dir/../add-and-set-resolution.sh $SDDM_XSETUP_DIR/add-and-set-resolution.sh
# Make the script executable
sudo chmod +x $SDDM_XSETUP_DIR/add-and-set-resolution.sh

# Define the new DisplayCommand
new_command="bash $SDDM_XSETUP_DIR/add-and-set-resolution.sh eDP-1 1440 900 60"

# Update the DisplayCommand in the Xsetup file
update_config_with_section "X11" "DisplayCommand" "$new_command" "/etc/sddm.conf"

sudo systemctl restart sddm
