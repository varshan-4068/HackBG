#!/usr/bin/env bash

COLOR1=$(tput setaf 2)
COLOR2=$(tput setaf 7)

CRITICAL=0
WARN=0
INTERACTIVE=0

echo -e "\n${COLOR1}NOTE:\n$(tput setaf 1)This script installs required UI and CLI dependencies if not found!\nto provide an better UI\n"
echo -e "This script runs only the basic Security Check\n"
echo -e "If no warning's or critical issues found it doesn't mean your system\nis completely secure\n${COLOR2}"

read -rp "Press Enter to Proceed"

help_flag() {
  cat << EOF

Usage:
	arcsec-tool [OPTIONS]

Options:
	-h, --help     		Display help message and exit
	-l, --log      		Display the log output of previous security check
	-c, --clear    		Clears the log output's of security check's
	-n, --non-interactive   Run the command in non-interactive mode

Description:
	Performs basic security checks on an Arch Linux system:
	 - SSH configuration
	 - sudo privileges
	 - failed systemd services
	 - package updates
	 - orphaned packages
	 - firewall status

Notes:
	• Some checks require sudo privileges
	• Designed for Arch Linux and Arch-based systems
	• This script does not apply fixes automatically
	• Recommendation's and Fixes are provided for warning's

EOF
}

LOGFILE="/var/log/arcsec-tool-report.log"

case "${1:-}" in
	--log|-l)
		if [ -f "$LOGFILE" ];then
			echo
			sudo cat "$LOGFILE"
		else
			echo -e "No log report found!"
		fi
		exit 0
		;;
  --help|-h)
    help_flag
    exit 0
		;;
	--clear|-c)
		if [ -f "$LOGFILE" ];then
			sudo rm "$LOGFILE"
		fi
		exit 0
		;;
	--non-interactive|-n)
		INTERACTIVE=1
		if [[ $EUID -ne 0 ]]; then
			sudo "$0" "$@"
			exit 0
		fi
		;;
	"")
		if [[ $EUID -ne 0 ]]; then
			sudo "$0" "$@"
			exit 0
		fi
		;;
	*)
		echo
		echo "Unknown option: ${1:-}"
		help_flag
		exit 1
		;;
esac

if [ ! -f "$LOGFILE" ]; then
	touch "$LOGFILE"
	chmod 640 "$LOGFILE"
fi

echo -e "${COLOR2}[$(date)]\n" >> "$LOGFILE"

if ! command -v figlet &>/dev/null && [ "$INTERACTIVE" -eq 1 ];then
	echo -e "Figlet Not Found! Installing...\n" | tee -a "$LOGFILE"
	pacman -S figlet --noconfirm 
elif ! command -v figlet &>/dev/null;then
	echo -e "Figlet Not Found! Installing...\n" | tee -a "$LOGFILE"
	pacman -S figlet
fi


if ! command -v gum &>/dev/null; then
  echo -e "Gum Not Found! Installing...\n" | tee -a "$LOGFILE"
  pacman -S gum --noconfirm
fi

logs(){
	echo -e "${COLOR1}══ Logs ══${COLOR2}"
	echo -e "Log file saved at: $LOGFILE\n"
}

print_logo(){

if command -v figlet &>/dev/null; then
cat << EOF

$(figlet "SECURITY CHECK")

EOF
else
	 echo -e "=== SECURITY CHECK ===\n"
fi

}

clear
print_logo

echo -e "\n${COLOR1}══ Arch Security Quick Check ══${COLOR2}\n" | tee -a "$LOGFILE"

if systemctl is-enabled --quiet sshd 2>/dev/null; then
  echo -e "${COLOR1}[OK] SSH service enabled" | tee -a "$LOGFILE"
else
  echo -e "${COLOR2}[WARN] SSH service disabled" | tee -a "$LOGFILE"
	echo "[FIX]: Use \"systemctl enable sshd.service\"" | tee -a "$LOGFILE"
	((WARN++))
fi

SSHD="/etc/ssh/sshd_config"

if [[ -f "$SSHD" ]] && grep -Eiq "^\s*PermitRootLogin\s+(yes|prohibit-password)" "$SSHD" 2>/dev/null; then
  echo -e "${COLOR1}[CRITICAL] SSH root login enabled${COLOR2}" | tee -a "$LOGFILE"
  echo "[FIX]: Set PermitRootLogin no in /etc/ssh/sshd_config" | tee -a "$LOGFILE"
  ((CRITICAL++))
else
  echo -e "${COLOR1}[OK] SSH root login disabled${COLOR2}" | tee -a "$LOGFILE"
fi

if [[ -f "$SSHD" ]] && grep -Eiq "^\s*PasswordAuthentication\s+yes" "$SSHD" 2>/dev/null; then
  echo -e "${COLOR1}[WARN] SSH password authentication enabled${COLOR2}" | tee -a "$LOGFILE"
  echo "[RECOMMENDATION]: Use SSH keys only" | tee -a "$LOGFILE"
  ((WARN++))
else
  echo -e "${COLOR1}[OK] SSH password authentication disabled${COLOR2}" | tee -a "$LOGFILE"
fi

sudoers=/etc/sudoers

if grep -Eiq '^\s*[^#].*NOPASSWD' "$sudoers" 2>/dev/null; then
  echo -e "${COLOR1}[WARN] NOPASSWD sudo rules detected${COLOR2}" | tee -a "$LOGFILE"
  ((WARN++))
