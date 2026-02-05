#!/usr/bin/env bash

color1="$(tput setaf 2)"
color2="$(tput setaf 7)"
color3="$(tput setaf 3)"

LOGFILE=~/.config/install_web_app.log
APP_PATH=~/.local/share/applications/

APP_NAME=""
APP_ORIGINAL=""

echo -e "${color2}[NOTE] ${color3}Type in the Exact Shotcut Name as Listed in the app launcher\n"
read -rp "${color1}Enter a name for the Desktop Shortcut To Uninstall: ${color2}" APP_NAME

echo

if [[ -f "$LOGFILE" ]] && grep -q "$APP_NAME" "$LOGFILE"; then
	echo -e "${color3}Warning: App Name Found! Uninstalling it...\n${color2}"
	APP_ORIGINAL="${APP_NAME}.desktop"
	if [[ -f "$APP_PATH$APP_ORIGINAL" ]]; then
		rm "$APP_PATH$APP_ORIGINAL"
	else
		echo -e "${color1}Desktop file not found: $APP_ORIGINAL\n${color3}Skipping...${color2}\n"
	fi
	sed -i "\|$APP_NAME|d" "$LOGFILE"
else
    echo -e "${color3}No matching app found in logfile\n${color2}"
fi

read -rp "Press Enter to Exit"

echo && exec ~/.config/hypr/menu/update.sh
