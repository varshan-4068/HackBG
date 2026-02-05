#!/usr/bin/env bash

sddm() {

	gum style \
		--align center \
		--bold \
		"
		 _______  ______   ______   __   __    _______  __   __  _______  __   __  _______  _______ 
		|       ||      | |      | |  |_|  |  |       ||  | |  ||       ||  |_|  ||       ||       |
		|  _____||  _    ||  _    ||       |  |_     _||  |_|  ||    ___||       ||    ___||  _____|
		| |_____ | | |   || | |   ||       |    |   |  |       ||   |___ |       ||   |___ | |_____ 
		|_____  || |_|   || |_|   ||       |    |   |  |       ||    ___||       ||    ___||_____  |
		 _____| ||       ||       || ||_|| |    |   |  |   _   ||   |___ | ||_|| ||   |___  _____| |
		|_______||______| |______| |_|   |_|    |___|  |__| |__||_______||_|   |_||_______||_______|

"
}

clear
sddm

echo "----------------------------------------------------------------------------------------------------------------"
echo
echo "                                     :: Maldives Inspired sddm theme = M  ::                                    "
echo
echo "                                     :: sddm-astronaut-theme = S          ::                                    "
echo
echo "                                     :: To Cancel the Script = n          ::                                    "
echo
echo
echo "----------------- Above Listed Are the Codes to Select your choice of theme on the prompt below ----------------"
echo

sddm_themes() {
	echo

	sddm_theme=$(echo -e "M\nS\nn" | gum choose)

	case "$sddm_theme" in
	S)
		echo
		sudo cp ~/HackBG/sddm/sddm.conf /etc
		echo "[+] Copied sddm.conf to /etc"
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"
		if [ -d "/usr/share/sddm/themes/sddm-astronaut-theme" ]; then
			notify-send "sddm-astronaut-theme was installed successfully!"
		fi
		echo
		echo "[+] Everything is Installed perfectly just reboot your system to get perfect results ::"
		echo
		echo
		return
		;;
	M)
		echo
		sudo cp ~/HackBG/sddm/sddm.conf /etc
		echo "[+] Copied sddm.conf to /etc"
		sudo cp -r ~/HackBG/sddm/sddm-theme/ /usr/share/sddm/themes/
		echo 
		echo "[+] Copied sddm-theme/ to /usr/share/share/sddm/themes/"
		gum spin --spinner line --title="Installing the maldives Inspired sddm theme.." sleep 3.8
		echo
		if [ -d "/usr/share/sddm/themes/sddm-theme" ]; then
			notify-send -t 3400 "sddm-theme was installed successfully!"
		fi
		echo "[+] Everything is Installed perfectly just reboot your system to get perfect results ::"
		echo
		echo
		return
		;;
	n)
		echo
		echo "[+] Everything is Installed perfectly just reboot your system to get perfect results ::"
		echo
		echo
		return
		;;
	esac

}

sddm_enable() {
	systemctl enable sddm.service
}

delete() {

	gum confirm "Do u wanna delete the directory HackBG/ that has been cloned to your system? (y/n): " && del="yes" || del="no"

	case "$del" in
	yes)
		cd ~ || return
		sudo rm -r HackBG/
		echo
		echo
		echo "[+] Deleted the HackBG/ directory successfully ::"
		echo
		echo
		sleep 1.2
		clear
		return
		;;
	no)
		clear
		return
		;;
	esac
}

sddm_themes
sddm_enable
delete
