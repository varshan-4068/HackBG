#!/usr/bin/env bash

battery_status(){

Battery="BAT0"
alert=5
full=100

capacity=$(echo -e "$(cat /sys/class/power_supply/"$Battery"/capacity)")
status=$(echo -e "$(cat /sys/class/power_supply/"$Battery"/status)")

if [ "$status" == "Discharging" ] && [ "$capacity" -lt "$alert" ]; then
	notify-send -t 6500 "Battery is getting low $capacity Percent left, plug in your charger"
fi

if [ "$status" == "Charging" ] && [ "$capacity" -eq "$full" ]; then
	notify-send -t 6500 "Charged $capacity Percent, Please plug out your charger"
fi

}

while true;do 
	battery_status
	sleep 300
done
