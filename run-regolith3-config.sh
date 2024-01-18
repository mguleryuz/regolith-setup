#!/bin/bash

# Navigate to the specified directory
cd $HOME/.config/regolith3/

# Create the 'i3' directory if it doesn't exist
mkdir -p i3/config.d

# Navigate back to the this dir
cd -

#Reset Xresources
> $HOME/.config/regolith3/Xresources

#Set Backgrounds
sudo cp webb-art0.png /usr/share/backgrounds/webb-art0.png

echo "regolith.wallpaper.file: /usr/share/backgrounds/webb-art0.png" >> $HOME/.config/regolith3/Xresources
echo "regolith.lockscreen.wallpaper.file: /usr/share/backgrounds/webb-art0.png" >> $HOME/.config/regolith3/Xresources

#i3 Configs
echo "focus_follows_mouse yes" >> $HOME/.config/regolith3/i3/config.d/40_i3-swap-focus
#echo "exec xgamma -gamma 0.9" >> $HOME/.config/regolith3/i3/config.d/80_compositor

##Lock Screen
#Disable Default Lock Screen
gsettings set org.gnome.gnome-flashback screensaver false

#Install Lightdm
sudo apt install lightdm -y

#Set default lock ap as lightdm
echo "wm.program.lock: /usr/bin/lightdm" >> ~/.config/regolith3/Xresources

#Copy Res Handler Script for Config Setup for 1680x1050
sudo cp add-and-set-resolution.sh /etc/lightdm/add-and-set-resolution.sh

#Copy add-and-set-resolution.sh to /etc/lightdm/ so it can be used by regolith
sudo echo "[Seat:*]
display-setup-script=/etc/lightdm/add-and-set-resolution.sh eDP-1 1680 1050 60" >> /etc/lightdm/config/50-display-setup-script.conf

#Refresh look
regolith-look refresh
