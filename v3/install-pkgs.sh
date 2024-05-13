#!/bin/bash

#Prep
sudo apt update

#Dependencies
sudo apt install snapd apt-transport-https -y
#Tools
sudo apt install git unzip synaptic viewnior gnome-terminal network-manager gnome-disk-utility nano nautilus gedit gnome-tweaks gparted gnome-system-monitor -y

#Install BUN
echo "Installing BUN and NVM..."
curl -fsSL https://bun.sh/install | bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

#Initilize git
echo "Initializing git..."
echo "What is your GIT username?"
read git_username
git config --global user.name "$git_username"
echo "What is your GIT email?"
read git_email
git config --global user.email "$git_email"
echo "Done initializing git."
