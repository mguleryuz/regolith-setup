#!/bin/bash

# Display a disclaimer
echo "Disclaimer: This script is intended for first-time setup only. Please ensure you want to proceed."

# Ask for confirmation
read -p "Are you sure you want to proceed? (y/n) " confirm

# Check the user's response
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    sudo apt update
    sudo apt install wget -y

    # Register the Regolith public key to your local apt:
    wget -qO - https://regolith-desktop.org/regolith.key |
        gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg >/dev/null

    # Add the repository URL to your local apt:
    echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] \
    https://regolith-desktop.org/release-3_0-ubuntu-lunar-amd64 lunar main" |
        sudo tee /etc/apt/sources.list.d/regolith.list

    # Update apt and install Regolith
    sudo apt update
    sudo apt install regolith-desktop regolith-session-sway regolith-look-ayu-dark gnome-disk-utility
else
    echo "Setup cancelled."
fi
