#!/bin/bash

# Pre-answer the installation prompts
echo "sddm sddm/default-display-manager select /usr/sbin/sddm" | sudo debconf-set-selections

# Update package lists
sudo apt update

# Install SDDM without asking for user input
DEBIAN_FRONTEND=noninteractive sudo apt install -y sddm

# Change the background of default theme
BG_PATH="/usr/share/backgrounds/initial-background.png"
THEME_CONF="/usr/share/sddm/themes/debian-theme/theme.conf"

# Replace the background path in the theme.conf file
sudo sed -i "s|background=.*|background=$BG_PATH|" $THEME_CONF
