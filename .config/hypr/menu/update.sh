#!/usr/bin/env bash

set -e

update() {

	cat <<EOF

 _   _           _       _                          __
| | | |_ __   __| | __ _| |_ ___    ___ ___  _ __  / _|
| | | |  _ \ / _  |/ _  | __/ _ \  / __/ _ \|  _ \| |_
| |_| | |_) | (_| | (_| | ||  __/ | (_| (_) | | | |  _|
 \___/| .__/ \__,_|\__,_|\__\___|  \___\___/|_| |_|_|
      |_|
EOF
}

clear
update

KEYS="$(tput setaf 1)[KEYS]$(tput sgr0)"

echo
echo "${KEYS} Use J and K Keys to Navigate Between Options"
echo "${KEYS} Use g to navigate to top and SHIFT + g for bottom"
echo

select=$(echo -e "Keybindings\nSettings\nWallpaper\nTools\nWaybar\nRofi\nUpdate\nBackup\nQuit" | gum choose --header="Update configs or packages: ")

menu=~/.config/hypr/menu

case "$select" in

Keybindings)
	sh $menu/keybindings.sh
	;;

Settings)
	sh $menu/settings.sh
	;;

Wallpaper)
	sh $menu/wallpaper.sh
	;;

Tools)
	sh $menu/tools.sh
	;;

Waybar)
	sh $menu/waybar.sh
	;;

Rofi)
	sh $menu/rofi.sh
	;;

Update)
	sh $menu/system_update.sh
	;;

Backup)
	sh $menu/timeshift.sh
	;;

Quit) 
	exit 0
	;;
esac
