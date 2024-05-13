#!/bin/bash

# Get the directory of the currently running script
script_path=$(dirname "$0")
source $script_path/utils/index.sh

#Prep
sudo apt update

echo "Do you want to install: Utils ? (y/n)"
read install_utils

echo "Do you want to install: Socials ? (y/n)"
read install_socials

echo "Do you want to install: Brave ? (y/n)"
read install_brave

echo "Do you want to install: Vscode ? (y/n)"
read install_vscode

echo "Do you want to install: 1Password ? (y/n)"
read install_1password

#Dependencies Installed in previous steps // snapd:all, wget:all curl:all, apt-transport-https:vscode, gpg:vscode

#Utils
if [ "$install_utils" = "y" ]; then
    # TODO // p7zip-rar alternative
    sudo apt install p7zip-full -y
    sudo snap install p7zip-desktop
    sudo snap install vlc
fi

#Socials:
if [ "$install_socials" = "y" ]; then
    sudo snap install discord
    sudo snap install slack
    sudo snap install telegram-desktop
fi

#Brave
if [ "$install_brave" = "y" ]; then
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    sudo apt update
    sudo apt install brave-browser -y
fi

#Vscode
if [ "$install_vscode" = "y" ]; then
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg

    sudo apt update
    sudo apt install code -y
fi

#1Password
if [ "$install_1password" = "y" ]; then
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

    echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list

    sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
    curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
    sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

    sudo apt update
    sudo apt install 1password -y
fi

#Done
echo "Done: Installed all dependencies and apps."
