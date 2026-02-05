#!/usr/bin/env bash

rofi() {

	my_dir=~/.config/rofi/
	update=~/.config/hypr/menu/update.sh

	if [ -d my_dir ]; then
		mkdir -p ~/.config/rofi
	fi

	cd $my_dir || return

	my_file=config.rasi

	cd themes/ || return

	image=$(echo -e "normal-style\nimage-style\nBack\nQuit\n" | gum choose)

	case "$image" in
	image-style)
		if [ -f $my_file ]; then
			rm my_file
		fi
		cd rofi-image-style || return
		cp $my_file $my_dir
		echo "==> Successfully Updated the Theme "
		sleep 0.5
		sh $update
		;;

	normal-style)
		if [ -f $my_file ]; then
			rm my_file
		fi
		cd rofi-style || return
		cp $my_file $my_dir
		echo "==> Successfully Updated the Theme "
		sleep 0.5
		sh $update
		return
		;;
	Back)
		sh $update
		return
		;;
	Quit)
		exit 0
		;;
	esac
}

rofi
