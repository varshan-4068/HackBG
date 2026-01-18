#!/usr/bin/env bash

set -e

waybar_theme() {

	update=~/.config/hypr/menu/update.sh
	bar=~/.config/hypr/menu/waybar.sh
	theme=$(echo -e "Dark-Pywal-theme\nColorful-Pywal-theme\nMinimal-Pywal-theme\nModern-Pywal-theme\nBack\nQuit" | gum choose)

	case "$theme" in
	Dark-Pywal-theme)
		cd ~/.config/waybar/
		if [ -f config ] && [ -f style.css ]; then
			rm config style.css
		fi
		position_1=$(echo -e "Top\nBottom\nBack\n" | gum choose)
		case "$position_1" in
		Top)
			cd ~/.config/waybar/'style.css collections'/'dark pywal style'/'top'/
			cp config style.css ~/.config/waybar/
			return
			;;
		Bottom)
			cd ~/.config/waybar/'style.css collections'/'dark pywal style'/'bottom'/
			cp config style.css ~/.config/waybar/
			return
			;;
		Back)
			sh $bar
			return
			;;
		esac
		echo
		echo " :: Successfully installed the configuration files of Dark pink theme ::"
		sleep 0.2
		echo
		sh $update
		return
		;;
	Colorful-Pywal-theme)
		cd ~
		if [ -f config ] && [ -f style.css ]; then
			rm config style.css
		fi
		position_2=$(echo -e "Top\nBottom\nBack\n" | gum choose)
		case "$position_2" in
		Top)
			cd ~/.config/waybar/'style.css collections'/'colourful pywal style'/'top'/
			cp config style.css ~/.config/waybar/
			return
			;;
		Bottom)
			cd ~/.config/waybar/'style.css collections'/'colourful pywal style'/'bottom'/
			cp config style.css ~/.config/waybar/
			return
			;;
		Back)
			sh $bar
			return
			;;
		esac
		echo
		echo " :: Successfully installed the configuration files of Colorful Waybar theme ::"
		sleep 0.2
		echo
		sh $update
		return
		;;
	Minimal-Pywal-theme)
		cd ~
		if [ -f config ] && [ -f style.css ]; then
			rm config style.css
		fi
		position_3=$(echo -e "Top\nBottom\nBack\n" | gum choose)
		case "$position_3" in
		Top)
			cd ~/.config/waybar/'style.css collections'/'minimal pywal style'/'top'/
			cp config style.css ~/.config/waybar/
			return
			;;
		Bottom)
			cd ~/.config/waybar/'style.css collections'/'minimal pywal style'/'bottom'/
			cp config style.css ~/.config/waybar/
			return
			;;
		Back)
			sh $bar
			return
			;;
		esac
		echo
		echo " :: Successfully installed the configuration files of Minimal Waybar theme ::"
		sleep 0.2
		echo
		sh $update
		return
		;;
	Modern-Pywal-theme)
		cd ~
		if [ -f config ] && [ -f style.css ]; then
			rm config style.css
		fi
		position_2=$(echo -e "Top\nBottom\nBack\n" | gum choose)
		case "$position_2" in
		Top)
			cd ~/.config/waybar/'style.css collections'/'modern pywal style'/'top'/
			cp config style.css ~/.config/waybar/
			return
			;;
		Bottom)
			cd ~/.config/waybar/'style.css collections'/'modern pywal style'/'bottom'/
			cp config style.css ~/.config/waybar/
			return
			;;
		Back)
			sh $bar
			return
			;;
		esac
		echo
		echo " :: Successfully installed the configuration files of Modern Waybar theme ::"
		sleep 0.2
		echo
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

waybar_theme
