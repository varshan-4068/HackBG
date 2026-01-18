#!/usr/bin/env bash

performance_mode=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
default=$(cat ~/.config/hypr/animations.conf | grep enabled | awk '{print $3}')
power=$(powerprofilesctl get)

case "$performance_mode" in

1)
	killall dunst

	if [ "$power" == 'power-saver' ]; then
		notify-send -t 2000 "You are in performance mode" "Press SUPER + SHIFT + P To Enter into power-saver Mode"
		powerprofilesctl set performance
		hyprctl --batch "\
		 keyword animations:enabled 0;\
        keyword decoration:shadow:enabled 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0"
	fi
	;;

0)
	killall dunst

	if [ "$default" == '0' ]; then

		if [ "$power" == 'power-saver' ] || [ "$power" == 'balanced' ] ; then
			powerprofilesctl set performance
			notify-send -t 3000 "You have disabled your animations by default" "Setting to use performance mode"
			hyprctl --batch "\
				 keyword animations:enabled 0;\
						keyword decoration:shadow:enabled 0;\
						keyword decoration:blur:enabled 0;\
						keyword general:gaps_in 0;\
						keyword general:gaps_out 0;\
						keyword general:border_size 1;\
						keyword decoration:rounding 0"
		fi

		if [ "$power" != 'power-saver' ]; then
			powerprofilesctl set power-saver
			notify-send -t 3000 "You have disabled your animations by default" "Setting to use power-saver mode"
			hyprctl reload
		fi

	fi

	if [ "$default" != '0' ]; then
		if [ "$power" == 'power-saver' ] || [ "$power" == 'balanced' ]; then
			powerprofilesctl set performance
			notify-send -t 3000 "You are in performance mode" "Press SUPER + SHIFT + P To Enter into power-saver Mode"
			hyprctl --batch "\
				 keyword animations:enabled 0;\
						keyword decoration:shadow:enabled 0;\
						keyword decoration:blur:enabled 0;\
						keyword general:gaps_in 0;\
						keyword general:gaps_out 0;\
						keyword general:border_size 1;\
						keyword decoration:rounding 0"
		fi

		if [ "$power" != 'power-saver' ]; then
			powerprofilesctl set power-saver
			notify-send -t 3000 "You are in power-saver mode" "Press SUPER + SHIFT + P To Enter into performance Mode"
			hyprctl reload
		fi

	fi
	;;

esac

exit
