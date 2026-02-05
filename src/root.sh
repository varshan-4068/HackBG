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

root_dots() {
	echo

	gum confirm "Do u wanna install Dotfiles and some other files in the root Directory ? (y/n): " && dots="yes" || dots="no"

	case "$dots" in
	yes)

		cd ~ || return
		cd HackBG/ || return
		echo
		echo "[+] Entered the HackBG Directory ::"
		echo
		cd root/ || return
		sudo cp .bashrc .bash_profile /root
		echo "[+] Copied ,bashrc .bash_profile to /root"

		if [ ! -d /root/.config/ ]; then
			sudo mkdir -p /root/.config/
			echo
			echo "[+] /root/.config/ not found, Intialising the /root/.config/ Directory"
		fi

		sudo cp -r nvim/ starship.toml alacritty/ /root/.config/
		echo 
		echo "[+] Copied nvim/ starship.toml alacritty/ to /root/.config/"
		echo
		echo "[+] Copied the Dotfiles successfully ::"
		echo
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

root_dots
