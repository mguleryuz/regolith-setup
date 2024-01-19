#!/bin/bash

#User Confs
cd $HOME/.config/regolith2/ && mkdir i3 && cd i3 && mkdir config.d && cd $HOME

#i3 Configs
echo "focus_follows_mouse yes" >> $HOME/.config/regolith2/i3/config.d/40_i3-swap-focus
echo "exec xgamma -gamma 0.9" >> $HOME/.config/regolith2/i3/config.d/80_compositor

#Set Light Dm Res Config Setup for 1600x900
echo "[Seat:*]
display-setup-script=/etc/lightdm/add-and-set-resolution.sh eDP-1 1600 900 60" >> /etc/lightdm/config/50-display-setup-script.conf

#Copy add-and-set-resolution.sh to /etc/lightdm/ so it can be used by lightdm
sudo cp add-and-set-resolution.sh /etc/lightdm/add-and-set-resolution.sh

#Backgrounds
cp webb-art0.png /usr/share/backgrounds/webb-art0.png &&
echo "regolith.wallpaper.file: /usr/share/backgrounds/webb-art0.png
regolith.lockscreen.wallpaper.file: /usr/share/backgrounds/webb-art0.png" >> $HOME/.config/regolith2/Xresources regolith-look refresh

