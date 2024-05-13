#!/bin/bash

sudo apt update

sudo apt install network-manager -y

# Backup Network Interface
sudo mv /etc/network/interfaces /etc/network/interfaces.bak

# Disable systemd-networkd service ( since we have NM active now )
sudo systemctl stop systemd-networkd
sudo systemctl disable systemd-networkd
sudo systemctl disable systemd-networkd-wait-online.service

# Restart NetworkManager
echo "Restarting NetworkManager..."
sudo systemctl restart NetworkManager

echo "Configuration completed. Please reboot the system."
