#!/bin/bash

set -x

NAME="$1"
COMMENT="$2"
COMMAND="$3"

if [ $# -ne 3 ]; then
    echo "Usage: $0 name comment command"
    exit 0
fi

# Create a .desktop file in the autostart directory
echo "[Desktop Entry]
Type=Application
Exec=$COMMAND
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=$NAME
Name=$NAME
Comment[en_US]=$COMMENT
Comment=$COMMENT" >"$HOME/.config/autostart/$NAME.desktop"