else
  echo -e "${COLOR1}[OK] Sudo requires password${COLOR2}" | tee -a "$LOGFILE"
fi


FAIL=$(systemctl --failed --no-legend 2>/dev/null | wc -l)

if [ "$FAIL" -eq 0 ]; then
  echo -e "${COLOR1}[OK] No Systemd Failed Services Found${COLOR2}" | tee -a "$LOGFILE"
else
	echo -e "${COLOR1}[WARN] $FAIL Failed Systemd Services Found${COLOR2}" | tee -a "$LOGFILE"
	((WARN++))
fi

ROOT_USERS=$(awk -F: '$3 == 0 {print $1}' /etc/passwd | wc -l)

if [ "$ROOT_USERS" -eq 1 ];then
	echo -e "${COLOR1}[OK] Only $ROOT_USERS User is given UID 0 (Root User) Privileges" | tee -a "$LOGFILE"
elif [ "$ROOT_USERS" -gt 1 ];then
	echo -e "${COLOR1}[CRITICAL] $ROOT_USERS Users Found with UID 0 (Root User) Privileges" | tee -a "$LOGFILE"
	((CRITICAL++))
elif [ "$ROOT_USERS" -eq 0 ];then
	echo -e "${COLOR1}[WARN] No User is given UID 0 (Root User) Privileges" | tee -a "$LOGFILE"
	((WARN++))
fi

TIME_SYNC=$(timedatectl | grep -q "System clock synchronized: yes")

if $TIME_SYNC;then
	echo -e "${COLOR1}[OK] Automatic Time Sync is Enabled" | tee -a "$LOGFILE"
else
	echo -e "${COLOR1}[WARN] Automatic Time Sync is not Enabled" | tee -a "$LOGFILE"
	((WARN++))
fi

DISK_SPACE=$(df / | awk 'NR==2 {print $5}' | cut -d'%' -f1)

if [ "$DISK_SPACE" -lt 80 ];then
	echo -e "${COLOR1}[OK] Disk Space Usage is $DISK_SPACE%" | tee -a "$LOGFILE"
elif [ "$DISK_SPACE" -gt 80 ];then
	echo -e "${COLOR1}[WARN] Disk Space Usage above 80% Can Break Updates / Logging" | tee -a "$LOGFILE"
	((WARN++))
fi

if gum spin --spinner points --title "Updating System Packages…" -- pacman -Sy --quiet; then
  gum style --foreground 2 "[OK] Package database updated" | tee -a "$LOGFILE"
else
  gum style --foreground 1 "[WARN] Failed to update package database" | tee -a "$LOGFILE"
	((WARN++))
fi

UPDATES=$(pacman -Qu 2>/dev/null | wc -l)
if [[ "$UPDATES" -gt 0 ]]; then
  echo -e "${COLOR1}[WARN] $UPDATES pending updates${COLOR2}" | tee -a "$LOGFILE"
  ((WARN++))
else
  echo -e "${COLOR1}[OK] System up to date${COLOR2}" | tee -a "$LOGFILE"
fi

ORPHAN=$(pacman -Qdtq | wc -l)

if [[ "$ORPHAN" -gt 0 ]]; then
	echo -e "${COLOR1}[WARN] $ORPHAN Orphaned Packages Found${COLOR2}" | tee -a "$LOGFILE"
	echo -e "${COLOR2}[Fix] Use \"sudo pacman -Rns \$(pacman -Qdtq)\"" | tee -a "$LOGFILE"
	((WARN++))
else
	echo -e "${COLOR1}[OK] No Orphaned Packages Found${COLOR2}" | tee -a "$LOGFILE"
fi

if (command -v ufw &>/dev/null && ufw status | grep -q "^Status: active") \
	 || systemctl is-active --quiet ufw \
	 || systemctl is-active --quiet firewalld \
	 || systemctl is-active --quiet nftables; then
	echo -e "${COLOR1}[OK] Firewall Enabled..." | tee -a "$LOGFILE"
	echo -e "${COLOR1}[NOTE] Firewall Rules not inspected..." | tee -a "$LOGFILE"
else
	echo -e "${COLOR1}[WARN] Firewall Not Enabled...${COLOR2}" | tee -a "$LOGFILE"
	((WARN++))
fi

echo -e "\n${COLOR1}══ Summary ══${COLOR2}"
echo -e "Critical issues: ${COLOR2}$CRITICAL${COLOR2}"
echo -e "Warnings: ${COLOR2}$WARN${COLOR1}"

if [[ "$CRITICAL" -gt 0 ]]; then
  echo -e "\n${COLOR1}System is NOT secure.${COLOR2}\n"
	logs
else
  echo -e "\n${COLOR1}No critical security issues found.${COLOR2}\n"
	logs
fi

# File Report's 

{
	echo -e "\n══ Summary ══"
	echo "Critical issues: $CRITICAL"
	echo "Warnings: $WARN"

	if [[ "$CRITICAL" -gt 0 ]]; then
		echo "System is NOT secure."
	else
		echo "No critical security issues found."
	fi

	echo -e ""
} >> "$LOGFILE"

if [ "$INTERACTIVE" -eq 0 ]; then
	read -rp "Press Enter to Close"
fi
