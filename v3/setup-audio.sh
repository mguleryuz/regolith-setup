#!/bin/bash

echo "Updating and upgrading system packages..."
sudo apt update

echo "Installing ALSA, PulseAudio, and pavucontrol..."
sudo apt install -y alsa-base alsa-utils pulseaudio pulseaudio-utils pavucontrol

# Checks if the script is being run in a user session with D-Bus
if [ -n "$DBUS_SESSION_BUS_ADDRESS" ]; then
    echo "D-Bus session is available."
    # Enable PulseAudio for the current user
    systemctl --user enable pulseaudio
    systemctl --user start pulseaudio
else
    echo "D-Bus session is not available. Trying to start PulseAudio for the specified user: $USER"
    # Trying to start PulseAudio as a specific user
    sudo -u $USER systemctl --user enable pulseaudio
    sudo -u $USER systemctl --user start pulseaudio
fi

echo "Unmuting ALSA controls..."
sudo -u $USER amixer sset Master unmute
sudo -u $USER amixer sset Speaker unmute
sudo -u $USER amixer sset Headphone unmute

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
enable-lfe-remixing = no
high-priority = yes
nice-level = -11
realtime-scheduling = yes
realtime-priority = 9
rlimit-rtprio = 9
daemonize = no
EOF'

# Reboot recommendation
echo "ALSA, PulseAudio, and pavucontrol installation and basic configuration are completed."
echo "It is recommended to reboot the system for changes to take effect."

# End of script message
echo "Script execution completed."
