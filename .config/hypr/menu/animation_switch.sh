#!/usr/bin/env bash

select_animations=$(echo -e "fast-slide\nfast-popin\ndisable\nBack\nQuit" | gum choose --header="Change animations: ")
menu=~/.config/hypr/menu/update.sh

animation_dir=~/.config/hypr/animations/scripts

case "$select_animations" in

fast-slide)
	sh $animation_dir/fast_slide.sh
	;;
fast-popin)
	sh $animation_dir/fast_popin.sh
	;;
disable)
	sh $animation_dir/disabled.sh
	;;
Back)
	sh $menu
	;;
Quit)
	exit 0
	;;
esac
