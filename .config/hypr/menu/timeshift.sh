#!/usr/bin/env bash

set -e

roll() {
	cat <<"EOF"

 _____ _                     _     _  __ _
|_   _(_)_ __ ___   ___  ___| |__ (_)/ _| |_
  | | | | '_ ` _ \ / _ \/ __| '_ \| | |_| __|
  | | | | | | | | |  __/\__ \ | | | |  _| |_
  |_| |_|_| |_| |_|\___||___/_| |_|_|_|  \__|


EOF
}
clear
roll

timeshift_package=/usr/bin/timeshift
paru_aur=/usr/bin/paru
autosnap=/usr/bin/timeshift-autosnap

dependencies=(
	timeshift
	timeshift-autosnap
)

if [ ! -f "$timeshift_package" ] || [ ! -f "$autosnap" ]; then
	if [ -f "$paru_aur" ]; then
		paru -S "${dependencies[@]}" --needed
	else
		Error() {
			WARNING="$(tput setaf 1)"
			RESET="$(tput sgr0)"
			ERROR="$(tput setaf 1)[ERROR]${RESET}"

			if [[ $EUID -eq 0 ]]; then
				clear
				echo "${ERROR}  This script should ${WARNING}NOT${RESET} be executed as root!! Exiting...."
				sleep 1.4
				exit 1
			fi
		}

		Error

		echo " :: $paru_aur not found ! Installing paru (AUR HELPER) ::"
		git clone https://aur.archlinux.org/paru.git
		cd paru/ || return
		makepkg -si
		sudo rm -r ~/paru/
		cd ~ || return

		paru -S "${dependencies[@]}" --needed

	fi
fi

update=~/.config/hypr/menu/update.sh

timeshift_select=$(echo -e "Snapshot\nRestore\nDelete\nBack\nQuit\n" | gum choose)

case "$timeshift_select" in

Snapshot)

	timeshift_backup() {
		echo
		comment=$(gum input --placeholder "Enter a comment for the snapshot...")
		sudo timeshift --create --comments "$comment"
		sudo timeshift --list
		sudo grub-mkconfig -o /boot/grub/grub.cfg
	}
	timeshift_backup
	sh $update
	return
	;;

Restore)

	timeshift_restore() {
		echo
		sudo timeshift --restore
		sudo grub-mkconfig -o /boot/grub/grub.cfg
		sleep 0.4
	}
	timeshift_restore
	sh $update
	return
	;;

Delete)

	timeshift_delete() {
		echo
		sudo timeshift --delete
		sudo grub-mkconfig -o /boot/grub/grub.cfg
		sleep 0.4
	}
	timeshift_delete
	sh $update
	return
	;;

Back)
	sh $update
	;;
Quit)
	exit 0
	;;
esac
