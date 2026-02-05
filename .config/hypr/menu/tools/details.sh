color1="$(tput setaf 2)"
color2="$(tput setaf 3)"
color7="$(tput setaf 7)"

clear

function whatsmyip () {
    if command -v ip &> /dev/null; then
        echo -n "[+] ${color1}Internal IP: ${color2}"
				interface=$(ip route | grep '^default' | awk '{print $5}')
        ip addr show "$interface" | grep "inet " | awk '{print $2}' | cut -d/ -f1
    else
        echo -n "[+] ${color1}Internal IP: ${color2}"
        ifconfig "$interface" | grep "inet " | awk '{print $2}'
    fi
}

function host(){
	echo -e "\n${color7}[+] ${color1}Hostname:${color2} $(hostname)${color7}"
	echo -e "\n[+] ${color1}Host Ip: ${color2}$(hostname -i | tr ' ' ' - ')${color7}"
}

whatsmyip

host

echo -e "\n[+] ${color1}Kernel Version:${color2} $(uname -r)\n${color7}"

echo -e "[+] ${color1}System Uptime:${color2} $(uptime -p)\n${color7}"

echo -e "[+] ${color1}Disk Usage:\n${color2}$(df -h / | tail -n 1)\n${color7}"

echo -e "${color1}SSH Service Status:${color2}"

if systemctl is-active sshd &>/dev/null; then
    echo -e "${color7}[+]${color2} SSH is running${color1}\n"
else
    echo -e "${color7}[-]${color2} SSH is NOT running\n"
fi

echo -e "${color7}[+] ${color1}Open Listening Ports:${color2}"
ss -tuln | grep LISTEN
echo

VERSION=$(hyprland -v | grep "Hyprland" | awk '{print $2}')

if [ ! -z "$VERSION" ];then
	echo -e "${color7}[+] ${color1}Hyprland version: ${color2}$VERSION\n"
fi

read -rp "${color1}Press Enter to close${color7}"

sh ~/.config/hypr/menu/tools.sh
