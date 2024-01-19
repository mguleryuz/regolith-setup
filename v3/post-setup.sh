#!/bin/bash

# Get the current directory
current_dir=$(pwd)/v3

# Run install-pkgs.sh
echo "Running install-pkgs.sh..."
bash "$current_dir/install-pkgs.sh"

# Run setup-network.sh
echo "Running setup-network.sh..."
bash "$current_dir/setup-network.sh"

# Run setup-config.sh
echo "Running setup-config.sh..."
bash "$current_dir/setup-config.sh"

echo "All scripts executed successfully."
