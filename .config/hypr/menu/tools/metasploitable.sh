#!/usr/bin/env bash

color1="$(tput setaf 2)"
color2="$(tput setaf 7)"
color3="$(tput setaf 3)"

logo(){
	echo
	figlet Metasploitable 2
	echo
}

VM_NAME="metasploitable2"
WORKDIR="$HOME/.config/virt-manager-vms/$VM_NAME"
ZIP_FILE="metasploitable-linux-2.0.0.zip"
DOWNLOAD_URL="https://sourceforge.net/projects/metasploitable/files/latest/download"

if virsh list --all | grep -qw "$VM_NAME";then
	echo "${color2}[-] ${color1}The VM already exist, Exiting..."
	echo
	read -rp "${color3}Press Enter to Close${color2}"
	exec ~/.config/hypr/menu/tools.sh
fi

check_dependencies() {
    local dependencies=(
			figlet 
			axel 
			unzip 
			qemu-full
			virt-manager
			qemu-system-x86
			qemu-system-x86-firmware
			qemu-img
			bridge-utils
			dnsmasq
			ovmf
			swtpm
			spice
			sof-firmware
			libgovirt
			libvirt
		)
		echo -e "${color2}[+] ${color3}Checking Depedencies...\n"
    for deps in "${dependencies[@]}"; do
				echo -e "${color2}[+] ${color1}Checking if $deps is installed"	
				sleep 0.6
        pacman -Qe "$deps" 2>/dev/null || {
            echo -e "\n${color2}[-] ${color3}Missing dependency: $deps${color2}\n"
           	sudo pacman -S "$deps"
        }
    done
}

check_dependencies
clear 
logo

if [ ! -d "$WORKDIR" ];then
	mkdir -p "$WORKDIR"
	echo -e "\n[-] ${color1}Not Found $WORKDIR, Creating Newly..${color2}\n"
	cd "$WORKDIR" || return
	echo "[+] ${color3}Downloading Metasploitable2..."
	axel -o "$ZIP_FILE" "$DOWNLOAD_URL"
else
	cd "$WORKDIR" || return
	if [ -f "$ZIP_FILE" ];then
		echo "${color2}[+] ${color1}File already exist skipping Download.."
	else
		echo "${color2}[+] ${color3}Downloading Metasploitable2..."
		axel -o "$ZIP_FILE" "$DOWNLOAD_URL"
	fi
fi

echo -e "\n${color2}[+] ${color1}Extracting...\n"
unzip -o "$ZIP_FILE"

VMDK_FILE=$(find . -name "*.vmdk" | head -n 1)
QCOW_FILE="$WORKDIR/metasploitable2.qcow2"

echo -e "\n${color2}[+] ${color3}Converting VMDK --> QCOW2...\n"
qemu-img convert -f vmdk -O qcow2 "$VMDK_FILE" "$QCOW_FILE"

echo -e "\n${color2}[+] ${color1}Creating VM in libvirt...\n"
virt-install \
  --name "$VM_NAME" \
  --memory 2048 \
  --vcpus 2 \
  --disk path="$QCOW_FILE",format=qcow2 \
  --os-variant generic \
  --import \
  --network network=default \
  --graphics spice \
  --noautoconsole

echo -e "\n${color2}[+] ${color3}Metasploitable2 imported successfully.\n"
echo -e "${color2}[+] ${color1}Open virt-manager to start the VM.${color2}\n"

read -rp "Press Enter to Close"

sh ~/.config/hypr/menu/tools.sh
