#!/bin/bash

# Install NetworkManager if it's not already installed
echo "Installing NetworkManager..."
sudo apt update
sudo apt install -y network-manager

# Modify Netplan to use NetworkManager
echo "Configuring Netplan to use NetworkManager..."
NETPLAN_FILE=$(ls /etc/netplan/*.yaml | head -n1)
if [ -f "$NETPLAN_FILE" ]; then
    echo "Modifying $NETPLAN_FILE..."
    sudo sed -i 's/renderer: .*/renderer: NetworkManager/' "$NETPLAN_FILE"
    sudo netplan apply
else
    echo "No Netplan configuration file found. Skipping this step."
fi

# Modify NetworkManager configuration
echo "Configuring NetworkManager..."
NM_CONF="/etc/NetworkManager/NetworkManager.conf"
if [ -f "$NM_CONF" ]; then
    echo "Updating $NM_CONF..."
    sudo sed -i '/^\[ifupdown\]$/,/^\[/ s/managed=false/managed=true/' "$NM_CONF"
else
    echo "NetworkManager.conf not found. Creating file with proper configuration."
    echo -e "[main]\nplugins=ifupdown,keyfile\n\n[ifupdown]\nmanaged=true" >"$NM_CONF"
fi

# Restart NetworkManager
echo "Restarting NetworkManager..."
sudo systemctl restart NetworkManager

echo "Configuration completed. Please reboot the system."
