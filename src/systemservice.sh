#!/usr/bin/env bash

sudo systemctl enable --now swayosd-libinput-backend.service 2>/dev/null

sudo systemctl start --now swayosd-libinput-backend.service 2>/dev/null

echo -e "[+] Enabled libinput backend services for swayosd\n"

network() {
	if gum confirm "Do you want to enable network services?"; then
		systemctl enable --now NetworkManager.service 2>/dev/null && echo -e "\n[+] Enabled Network Services\n"
	fi
}

bluetooth() {
	if gum confirm "Do you want to enable bluetooth services?"; then
		systemctl enable --now bluetooth.service 2>/dev/null && echo -e "\n[+] Enabled Bluetooth Services\n"
	fi

}

network

bluetooth
