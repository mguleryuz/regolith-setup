#!/bin/bash

script_path=$(dirname "$0")
background_path=$script_path/../initial-background.png

# Navigate to the specified directory
cd $HOME/.config/regolith3/

# Create the 'sway' & 'i3' directory if it doesn't exist
for wm in sway i3; do
    mkdir -p $wm/config.d
done

# Navigate back to the this dir
cd -

#Reset Xresources
>$HOME/.config/regolith3/Xresources

#Set Backgrounds
sudo cp $background_path /usr/share/backgrounds/initial-background.png

echo "regolith.wallpaper.file: /usr/share/backgrounds/initial-background.png" >>$HOME/.config/regolith3/Xresources
echo "regolith.lockscreen.wallpaper.file: /usr/share/backgrounds/initial-background.png" >>$HOME/.config/regolith3/Xresources

#i3 and sway Configs
for wm in sway i3; do
    echo "focus_follows_mouse yes" >>$HOME/.config/regolith3/$wm/config.d/40_i3-swap-focus
    echo "exec xgamma -gamma 0.9" >>$HOME/.config/regolith3/$wm/config.d/80_compositor
    echo "workspace_auto_back_and_forth yes" >>$HOME/.config/regolith3/i3/config.d/90-workspace-switch
done

#Set default lock ap as swaylock
echo "wm.program.lock: /usr/bin/gtklock" >>~/.config/regolith3/Xresources

#Set default terminal
sudo update-alternatives --set x-terminal-emulator /usr/bin/gnome-terminal.wrapper

#Refresh look
regolith-look refresh
