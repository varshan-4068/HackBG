#!/usr/bin/env bash

browser=(
	librewolf-bin #decent browser..
	qutebrowser   #recommneded for vim or nvim users but still a decent browser..
	firefox       #good browser..
	chromium      #good browser but still not better..
)

echo -e "\n[+] Brave Browser is installled by default\n"

choice=$(echo -e "yes\nno" | gum choose --header="Do u want to install optional browser: ")

check(){
	local cout=0
	local max_attempts=3
	while ((cout < max_attempts)); do
		echo -e "\n[+] Installing selected optional browsers (attempt $((cout + 1))/$max_attempts)\n"
		echo "$selected" | xargs -ro paru -Sy --needed
		if [ $? -eq 0 ]; then
			echo -e "\n[+] All packages installed successfully"
			return 0
		fi

		(( cout++ ))
		echo -e "\n[-] Installation failed"
	done
	echo -e "\nThere may be network error or some conflicting packages found please fix it and retry installation script accordingly"
	echo -e "Tips to follow: \n"
	echo "1.Check the internet connection and retry the installation script by running sh setup-arch.sh"
	echo "2.Check for any conflicting packages like for example hyprland-git and hyprland are conflicting packages"
	echo -e "3.May have not answered the prompted questions Properly or Pressed CTRL + C unnecessarily\n"
}

_install_browser() {
	selected=$(printf "%s\n" "${browser[@]}" | gum choose --no-limit --header "Select optional browsers to install: ")

	if [ -z "$selected" ]; then
		sh ~/HackBG/src/browser.sh
	fi

	echo -e "\n[+] You had selected:\n\n$selected\n"

	check

	echo

	installed=$(pacman -Qq | grep "$selected" )

	echo -e "\n[+] You had installed these browsers:\n\n$installed\n"

	browsers=(
		"$installed"
	)

	selected_browser=$(printf "%s\n" "${browsers[@]}" | gum choose --header "Select the browser to be set as default: ")

	case "$selected_browser" in
		qutebrowser)
			xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop
			;;
		chromium)
			xdg-settings set default-web-browser chromium.desktop
			;;
		librewolf-bin)
			xdg-settings set default-web-browser librewolf.desktop
			;;
		firefox)
			xdg-settings set default-web-browser firefox.desktop
			;;
		brave-bin)
			xdg-settings set default-web-browser brave-browser.desktop
			;;
		*)
			echo -e "\nNo Installed Browser is set as default"
	esac
	if [ -z "$selected_browser" ];then
		echo "$selected_browser is set as default web browser"
	fi
}

case "$choice" in

	yes)
		_install_browser
		;;
	no)
		;;
esac
