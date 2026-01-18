#!/usr/bin/env bash

identify_wallpaper_engine() {
    if pgrep -x swww-daemon >/dev/null; then
        echo "swww"
    elif pgrep -x hyprpaper >/dev/null; then
        echo "hyprpaper"
    else
        echo "unknown"
    fi
}


WALLPAPER_ENGINE=$(identify_wallpaper_engine)

WALLPAPER_DIR="$HOME/.config/backgrounds"

CURRENT_WALL=$( (pgrep -x swww-daemon >/dev/null && swww query | awk '{print $9}') || (pgrep -x hyprpaper >/dev/null && grep -o '/home.*' ~/.config/hypr/hyprpaper.conf))

if [ -z "$CURRENT_WALL" ];then
	notify-send "Current Wallpaper Not Found!" "Please Try Again"
fi

WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

if [ "$WALLPAPER_ENGINE" == "swww" ]; then
		swww img --transition-step 225 --transition-type center --transition-duration 2 --transition-fps 90 --transition-angle 0 "$WALLPAPER"
elif [ "$WALLPAPER_ENGINE" == "hyprpaper" ]; then
		sed -i "/path =/s|path =.*|path = $WALLPAPER|" ~/.config/hypr/hyprpaper.conf
		setsid hyprpaper >/dev/null 2>&1 &
else
		notify-send "Unknown wallpaper engine detected!" "unable to set wallpaper"
fi

sed -i "s|^wallpaper *=.*|wallpaper = $WALLPAPER|" ~/.config/waypaper/config.ini

wal -q -e -i "$WALLPAPER" -n

sh ~/.config/hypr/settings/wallpaper_fetch.sh

killall -SIGUSR2 waybar
