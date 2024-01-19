#!/bin/bash

# Navigate to the specified directory
cd $HOME/.config/regolith3/

# Create the 'i3' directory if it doesn't exist
mkdir -p i3/config.d

# Navigate back to the this dir
cd -

#Reset Xresources
>$HOME/.config/regolith3/Xresources

#Set Backgrounds
sudo cp webb-art0.png /usr/share/backgrounds/webb-art0.png

echo "regolith.wallpaper.file: /usr/share/backgrounds/webb-art0.png" >>$HOME/.config/regolith3/Xresources
echo "regolith.lockscreen.wallpaper.file: /usr/share/backgrounds/webb-art0.png" >>$HOME/.config/regolith3/Xresources

#i3 Configs
echo "focus_follows_mouse yes" >>$HOME/.config/regolith3/i3/config.d/40_i3-swap-focus
#echo "exec xgamma -gamma 0.9" >> $HOME/.config/regolith3/i3/config.d/80_compositor

#Set default lock ap as i3lock
echo "wm.program.lock: /usr/bin/i3lock" >>~/.config/regolith3/Xresources

#Refresh look
regolith-look refresh
