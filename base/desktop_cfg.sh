#!/bin/bash

ROOT_UID=0

# check command avalibility
function has_command() {
    command -v $1 > /dev/null
}

# Load common properties and functions in the current script.
. ./common.sh
	if [ "$UID" -eq "$ROOT_UID" ]; then
# make wallpapers folder
mkdir -p /usr/share/wallpapers/slide

# dowload the default wallpapers
cd /usr/share/wallpapers/slide
wget --no-check-certificate https://github.com/saymoncoppi/linuxslide/raw/master/custom/wallpapers/wallpapers.zip
unzip wallpapers.zip
rm -rf wallpapers.zip
clear

# install white cursor
apt install dmz-cursor-theme

# get watch-startup cursor
cd /usr/share/icons
wget --no-check-certificate https://github.com/saymoncoppi/linuxslide/blob/master/custom/icons/watch-startup

# make folder .config/openbox
mkdir -p ~/.config/openbox/
cd ~/.config/openbox/
clear

# get xresources
cd ~/
wget --no-check-certificate https://raw.githubusercontent.com/saymoncoppi/linuxslide/master/custom/.Xresources

#to change resolution
#https://raw.githubusercontent.com/saymoncoppi/linuxslide/master/custom/fbscreensize

echo "#Set resolution 
# merge xresource settings
xrdb -merge ~/.Xresources

# set background color and big wait mouse cursor
xsetroot -solid '#111111'
xsetroot -xcf /usr/share/icons/watch-startup 37

#Set the wallpaper (check later/usr/share/backgrounds/default_background.jpg)
feh --bg-scale /usr/share/wallpapers/slide/Road.png

#start tint2 
tint2 &" > autostart


# auto startx

echo '[Unit]
Description=X-Window
ConditionKernelCommandLine=!text
After=systemd-user-sessions.service

[Service]
ExecStart=/bin/su --login -c "/usr/bin/startx -- :0 vt7"

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/display-manager.service
systemctl daemon-reload
systemctl enable display-manager


  else
		# Message  
		echo -e "Please run this script as root..."
	fi
