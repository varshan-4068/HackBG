#!/usr/bin/env bash

reboot() {

	gum style \
		--align center \
		--bold \
		--margin "2" \
		--padding "0 20 0 20" \
		--border rounded \
		"
 ______    _______  _______  _______  _______  _______ 
|    _ |  |       ||  _    ||       ||       ||       |
|   | ||  |    ___|| |_|   ||   _   ||   _   ||_     _|
|   |_||_ |   |___ |       ||  | |  ||  | |  |  |   |  
|    __  ||    ___||  _   | |  |_|  ||  |_|  |  |   |  
|   |  | ||   |___ | |_|   ||       ||       |  |   |  
|___|  |_||_______||_______||_______||_______|  |___|  
"
}

clear
reboot

reboot_system() {
	echo

	gum confirm "Do u wanna reboot ur system? (y/n): " && choose="yes" || choose="no"

	case "$choose" in
	yes)
		echo "[+] Rebooting ur system now....."
		systemctl reboot
		sleep 4
		return
		;;
	no)
		clear
		return
		;;
	esac
}

reboot_system
