#!/bin/bash

initial_directory=$(pwd)
temp_directory=$(mktemp -d)
build_directory=$(mktemp -d)
cd $temp_directory
wget https://ppa.launchpadcontent.net/aglasgall/pipewire-extra-bt-codecs/ubuntu/pool/main/p/pipewire/libspa-0.2-bluetooth_0.3.65-4%7Eglasgall1_amd64.deb
dpkg -x $(ls *.deb) $temp_directory
mkdir $build_directory/DEBIAN
mkdir -p $build_directory/usr/lib/x86_64-linux-gnu/spa-0.2/bluez5/
mv $temp_directory/usr/lib/x86_64-linux-gnu/spa-0.2/bluez5/libspa-codec-bluez5-aac.so \
    $build_directory/usr/lib/x86_64-linux-gnu/spa-0.2/bluez5/
cat >"$build_directory/DEBIAN/control" <<'EOL'
Package: libspa-codec-bluez5-aac
Source: libspa-codec-bluez5-aac
Version: 0.3.65
Architecture: amd64
Maintainer: jpas78 <musclor_2000@yahoo.com>
Depends: libfdk-aac-dev
Section: libs
Priority: optional
Multi-Arch: same
Homepage: https://pipewire.org/
Description: AAC library for the PipeWire multimedia server - bluetooth plugins
EOL
deb_file=libspa-codec-bluez5-aac_0.3.65_amd64.deb
fakeroot dpkg -b $build_directory $deb_file
mv $deb_file $initial_directory/
cd $initial_directory
rm -rf $temp_directory $build_directory
