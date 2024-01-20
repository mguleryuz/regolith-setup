#!/bin/bash

script_path=$(dirname "$0")
background_path=$script_path/../initial-background.png

# Navigate to the specified directory
cd $HOME/.config/regolith3/

# Create the 'sway' & 'i3' directory if it doesn't exist
mkdir -p sway/config.d
mkdir -p i3/config.d

# Navigate back to the this dir
cd -

#Reset Xresources
>$HOME/.config/regolith3/Xresources

#Set Backgrounds
sudo cp $background_path /usr/share/backgrounds/initial-background.png

echo "regolith.wallpaper.file: /usr/share/backgrounds/initial-background.png" >>$HOME/.config/regolith3/Xresources
echo "regolith.lockscreen.wallpaper.file: /usr/share/backgrounds/initial-background.png" >>$HOME/.config/regolith3/Xresources

#i3 and sway Configs
echo "focus_follows_mouse yes" >>$HOME/.config/regolith3/sway/config.d/40_i3-swap-focus
echo "focus_follows_mouse yes" >>$HOME/.config/regolith3/i3/config.d/40_i3-swap-focus

#Set default lock ap as swaylock
echo "wm.program.lock: /usr/bin/gtklock" >>~/.config/regolith3/Xresources

#Set default terminal
sudo update-alternatives --set x-terminal-emulator /usr/bin/gnome-terminal.wrapper

#Refresh look
regolith-look refresh
