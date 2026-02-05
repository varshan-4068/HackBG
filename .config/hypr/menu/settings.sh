#!/usr/bin/env bash

select=$(echo -e "Animations\nGestures\nInstall\nDefault\nUninstall\nBack\nQuit" | gum choose --header="Settings Menu: ")
menu=~/.config/hypr/menu

case "$select" in
	Animations)
		sh $menu/animation_switch.sh
		;;
	Gestures)
		sh $menu/gesture.sh
		;;
	Install)
		sh $menu/install.sh
		;;
	Default)
		sh $menu/default.sh
		;;
	Uninstall)
		sh $menu/uninstall.sh
		;;
	Back)
		sh $menu/update.sh
		;;
	Quit)
		exit 0
		;;
esac
