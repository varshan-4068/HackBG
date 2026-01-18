#!/usr/bin/env bash

qemu() {
	gum confirm "==> Do you wanna setup virt-manager to use virtual machines (y/n) ?: " && qemu="yes" || qemu="no"

	case "$qemu" in
	yes)
		if grep -E -q 'vmx|svm' /proc/cpuinfo; then
			echo -e "\n[+] Virtualization is supported by your CPU"
			dependencies=(
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

			echo -e "\n[+] Installing dependencies"

			sudo pacman -S "${dependencies[@]}" --needed --noconfirm

			echo -e "\n[+] Enabling and starting libvirtd\n"

			systemctl enable libvirtd

			systemctl start libvirtd

			echo -e "\n[+] Adding user to the livirt and kvm groups.."

			sudo usermod -aG libvirt,kvm "$(whoami)"

			echo -e "\n[+] Enabling default network for vm\n"

			net=$(sudo virsh net-info default 2>/dev/null || true)

			if [[ -n $net ]]; then
				echo "[+] The network default is already active"
			else
				sudo virsh net-autostart default

				sudo virsh net-start default
			fi

			echo -e "\n[+] Successfully setup the virt-manager to run vm's"

		else
			echo "[+] Virtualization isn't supported by your CPU"
		fi

		sleep 0.8
		return
		;;
	no)
		return
		;;
	esac
}

qemu
