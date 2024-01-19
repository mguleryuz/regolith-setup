#!/bin/bash

# Get the directory of the current script
script_dir=$(dirname "$0")

source $script_dir/../utils.sh

# Add Res Setter Script to sddm
SDDM_XSETUP_DIR=/usr/share/sddm/scripts

# Define the new DisplayCommand
new_command="bash $SDDM_XSETUP_DIR/add-and-set-resolution.sh eDP-1 1440 900 60"

# Update the DisplayCommand in the Xsetup file
update_config_with_section "X11" "DisplayCommand" "$new_command" "/etc/sddm.conf"
update_config_with_section "X11" "SessionCommand" "$new_command" "/etc/sddm.conf"
