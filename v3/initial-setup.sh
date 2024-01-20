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
    sudo apt install regolith-desktop regolith-look-ayu-dark

    # Ask the user if they want to use Wayland, X11, or both
    read -p "Do you want to use Wayland, X11, or both? (w/x/b) " display_manager

    # Install the appropriate Regolith session based on the user's response
    if [[ $display_manager == [wW] ]]; then
        sudo apt install regolith-session-sway
    elif [[ $display_manager == [xX] ]]; then
        sudo apt install regolith-session-flashback
    elif [[ $display_manager == [bB] ]]; then
        sudo apt install regolith-session-sway regolith-session-flashback
    else
        echo "Invalid input. Please enter 'w' for Wayland, 'x' for X11, or 'b' for both."
    fi
else
    echo "Setup cancelled."
fi
