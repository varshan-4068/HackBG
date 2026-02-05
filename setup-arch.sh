#!/usr/bin/env bash

#install scripts directory
dot_dir=$HOME/HackBG/src

virt_dir=$HOME/HackBG/qemu

plugin_dir=$HOME/HackBG/plugins

blackarch_dir=$HOME/HackBG/blackarch/

Error() {
	WARNING="$(tput setaf 1)"
	RESET="$(tput sgr0)"
	ERROR="$(tput setaf 1)[ERROR]${RESET}"

	if [[ $EUID -eq 0 ]]; then
		echo "${ERROR}  This script should ${WARNING}NOT${RESET} be executed as root!! Exiting...."
		exit 1
	fi
}

Error

#logo
sh "$dot_dir"/print_logo.sh

#exit if any issues..
set -e

echo

#sourcing backup script
sh "$dot_dir"/backup.sh

cd ~

#sourcing blackarch repo for arch users using kali linux
sh "$blackarch_dir"/repo_add.sh

#sourcing pacman needed packages installation scripts..
sh "$dot_dir"/pacman.sh

sh "$dot_dir"/aur.sh 

sh "$dot_dir"/optional_pacman.sh 

#sourcing ani-cli installation tool.
sh "$dot_dir"/ani-cli.sh

#sourcing the systemservices enabling script like nm and bluetooth.
sh "$dot_dir"/systemservice.sh

sh "$virt_dir"/qemu-setup.sh

cd ~

#sourcing the dotfiles folder to install the dotfiles
sh "$dot_dir"/dotfiles.sh

#sourcing the plugins scripts
sh "$plugin_dir"/plugin.sh

#sourcing the root folder to install the dotfiles in root directory
sh "$dot_dir"/root.sh

#sourcing aur needed packages installation scripts..
sh "$dot_dir"/browser.sh

#ufw script
sh "$dot_dir"/ufw.sh

#grub themes script..
sh "$dot_dir"/grub.sh

#sddm theme script..
sh "$dot_dir"/sddm.sh

clear

sh "$dot_dir"/../fix.sh

#reboot script to take changes effectively
sh "$dot_dir"/reboot.sh

clear

gum spin --spinner dot --title="For restoring your configs run restore.sh from $dot_dir " sleep 2.41

clear
