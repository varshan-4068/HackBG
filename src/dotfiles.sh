#!/usr/bin/env bash

files() {

	gum style \
		--border rounded \
		--align center \
		--width 0 \
		--bold \
		"
 ___     ___   ______  _____  ____  _        ___  _____
|   \   /   \ |      ||     ||    || |      /  _]/ ___/
|    \ |     ||      ||   __| |  | | |     /  [_(   \_ 
|  D  ||  O  ||_|  |_||  |_   |  | | |___ |    _]\__  |
|     ||     |  |  |  |   _]  |  | |     ||   [_ /  \ |
|     ||     |  |  |  |  |    |  | |     ||     |\    |
|_____| \___/   |__|  |__|   |____||_____||_____| \___|
																											 
"

}

clear
files

install_dots() {
	echo

	gum confirm "Do u wanna install Dotfiles and some other files? (y/n): " && dot="yes" || dot="no"

	case "$dot" in

	yes)
		wallpaper=~/.config/backgrounds/Batman.png
		conf=~/.config
		usr=/usr/bin
		bash=mybash/
		user=$(whoami)

		cd HackBG/ || return
		gum spin --spinner line --title="Installing the configs Wait a few Seconds :: " sleep 1
		cp -r .config/ ~
		cd conf/ || return
		sudo cp -r pacman.conf brave/ proxychains.conf /etc
		echo -e "[+] Copied pacman.conf brave/ proxychains.conf to /etc\n"
		cd ../
		cd gtk/ || return
		cp -r gtk-3.0/ gtk-4.0/ nwg-look/ $conf
		cp .gtkrc-2.0 ~
		echo "[+] Copied gtk-3.0/ gtk-4.0/ nwg-look/ to $conf"
		echo -e "\n[+] Copied .gtkrc-2.0 to $user\n"
		cd ../
		cd $bash || return
		cp starship.toml $conf
		cp .bashrc .bash_profile ~
		echo "[+] Copied starship.toml to $conf"
		echo -e "\n[+] Copied .bashrc .bash_profile to $user\n"
		cd ../
		gum spin --spinner line --title="Installing the configs Wait a few Seconds :: " sleep 1
		echo "[+] Loading pywal colors"
		wal -q -e -i $wallpaper
		echo -e "\n[+] Setting the global font to be MesloLGL Nerd Font Bold with font size to be 11"
		gsettings set org.gnome.desktop.interface font-name 'MesloLGL Nerd Font Bold 11'
		echo -e "\n[+] Setting GTK Theme to be Graphite-Dark"
		gsettings set org.gnome.desktop.interface gtk-theme 'Graphite-Dark'
		echo -e "\n[+] Setting icon theme to be Tela-circle-black-dark"
		gsettings set org.gnome.desktop.interface icon-theme Tela-circle-black-dark
		echo -e "\n[+] Updating Icon Cache"
		sudo gtk-update-icon-cache /usr/share/icons/Tela-circle-black-dark/
		echo -e "\n[+] swww-daemon activated with wallpaper"
		swww-daemon 2>/dev/null &
		if [ ! -z "$WAYLAND_DISPLAY" ];then
			swww img --transition-step 225 --transition-type center --transition-duration 2 --transition-fps 90 --transition-angle 0 "$wallpaper"
		else
			echo -e "\n[+] Installation script is running on tty so manually set wallpaper after Installation of the script"
		fi
		echo -e "\n[+] Installing the default needed extensions for vscodium"
		sh ~/HackBG/src/vscodium.sh
		echo -e "\n[+] Initialising manpage databases\n"
	  sudo mandb 2>/dev/null
		echo -e "\n[+] Copied and Initialised Dotfiles and themes successfully ::"
		sleep 2
		echo
		gum spin --spinner line --title="Chmoding the Executable files.. :: " sleep 1.2
		cd src/ || return
		sudo cp rofi-power-menu $usr
		echo "[+] Copied rofi-power-menu to $user"
		sudo chmod +x restore.sh
		echo -e "\n[+] chmoding restore.sh"
		cd $conf/waybar/scripts/ || return
		sudo chmod +x ani-cli.sh disk_script.sh
		echo -e "\n[+] chmoding ani-cli.sh disk_script.sh"
		cd $conf/hypr/settings || return
		sudo chmod +x battery_alert.sh man.sh performance_mode.sh swapwindow.sh aur.sh rmaur.sh waybar_toggle.sh screenshot.sh wallpaper_fetch.sh random_wallpaper.sh night_light.sh
		echo -e "\n[+] chmoding battery_alert.sh man.sh performance_mode.sh swapwindow.sh random_wallpaper.sh"
		echo -e "\n[+] chmoding aur.sh rmaur.sh waybar_toggle.sh screenshot.sh wallpaper_fetch.sh"
		cd $conf/hypr/menu || return
		sudo chmod +x animation_switch.sh aur.sh rofi.sh timeshift.sh update.sh waybar.sh wallpaper.sh tools.sh 
		echo -e "\n[+] chmoding animation_switch.sh aur.sh rofi.sh timeshift.sh update.sh waybar.sh wallpaper.sh tools.sh"
		cd tools/ || return
		sudo chmod +x check.sh details.sh password.sh practice.sh metasploitable.sh 
		echo -e "\n[+] chmoding check.sh details.sh password.sh practice.sh"
		cd $conf/hypr/animations/scripts/ || return
		sudo chmod +x disabled.sh fast_popin.sh fast_slide.sh
		echo -e "\n[+] chmoding disabled.sh fast_popin.sh fast_slide.sh"
		cd ~ || return
		sudo chmod +x $usr/rofi-power-menu
		echo -e "\n[+] chmoding rofi-power-menu\n\n"
		echo "[+] Chmoding the Executable files was Successfull"
		sleep 0.4
		echo

		clear
		return
		;;
	no)
		clear
		return
		;;

	esac

}

rofi_check() {

	my_dir=~/.config/rofi/

	if [ -d my_dir ]; then
		mkdir -p ~/.config/rofi
	fi

	cd $my_dir || return

	my_file=config.rasi

	cd themes/ || return

	echo -e "\nselect a rofi theme listed below: \n"

	image=$(echo -e "normal-style\nimage-style\nExit" | gum choose)

	case "$image" in
	image-style)
		if [ -f "$my_file" ]; then
			rm "$my_file"
		fi
		cd rofi-image-style || return
		cp "$my_file" "$my_dir"
		clear
		gum spin --spinner dot --title="Successfully Updated the Theme ::" sleep 3.4
		clear
		cd ~ || return
		return
		;;
	normal-style)
		my_dir=~/.config/rofi/
		my_file=config.rasi
		if [ -f $my_file ]; then
			rm $my_file
		fi
		cd $my_dir || return
		cd themes/ || return
		cd rofi-style || return
		cp $my_file $my_dir
		clear
		gum spin --spinner dot --title="Successfully Updated the Theme ::" sleep 3.4
		clear
		return
		;;
	Exit)
		return
		;;
	esac

}

install_dots

rofi_check
