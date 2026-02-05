#!/usr/bin/env bash

plugin(){
	echo 
	echo "[+] Do you wanna install plugins (hyprexpo): "
	echo
	plugins=$(echo -e "yes\nno" | gum choose )
	case "$plugins" in
		yes)
			max_attempts=3
			count=0
			while true;do
				if [ "$count" -eq 0 ];then
					echo
					echo "==> Updating hyprpm"
					echo
				fi
				hyprpm update
				exit_code=$?
				if [ "$exit_code" -eq 0 ];then
					break
				else
					((count++))
					echo
					echo "==> Installation failed (attempt $count/$max_attempts)"
					echo
					if [ "$count" -ge "$max_attempts" ]; then
						echo 
						echo "There may be network error please retry installation script accordingly"
						echo "Tips to follow: "
						echo
						echo "1.Check the internet connection and retry the installation script by running sh setup-arch.sh"
						echo
						exit 1
					else
						hyprpm update
					fi
				fi
			done
			echo
			echo "[+] Copying needed configuration files to ~/.config/hypr/"
			echo
			cp ~/HackBG/plugins/plugins.conf ~/.config/hypr/
			echo
			echo "[+] Adding https://github.com/hyprwm/hyprland-plugins to hyprpm"
			echo
			hyprpm add https://github.com/hyprwm/hyprland-plugins
			echo
			echo "[+] Enabling hyprexpo plugin"
			echo
			hyprpm enable hyprexpo
			if [ "$exit_code" == 0 ];then
				clear
				return
			fi
			;;
		no)
			clear
			return
			;;
	esac
}

if [ ! -z "$WAYLAND_DISPLAY" ];then
	plugin
fi
