#!/usr/bin/env bash

firewall() {

	gum style \
		--align center \
		--bold \
'
											 __ __  _____  __    __ 
											|  |  ||     ||  |__|  |
											|  |  ||   __||  |  |  |
											|  |  ||  |_  |  |  |  |
											|  :  ||   _] |  `  `  |
											|     ||  |    \      / 
											 \____||__|     \_/\_/  

'
}

clear
firewall

echo
sudo ufw enable
sudo ufw status
echo -e "\n_________________________________________________________________________________________________________\n"
sudo ufw limit 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
echo -e "\n_________________________________________________________________________________________________________\n"
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw reload

systemctl enable ufw.service

echo -e "\n[+] UFW rules were successfully updated in your system ::"

sleep 1.4
clear
