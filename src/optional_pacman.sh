#!/usr/bin/env bash

optional=(
	collision          #check hashes or like checksum of the files like .iso or .zip
	video-trimmer      #trim a video
	pdfslicer          #delete or merge some pages of a pdf..
	telegram-desktop   #telegram for arch btw
	decoder            #generate or scan a QRcode
	morphosis          #convert some format like .docx to pdf u can use this
	cameractrls        #for taking good quality pictures
	gnome-software     #install flatpaks with gui's..
	gnome-disk-utility #disk utility
	flatpak            #package manager
	obsidian           #note taking
	obs-studio				 #video recording and streaming
	tmux               #terminal session manager 
	dysk               #disk information in terminal
	cheese             #camera
	upscayl-bin        #AI Image Upscaler
	tldr               #command for beginner to learn usecases of commands
	libreoffice-fresh  #office tool
	onlyoffice-bin 		 #ui similar to microsoft office tools
	waypaper 					 #gtk wallpaper selector
	discord            #discord
	audacity					 #sound editor
	qalculate-gtk      #calculator
	gimp               #photo editing tool
	transmission-gtk   #torrent download manager 
	filelight          #file management
	impression         #iso file flash into pendrive
	fastfetch          #system information replacement to neofetch
)

echo

_install_optional() {
	selected=$(printf "%s\n" "${optional[@]}" | gum choose --no-limit --header "Select the needed optional packages to install: ")

	if [ -z "$selected" ]; then
		sh ~/HackBG/src/optional_pacman.sh
	fi

	echo -e "\n[+] You had selected:\n$selected"

	echo

	local cout=0
	local max_attempts=3
	while ((cout < max_attempts)); do
		echo
		echo "[+] Installing optional selected packages (attempt $((cout + 1))/$max_attempts)"
		echo
		echo "$selected" | xargs -ro paru -S --needed
		if [ $? -eq 0 ]; then
			echo -e "\n[+] All packages installed successfully"
			return 0
		fi

		(( cout++ ))
		echo
		echo "[-] Installation failed"
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

_install_optional
