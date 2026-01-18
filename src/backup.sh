#!/usr/bin/env bash

backup=~/backup/
config=~/.config/
local=~/.local/

backupsh() {
	gum spin --spinner line --title="Backuping your configs in $backup" sleep 3
	cd ~ || return

	if [ -d $backup ]; then
		sudo rm -r $backup
		echo
		echo "[+] Removing existing Backup File"
	fi
	echo

	mkdir $backup
	echo "[+] Creating a new directory $backup"

	if [ $config ]; then
		cp -r $config $backup
		echo
		echo "[+] Copied $config to $backup"
	fi 

	if [ $local ]; then
		cp -r $local $backup
		echo
		echo "[+] Copied $config to $backup"
	fi
}

backupsh

snap() {
	echo
	gum confirm "Do u wanna snapshot your system with timeshift ?" && snapshot="yes" || snapshot="no"

	case "$snapshot" in
	yes)
		comment=$(gum input --placeholder "Enter a comment for the snapshot...")
		sudo timeshift --create --comments "$comment"
		sudo timeshift --list
		sudo grub-mkconfig -o /boot/grub/grub.cfg
		echo
		return
		;;
	no)
		return
		;;
	esac
}

snap
