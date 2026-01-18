pgrep -x waybar

bar_toggle=$(echo $?)

if [ "$bar_toggle" == "0" ]; then
	killall waybar && waybar &
fi

if [ "$bar_toggle" == "1" ]; then
	waybar &
fi
