#!/usr/bin/env bash

logo(){
	cat << EOF
 _                    __ _      _
| |__  _   _  __ _   / _(_)_  _(_)_ __   __ _
|  _ \| | | |/ _  | | |_| \ \/ / |  _ \ / _  |
| |_) | |_| | (_| | |  _| |>  <| | | | | (_| |
|_.__/ \__,_|\__, | |_| |_/_/\_\_|_| |_|\__, |
             |___/                      |___/

EOF
}

clear
logo

if command -v wireshark >/dev/null; then
    echo -e "[+] Fixing Wireshark non-root permissions...\n"
    sudo usermod -aG wireshark "$USER"
    echo -e "[+] Log out and log back in for changes to take effect.\n"
fi

if command -v burpsuite >/dev/null 2>&1; then
    DESKTOP_FILE="/usr/share/applications/burpsuite.desktop"
    if [[ -f "$DESKTOP_FILE" ]]; then
        echo -e "[+] Fixing Burp Suite UI scaling...\n"
  		 	line=$(cat /usr/share/applications/burpsuite.desktop 2>/dev/null | grep "Exec")
			  sudo sed -i 's|'"$line"'|Exec=java -Dsun.java2d.dpiaware=true -Dsun.java2d.uiScale=2.0 -jar /usr/share/burpsuite/burpsuite.jar|' "$DESKTOP_FILE"
        echo -e "[+] Burp Suite desktop entry updated."
    fi
fi
