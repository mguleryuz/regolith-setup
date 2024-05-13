#!/bin/bash

# Get the directory of the currently running script
script_path=$(dirname "$0")

# Update package lists
sudo apt update

# Install SDDM without asking for user input
sudo apt install -y sddm

# Take a backup of the default theme and copy ../debian-theme to /usr/share/sddm/themes/debian-theme
sudo mv /usr/share/sddm/themes/debian-theme /usr/share/sddm/themes/debian-theme.bak
sudo cp -r $script_path/../debian-theme /usr/share/sddm/themes/debian-theme

# Change the background of default theme
BG_PATH="/usr/share/backgrounds/initial-background.png"
THEME_CONF="/usr/share/sddm/themes/debian-theme/theme.conf"

# Replace the background path in the theme.conf file
sudo sed -i "s|background=.*|background=$BG_PATH|" $THEME_CONF
