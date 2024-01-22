#!/bin/bash

script_path=$(dirname "$0")

echo "Running Install Packages..."
bash "$script_path/install-pkgs.sh"

echo "Running Setup Network..."
bash "$script_path/setup-network.sh"

echo "Running Setup Audio..."
bash "$script_path/setup-audio.sh"

echo "Running Setup Config..."
bash "$script_path/setup-config.sh"

echo "Running Setup SDDM..."
bash "$script_path/setup-sddm.sh"

echo "Running Setup Display..."
bash "$script_path/setup-display.sh"

echo "All scripts executed successfully."
