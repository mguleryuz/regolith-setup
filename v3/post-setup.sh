#!/bin/bash

# Get the current directory
current_dir=$(pwd)/v3

# Ask the user if they want to use X11 or Wayland
read -p "Do you want to use X11 or Wayland? (x/w) " display_manager

# Run install-pkgs.sh
echo "Running install-pkgs.sh..."
bash "$current_dir/install-pkgs.sh"

# Run setup-network.sh
echo "Running setup-network.sh..."
bash "$current_dir/setup-network.sh"

# Run setup-config.sh
echo "Running setup-config.sh..."
bash "$current_dir/setup-config.sh"

# Run setup-sddm.sh
echo "Running setup-sddm.sh..."
bash "$current_dir/setup-sddm.sh"

if [[ $display_manager == [xX] ]]; then
    echo "Running x11-display-setup.sh..."
    bash "$current_dir/x11-display-setup.sh"
fi

echo "All scripts executed successfully."
