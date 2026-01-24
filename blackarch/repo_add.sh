#!/usr/bin/env bash

blackarch_install(){
		if [ -f /usr/bin/curl ];then
			curl -fsSLO https://blackarch.org/strap.sh   
			sudo cp ~/HackBG/conf/pacman.conf /etc
		else
			sudo pacman -S curl
			curl -fsSLO https://blackarch.org/strap.sh   
			sudo cp ~/HackBG/conf/pacman.conf /etc
		fi

		if [ $? -eq 0 ];then
			chmod +x strap.sh 

			sudo sh strap.sh 

			rm strap.sh

			echo
		fi
}

blackarch_install
