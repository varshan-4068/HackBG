#!/usr/bin/env bash

aur() {
	cat <<"EOF"


   █████╗ ██╗   ██╗██████╗     ███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗██████╗ 
  ██╔══██╗██║   ██║██╔══██╗    ████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝██╔══██╗
  ███████║██║   ██║██████╔╝    ██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██████╔╝
  ██╔══██║██║   ██║██╔══██╗    ██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██╔══██╗
  ██║  ██║╚██████╔╝██║  ██║    ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║  ██║
  ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝



EOF
}

clear
aur

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

	echo "==> Do u wanna update ur packages (yes/no): "
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
		notify-send -t 3000 "AUR & Pacman Update Complete"
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

