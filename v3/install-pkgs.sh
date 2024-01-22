#!/bin/bash

#Prep
sudo apt update

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
