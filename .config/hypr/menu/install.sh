#!/usr/bin/env bash

color1="$(tput setaf 2)"
color2="$(tput setaf 7)"
color3="$(tput setaf 3)"

LOGFILE=~/.config/install_web_app.log

APP_NAME=""
URL=""
ICON_PATH=""
BROWSER="brave"

read -rp "${color1}Enter a name for the Desktop Shortcut: ${color2}" APP_NAME
echo
if [[ -f "$LOGFILE" ]] && grep -q "$APP_NAME" "$LOGFILE";then
  echo -e "${color3}Warning: App Name reused! Exiting...\n"
	read -rp "Press Enter to Escape"
	echo && exec ~/.config/hypr/menu/update.sh
fi
read -rp "${color3}Enter the URL of the Website: ${color2}" URL
echo -e "\nBy Default Brave's Icon Path Is Used for the Web Apps Installed\n"
read -rp "${color1}Do you want to Explicitly set the Icon Path (y/n): ${color2}" ICON
case "$ICON" in
	'y'|yes)
		echo
		read -rp "Enter the Icon Path: " ICON_PATH
		;;
	'n'|no)
		ICON_PATH="brave"
		;;
esac
echo


DESKTOP_FILE="$HOME/.local/share/applications/$APP_NAME.desktop"

mkdir -p "$HOME/.local/share/applications"

cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=$APP_NAME
Comment=Web App for $URL
Exec=$BROWSER --app="$URL"
Icon=$ICON_PATH
Terminal=false
Categories=Network;WebApp;
StartupWMClass=$APP_NAME
EOF

chmod +x "$DESKTOP_FILE"

echo "Desktop entry created:"
echo "$DESKTOP_FILE"

echo "$APP_NAME" >> $LOGFILE
echo
read -rp "Press Enter to Escape"
echo && exec ~/.config/hypr/menu/update.sh
