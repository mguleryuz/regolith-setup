#!/bin/bash

#Prep
sudo apt update

sudo apt install curl wget -y

echo "Do you want to install: BUN and NVM ? (y/n)"
read install_package_managers

if [[ $install_package_managers == [yY] ]]; then
    #Install BUN
    echo "Installing BUN and NVM..."
    curl -fsSL https://bun.sh/install | bash

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

#Dependencies
sudo apt install git update-manager viewnior gnome-terminal network-manager gnome-disk-utility nano nautilus gedit gnome-tweaks gparted gnome-system-monitor -y

#Initilize git
echo "Initializing git..."
echo "What is your GIT username?"
read git_username
git config --global user.name "$git_username"
echo "What is your GIT email?"
read git_email
git config --global user.email "$git_email"
echo "Done initializing git."
