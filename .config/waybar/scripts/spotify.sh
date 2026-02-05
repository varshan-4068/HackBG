#!/usr/bin/env bash

PLAYER="spotify"
status=$(playerctl -p $PLAYER status 2>/dev/null)

if [[ "$status" == "Playing" ]]; then
  icon="  "
elif [[ "$status" == "Paused" ]]; then
  icon="  "
else
  exit 0
fi

title=$(playerctl -p $PLAYER metadata title)

echo "$icon $title"
