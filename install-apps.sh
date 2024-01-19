#!/bin/bash

source utils.sh

#Prep
sudo apt update

#Dependencies // snapd:all, wget:all curl:all, apt-transport-https:vscode, gpg:vscode
sudo apt install gpg snapd apt-transport-https curl wget -y

#Nvm & Bun
ask_and_run "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash"
ask_and_run "curl -fsSL https://bun.sh/install | bash"

#Git, 7zip
sudo apt install git -y
sudo apt install p7zip-full p7zip-rar -y

#Snaps:
ask_and_run "sudo snap install vlc"
ask_and_run "sudo snap install p7zip-desktop"
ask_and_run "sudo snap install discord"
ask_and_run "sudo snap install slack"
ask_and_run "sudo snap install telegram-desktop"
#===================================================================================================

#Brave
echo "Do you want to install: Brave ? (y/n)"
read answer
if [ "$answer" = "y" ]; then
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    sudo apt update
    sudo apt install brave-browser -y
fi
#===================================================================================================

#Vscode
echo "Do you want to install: Vscode ? (y/n)"
read answer
if [ "$answer" = "y" ]; then
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg

    sudo apt update
    sudo apt install code -y
fi
#===================================================================================================

#1Password
echo "Do you want to install: 1Password ? (y/n)"
read answer
if [ "$answer" = "y" ]; then
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

    echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list

    sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
    curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
    sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

    sudo apt update
    sudo apt install 1password -y
fi
#===================================================================================================

#Done
echo "Done: Installed all dependencies and apps."
echo "Please run the following commands to finish setup:"
echo "source ~/.bashrc"
