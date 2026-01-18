#!/usr/bin/env bash

boot() {

	gum style \
		--align center \
		--bold \
		"
		 _______  ______    __   __  _______    _______  __   __  _______  __   __  _______  _______ 
		|       ||    _ |  |  | |  ||  _    |  |       ||  | |  ||       ||  |_|  ||       ||       |
		|    ___||   | ||  |  | |  || |_|   |  |_     _||  |_|  ||    ___||       ||    ___||  _____|
		|   | __ |   |_||_ |  |_|  ||       |    |   |  |       ||   |___ |       ||   |___ | |_____ 
		|   ||  ||    __  ||       ||  _   |     |   |  |       ||    ___||       ||    ___||_____  |
		|   |_| ||   |  | ||       || |_|   |    |   |  |   _   ||   |___ | ||_|| ||   |___  _____| |
		|_______||___|  |_||_______||_______|    |___|  |__| |__||_______||_|   |_||_______||_______|

"
}

clear
boot

grub() {
	echo

	if gum confirm "Do u wanna install grub themes by ChrisTitusTech? (y/n): ";then
		echo
		cd ~ || return
		if [ -d ~/Top-5-Bootloader-Themes/ ]; then
			echo "[+] Top-5-Bootloader-Themes is already cloned in your system"
			echo
			echo
			cd ~/Top-5-Bootloader-Themes/ || return
			sudo ./install.sh ## then select the theme u wanted to install
			cd ~ || return
			return
		else
			echo "[+] Cloning Themes"
			echo
			git clone https://github.com/ChrisTitusTech/Top-5-Bootloader-Themes.git
			cd ~/Top-5-Bootloader-Themes/ || return
			sudo ./install.sh ## then select the theme u wanted to install
			cd ~ || return
			return
		fi
	else
		return
	fi
}

grub
