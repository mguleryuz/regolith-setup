#!/bin/bash

# Modify Netplan to use NetworkManager
NETPLAN_FILE="/etc/netplan/01-netcfg.yaml"

# Define the content of the Netplan configuration file
NETPLAN_CONTENT="network:
  version: 2
  renderer: NetworkManager"

# Create or overwrite the Netplan configuration file with the specified content
echo "$NETPLAN_CONTENT" | sudo tee "$NETPLAN_FILE"

# Remove the wifi file
sudo rm -f /etc/netplan//etc/netplan/00-installer-config-wifi.yaml

sudo netplan apply

# Modify NetworkManager configuration
echo "Configuring NetworkManager..."
NM_CONF="/etc/NetworkManager/NetworkManager.conf"
if [ -f "$NM_CONF" ]; then
  echo "Updating $NM_CONF..."
  sudo sed -i '/^\[ifupdown\]$/,/^\[/ s/managed=false/managed=true/' "$NM_CONF"
else
  echo "NetworkManager.conf not found. Creating file with proper configuration."
  echo -e "[main]\nplugins=ifupdown,keyfile\n\n[ifupdown]\nmanaged=true" | sudo tee "$NM_CONF"
fi

# Disable NetworkManager-wait-online.service ( for faster boot time )
sudo systemctl disable systemd-networkd-wait-online.service

# Restart NetworkManager
echo "Restarting NetworkManager..."
sudo systemctl restart NetworkManager

echo "Configuration completed. Please reboot the system."
