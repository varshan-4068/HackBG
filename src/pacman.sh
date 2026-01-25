#!/usr/bin/env bash

dependencies=(

	neovim                       #code or text editor
	curl                         #dependencies
	htop 												 #display's system stats
	wget                         #dependencies
	cmake 											 #dependencies for hyprpm
	eza                          #modern replacement for ls command
	7zip                         #file archiver for high compression
	z                            #best for tracking ur most used directory's
	less                         #dependencies
	nmap												 #network mapping tool
	systemctl-tui								 #tui for managing systemd services	
	grub-btrfs  								 #btrfs snapshots on grub menu
	wireshark-qt 								 #network analyser
	burpsuite										 #burpsuite tool community free edition
	gum                          #dependencies for running install script
	base-devel                   #basic packages
	wl-clipboard                 #clipboard
	swayosd                      #swayosd for to control brightness,volume,etc.
	cliphist                     #clipboard history
	satty                        #screenshot editing tool
	eog                          # used as a picture gallery
	eog-plugins                  # eog plugins
	dunst                        #notification daemon
	scrcpy                       #android phone screen mirroring tool
	btop                         #modern system monitor
	udiskie                      #other disk mount automatically
	mission-center               #gtk based system monitor looks similar to task manager in windows os
	spotify-launcher             #music player
	playerctl										 #obtains the details about currently playing song
	tela-circle-icon-theme-black #icon theme
	shellcheck                   #must for nvim bash linter
	nautilus                     #file manager
	ntfs-3g                      #ntfs filesystem support
	bat                          #modern replacement for cat command
	gcc                          #c language complier must for nvim plugins..
	blackarch-officials					 #most popular blacharch tools
	make                         #dependencies
	alacritty                    #terminal
	python                       #needed for running python script
	starship                     #gives beautiful look for the shell prompt
	npm                          #must for installing nvim plugins like lsp formatters,etc
	go                           #needed for nvim plugins updation or installation
	fzf                          #fuzzy finding tool
	polkit-gnome                 #needed for good ui while asking sudo permissions like for mounting the disk..
	axel                         #downloading files via terminal usinng the link
	ncdu                         #one of the good file manager in terminal
	yazi                         #terminal file manager
	rofi-wayland                 #rofi app launcher for wayland
	ufw                          #firewall
	os-prober                    #needed for dual booting with some other os
	pavucontrol                  #sound
	otf-font-awesome             #font
	lsb-release                  #for timeshift to figre out the dstro details
	ttf-meslo-nerd               #must for gtk apps
	python-adblock               #adblocker
	python-pynvim                #dependencies
	pipewire                     #sound
	pipewire-alsa                #sound
	pipewire-jack                #sound
	pipewire-pulse               #sound
	polkit-kde-agent             #kde-agent
	power-profiles-daemon        #must for laptops battery power management
	trash-cli                    #useful tool must for removing files via terminal i had aliased it with rm command
	yt-dlp                       #needed for playing youtube videos in mpv via qutebrowser or any browser
	ttf-jetbrains-mono           #needed for terminal
	ttf-fira-code                #needed for waybar fonts
	ttf-jetbrains-mono-nerd      #needed for nerd font kitty terminal
	net-tools                    #network tools
	zoxide                       #stores our previous visited or modified directories in fzf so that we can navigate to that directory next time easily with fzf
	timeshift                    #backup tool
	thermald                     #thermal management
	mpv                          #video player
	papirus-icon-theme					 #icon theme for waybar
	blueman                      #bluetooth
	swappy                       #image viewer
	pamixer                      #sound
	network-manager-applet       #wifi or ethernet or vpn
	nwg-displays                 #must for checking or adjusting resolutions via gui
	nwg-look                     #used for switching between gtk and cursor, icon themes..
	swww                         #modern wallpaper engine with animations
	sddm                         #login manager
	bash-completion              #bash completion
	ntp                          #network time protocol
	brightnessctl                #brightness management
	acpi                         #must
	imagemagick                  #awesome tool to convert png to jpg ,compress images
	tree                         #used for viewing the parent and child directory in tree structures
	gvfs-mtp                     #for displaying android or any other devices in ur file manager..
	unzip                        #used unziping any .zip file
	bluez                        #bluetooth
	bluez-utils                  #bluetooth
	man-db                       #man pages
	man-pages                    #man pages
	waybar                       #wayland status bar
	aquamarine                   #dependencies
	hyprutils                    #dependencies
	hyprcursor                   #dependencies
	hyprwayland-scanner          #dependencies
	hyprpicker                   #picks colors via cursor in hyprland
	hyprgraphics                 #dependencies
	hyprlang                     #dependencies
	hyprland-protocols           #dependencies
	hyprland-qt-support          #hyprland qt apps support
	hyprsunset 									 #hyprland night light support
	hyprland-guiutils            #hyprland qt apps utilities
	hyprland                     #hyprland
	hypridle                     #idle system management tool
	hyprlock                     #lock screen for hyprland
	xdg-desktop-portal-hyprland  #hyprland
	xdg-desktop-portal-gnome     #gnome
	xdg-desktop-portal-gtk       #gtk
	kvantum                      #qt
	kvantum-qt5                  #qt5 kvantum dependencies
	qt5ct                        #qt5 configuration utility
	qt6ct                        #qt6 configuration utility
	evince                       #print preview
	xdg-utils                    #dependencies
	xdotool                      #dependencies
	xorg-server                  #dependencies
	xorg-xinit                   #dependencies
	xorg-xhost                   #dependencies
	qt5-declarative              #for sddm
	qt5-quickcontrols            #for sddm
	proxychains-ng							 #Proxychains with tor use it ethically
)

pacman_install() {
	gum confirm "Do u wanna install the dependencies? (y/n): " && package="yes" || package="no"

	case "$package" in

	yes)
		local cout=0
		local max_attempts=3
		while ((cout < max_attempts)); do
			echo
			echo "[+] Installing dependencies (attempt $((cout + 1))/$max_attempts)"
			echo
			sudo pacman -S "${dependencies[@]}" --needed
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
		;;
	no)
		return
		;;

	esac
}

pacman_install
