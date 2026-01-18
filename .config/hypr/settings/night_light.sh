#!/usr/bin/env bash

NOTIFY_ID=100

if pgrep -x hyprsunset >/dev/null; then
    killall hyprsunset
    notify-send -r "$NOTIFY_ID" -t 3000 "Night Light" "Off"
else
    hyprsunset -t 3800 &
    notify-send -r "$NOTIFY_ID" -t 3000 "Night Light" "On"
fi
