#!/usr/bin/env bash

aur() {
	cat <<"EOF"
 ____            _                   _   _           _       _
/ ___| _   _ ___| |_ ___ _ __ ___   | | | |_ __   __| | __ _| |_ ___
\___ \| | | / __| __/ _ \ '_ ` _ \  | | | | '_ \ / _` |/ _` | __/ _ \
 ___) | |_| \__ \ ||  __/ | | | | | | |_| | |_) | (_| | (_| | ||  __/
|____/ \__, |___/\__\___|_| |_| |_|  \___/| .__/ \__,_|\__,_|\__\___|
       |___/                              |_|

EOF
}

clear
aur

color7=$(tput setaf 7)
color1=$(tput setaf 2)
color2=$(tput setaf 3)
VERSION=$(hyprland -v | grep "Hyprland" | awk '{print $2}')
COMMIT_ID=$(hyprland -v | grep -oP 'commit\s+\K[0-9a-f]{40}')
LAST_UPDATED=$(stat /var/lib/pacman/local/ | grep "Modify" | awk '{print "Date: " $2 "\n" "Time: " $3 }' | cut -d'.' -f1)
LAST_SYNC=$(stat /var/lib/pacman/sync/ | grep "Modify" | awk '{print "Date: " $2 "\n" "Time: " $3 }' | cut -d'.' -f1)

if [ ! -z "$LAST_UPDATED" ];then
	echo -e "${color1}══ Last Updated Info ══"
	echo -e "${color2}$LAST_UPDATED\n"
fi

if [ ! -z "$LAST_SYNC" ];then
	echo -e "${color1}══ Last Database Sync Info ══"
	echo -e "${color2}$LAST_SYNC\n"
fi

if [ ! -z "$VERSION" ];then
	echo -e "${color1}══ Hyprland version: ${color2}$VERSION ${color1}══\n"
	echo -e "${color1}══ Commit ID: ${color2}$COMMIT_ID ${color1}══${color7}\n"
fi

paru_aur=/usr/bin/paru

error_aur() {
	Error_root() {
		WARNING="$(tput setaf 1)"
		RESET="$(tput sgr0)"
		ERROR="$(tput setaf 1)[ERROR]${RESET}"

		if [[ $EUID -eq 0 ]]; then
			echo "${ERROR}  This script should ${WARNING}NOT${RESET} be executed as root!! Exiting...."
			exit 1
		fi
	}
	if [ ! -f "$paru_aur" ]; then
		echo " :: $paru_aur not found ! Installing paru (AUR HELPER) ::"
		echo
		git clone https://aur.archlinux.org/paru.git
		cd paru/ || return
		makepkg -si
		sudo rm -r ~/paru/
		cd ~ || return
	fi
}

aur_update() {

	echo "${color1}Do u wanna update ur packages (yes/no): ${color7}"
	echo

	aur=$(echo -e "yes\nno" | gum choose)
	update=~/.config/hypr/menu/update.sh

	case "$aur" in

	yes)
		paru -Syu --noconfirm
		echo
		paru -Scc
		echo
		hyprpm update
		sleep 1
		echo
		echo -e "[+] AUR & Pacman Update Complete\n"
		read -rp "Press Enter to Close"
		sh $update
		return
		;;
	no)
		sh $update
		return
		;;
	esac

}

error_aur

Error_root

aur_update

