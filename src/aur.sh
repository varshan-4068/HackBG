#!/usr/bin/env bash

paru=(
	hyprshot                             #screenshot utility
	timeshift-autosnap                   #timeshift snapshot automation
	graphite-gtk-theme-black-rimless-git #gtk theme must
	kvantum-theme-daemon-git						 #qt apps theme with kvantum
	bibata-cursor-theme-bin              #bibata-modern-ice cursor theme dependencies
	nautilus-image-converter             #extension for nautilus
	vscodium-bin                         #codium is an open source project of Microsoft's vscode
	localsend-bin                        #tool used for transfering files
	brave-bin  													 #brave browser
	battop-bin                           #battery stats
	multitail                            #must
	python-pywal16-git                   #pywal
	sc-im                                #spreedsheet vim based
	gtk-engine-murrine           				 #must for gtk colorscheme to work
)

paru_aur() {

	if [ -f /usr/bin/paru ]; then
		package_install
	else
			echo "[+] Installing Paru ( AUR helper )"
			echo
			git clone https://aur.archlinux.org/paru.git ~/paru/
			cd paru/ || return 1
			makepkg -si || return 1
			sudo rm -r ~/paru/
			cd ~ || return 1
			echo
			echo
			return
	fi
}

package_install() {
		local cout=0
		local max_attempts=3
		while (( cout < max_attempts )); do
			echo
			echo "[+] Installing AUR packages (attempt $((cout + 1))/$max_attempts)"
			echo
			trap 'echo' SIGINT
			paru -S --needed "${paru[@]}"
			if [[ $? -eq 0 ]];then
				trap - SIGINT
				echo -e "\n[+] All packages installed successfully"
				return 0
			fi
			trap - SIGINT
			((cout++))
			echo -e "\n[-] Installation failed"
		done
		echo
		echo "There may be network error or some conflicting packages found please fix it and retry installation script accordingly"
		echo "Tips to follow: "
		echo
		echo "1.Check the internet connection and retry the installation script by running sh setup-arch.sh"
		echo "2.Check for any conflicting packages like for example hyprland-git and hyprland are conflicting packages"
		echo "3.May have not answered the prompted questions Properly or Pressed CTRL + C unnecessarily"
		echo
		return 1
}

paru_aur
