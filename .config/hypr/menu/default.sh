#!/usr/bin/env bash

default=$(echo -e "Browser\nWallpaper Engine\nBack\nQuit" | gum choose --header="Change Defaults: ")
menu=~/.config/hypr/menu

browser(){
	input=$(gum input --placeholder "Enter the browser name to be set as default...")
	search=$(grep -li "WebBrowser" /usr/share/applications/*.desktop | xargs -n1 basename | grep -i "$input")

	if [ -z "$input" ]; then
		echo -e "No Input Provided\n"
		read -rp "Press Enter to Escape"
		echo && sh $menu/update.sh
	fi

	if [ -n "$search" ];then
		count=$(printf "%s\n" "$search" | wc -l)
		if [ "$count" -gt 1 ];then
			browser=$(printf "%s\n" "$search" | gum choose)
		else
			browser="$search"
		fi
		if gum confirm "[+] Found $browser, Set it as default?"; then
        xdg-settings set default-web-browser "$browser"
        echo -e "$browser is set as default\n"
    else
        echo -e "Canceled Operation\n"
    fi
    read -rp "Press Enter to Escape Back"
    sh "$menu/update.sh"
	else
		echo -e "No web browser found matching that name.\n"
		echo -e "Tip: Try typing part of the browser name (e.g. firefox, chrome, brave, qutebrowser, etc)\n"
		read -rp "Press Enter to Escape"
		sh $menu/update.sh
	fi
}

hyprpaper_wallpaper(){
	if ! pacman -Q hyprpaper &>/dev/null; then
			sudo pacman -S --noconfirm hyprpaper
	fi

	sed -i "s|^backend *=.*|backend = hyprpaper|" ~/.config/waypaper/config.ini

	sed -i 's|swww-daemon|hyprpaper|' ~/.config/hypr/autostart.conf

	if pgrep -x swww-daemon >/dev/null; then
			WALLPAPER=$(swww query 2>/dev/null | awk '{print $9}')
			killall swww-daemon 2>/dev/null
	elif pgrep -x hyprpaper; then 
			WALLPAPER=$(grep -o '/home.*' ~/.config/hypr/hyprpaper.conf)
	fi

	if [ -z "$WALLPAPER" ]; then
			echo -e "\n[-] Could not identify current wallpaper"
			return 1
	fi

	echo -e "\n[+] Using wallpaper: $WALLPAPER"

	sed -i "/path =/s|path =.*|path = $WALLPAPER|" ~/.config/hypr/hyprpaper.conf

	if pgrep -x hyprpaper >/dev/null;then
		killall hyprpaper
		setsid hyprpaper >/dev/null 2>&1 &
	else
		setsid hyprpaper >/dev/null 2>&1 &
	fi

	wal -q -e -i "$WALLPAPER" -n

}

swww_wallpaper(){
	echo -e "\n[+] Added swww-daemon to ~/.config/hypr/autostart.conf"
	sleep 0.4
  sed -i "s|^backend *=.*|backend = swww|" ~/.config/waypaper/config.ini
	local WALLPAPER=""

  if pgrep -x hyprpaper >/dev/null; then
		WALLPAPER=$(grep -o '/home.*' ~/.config/hypr/hyprpaper.conf)
		echo -e "\n[+] Identified current wallpaper $WALLPAPER"
    killall hyprpaper 2>/dev/null || true
    setsid swww-daemon  >/dev/null 2>&1 &
  elif ! pgrep -x swww-daemon >/dev/null; then
		if pgrep -x hyprpaper >/dev/null; then
			WALLPAPER=$(grep -o '/home.*' ~/.config/hypr/hyprpaper.conf)
			echo -e "\n[+] Identified current wallpaper $WALLPAPER"
			setsid swww-daemon >/dev/null 2>&1 &
			disown
		else
			echo -e "\n[+] swww and hyprpaper both are not active"
			sleep 0.4
			echo -e "\n[+] Using swww engine to load wallpaper"
			sleep 0.4
			setsid swww-daemon >/dev/null 2>&1 &
			if [ -f "$menu/wallpaper.sh" ]; then
				echo
				sed -i "s|hyprpaper|swww-daemon|" ~/.config/hypr/autostart.conf  >/dev/null 2>&1
				sh "$menu/wallpaper.sh"
				read -rp "Press Enter to Escape"
				exec $menu/update.sh
			fi
			disown
		fi
  else
		WALLPAPER=$(swww query 2>/dev/null | awk '{print $9}')
		echo -e "\n[+] Identified current wallpaper $WALLPAPER"
		killall swww-daemon 2>/dev/null || true
    setsid swww-daemon >/dev/null 2>&1 &
    disown
  fi

  sed -i "s|hyprpaper|swww-daemon|" ~/.config/hypr/autostart.conf  >/dev/null 2>&1

	if [ -n "$WALLPAPER" ]; then
		echo -e "\n[+] Setting $WALLPAPER as current wallpaper"
			swww img \
					--transition-step 225 \
					--transition-type center \
					--transition-duration 2 \
					--transition-fps 90 \
					--transition-angle 0 \
					"$WALLPAPER" >/dev/null 2>&1
	else
		echo -e "\n[-] Some Error Occured in Identifying Last active wallpaper"
		echo -e "\n[-] Please Try again"
	fi

	wal -q -e -i "$WALLPAPER" -n
}


wallpaper(){
		case "$wallpaper" in
			swww)
				swww_wallpaper
				echo
				read -rp "Press Enter to Escape"
				sh "$menu/update.sh"
				;;
			hyprpaper)
				hyprpaper_wallpaper
				echo
				read -rp "Press Enter to Escape"
				sh "$menu/update.sh"
				;;
			Back)
				sh $menu/update.sh
				;;
			Quit)
				exit 0
				;;
		esac
}

case "$default" in
	Browser)
		browser
		;;
	'Wallpaper Engine')
		wallpaper=$(echo -e "swww\nhyprpaper\nBack\nQuit" | gum choose --header="Choose Default Wallpaper Engine" )
		wallpaper
		;;
	Back)
		sh $menu/settings.sh
		;;
	Quit)
		exit 0
		;;
esac
