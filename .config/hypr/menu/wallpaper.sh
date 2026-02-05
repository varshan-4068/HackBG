#!/usr/bin/env bash

echo -e "$(tput setaf 2)Store your wallpaper's in $HOME/.config/backgrounds/$(tput setaf 7)\n"

select_wallpaper=$(echo -e "Choose\nRandom\nBack\nQuit" | gum choose --header="Change wallpaper: ")
menu=~/.config/hypr/menu/update.sh

identify_wallpaper_engine() {
    if pgrep -x swww-daemon >/dev/null; then
        echo "swww"
    elif pgrep -x hyprpaper >/dev/null; then
        echo "hyprpaper"
    else
        echo "unknown"
    fi
}

case "$select_wallpaper" in

Random)

	WALLPAPER_ENGINE=$(identify_wallpaper_engine)

	WALLPAPER_DIR="$HOME/.config/backgrounds"

	CURRENT_WALL=$( (pgrep -x swww-daemon >/dev/null && swww query | awk '{print $9}') || (pgrep -x hyprpaper >/dev/null && grep -o '/home.*' ~/.config/hypr/hyprpaper.conf))

	if [ -z "$CURRENT_WALL" ];then
		echo -e "[-] Current Wallpaper Not Found!"
		echo -e "\n[-] Please Try Again\n"
		read -rp "Press Enter to Escape"	
		exec $menu
	fi

	WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)


	if [ "$WALLPAPER_ENGINE" == "swww" ]; then
			swww img --transition-step 225 --transition-type center --transition-duration 2 --transition-fps 90 --transition-angle 0 "$WALLPAPER"
	elif [ "$WALLPAPER_ENGINE" == "hyprpaper" ]; then
			sed -i "/path =/s|path =.*|path = $WALLPAPER|" ~/.config/hypr/hyprpaper.conf
			setsid hyprpaper >/dev/null 2>&1 &
	else
			echo -e "Unknown wallpaper engine detected, unable to set wallpaper.\n"
			read -rp "Press Enter to Escape"
			exec $menu
	fi

	sed -i "s|^wallpaper *=.*|wallpaper = $WALLPAPER|" ~/.config/waypaper/config.ini

	wal -q -e -i "$WALLPAPER" -n

	sh ~/.config/hypr/settings/wallpaper_fetch.sh

	killall -SIGUSR2 waybar
	
	exit 0
	;;

Choose)

	WALLPAPER_ENGINE=$(identify_wallpaper_engine)

	WALLPAPER_DIR="$HOME/.config/backgrounds/"

	WALLPAPER=$(eza "$WALLPAPER_DIR")

	selected=$(printf "%s\n" "$WALLPAPER" | gum choose --header "Select the wallpaper to set: ")

	if [ -z "$selected" ]; then
		echo
		echo "Please select any of the below to be set as wallpaper"
		echo
		sh ~/.config/hypr/menu/wallpaper.sh
	fi

	echo -e "\nYou had selected:\n$selected"

	echo

	if [ "$WALLPAPER_ENGINE" == "swww" ]; then
			swww img --transition-step 225 --transition-type center --transition-duration 2 --transition-fps 90 --transition-angle 0 "$WALLPAPER_DIR$selected"
	elif [ "$WALLPAPER_ENGINE" == "hyprpaper" ]; then
			sed -i "/path =/s|path =.*|path = $WALLPAPER_DIR$selected|" ~/.config/hypr/hyprpaper.conf
			setsid hyprpaper >/dev/null 2>&1 &
	else
			echo -e "Unknown wallpaper engine detected, unable to set wallpaper.\n"
			read -rp "Press Enter to Escape"
			exec $menu
	fi

	sed -i "s|^wallpaper *=.*|wallpaper = $WALLPAPER_DIR$selected|" ~/.config/waypaper/config.ini

	wal -q -e -i "$WALLPAPER_DIR$selected" -n

	sh ~/.config/hypr/settings/wallpaper_fetch.sh

	killall -SIGUSR2 waybar

	exit 0
	;;

Back)
	sh $menu
	;;
Quit) 
	exit 0
	;;
esac

if [ -z "$select_wallpaper" ]; then
	echo
	echo "Please any of the options below"
	echo
	sh ~/.config/hypr/menu/wallpaper.sh
fi
