#!/bin/bash

# Get the directory of the currently running script
script_path=$(dirname "$0")

echo "Updating and upgrading system packages..."
sudo apt update

echo "Installing PulseAudio, and pavucontrol..."
sudo apt install pulseaudio pulseaudio-utils pavucontrol -y

# Enable PulseAudio for the current user
systemctl --user enable pulseaudio
systemctl --user start pulseaudio

# Backup /etc/pulse/daemon.conf if not already backed up
echo "Backing up /etc/pulse/daemon.conf..."
if [ ! -f /etc/pulse/daemon.bak ]; then
    sudo cp /etc/pulse/daemon.conf /etc/pulse/daemon.bak
else
    echo "Backup already exists."
fi

# Writing new configuration to /etc/pulse/daemon.conf
echo "Updating PulseAudio configuration..."
sudo bash -c 'cat <<EOF > /etc/pulse/daemon.conf
deferred-volume-safety-margin-usec = 1
default-sample-format = float32le
default-sample-rate = 48000
alternate-sample-rate = 44100
default-sample-channels = 2
default-channel-map = front-left,front-right
default-fragments = 2
default-fragment-size-msec = 125
resample-method = soxr-vhq
remixing-produce-lfe = no
remixing-consume-lfe = no
high-priority = yes
nice-level = -11
realtime-scheduling = yes
realtime-priority = 9
rlimit-rtprio = 9
daemonize = no
EOF'

# Reboot recommendation
echo "PulseAudio, and pavucontrol installation and basic configuration are completed."
echo "It is recommended to reboot the system for changes to take effect."

# End of script message
echo "Script execution completed."

"$script_path/aac/index.sh"
