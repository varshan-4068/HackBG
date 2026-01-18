#!/usr/bin/env bash

disabled() (
	dir=~/.config/hypr/animations
	file=~/.config/hypr/animations.conf

	cp $dir/disabled.conf $dir/../
	mv $dir/../disabled.conf $file
	notify-send -t 2800 "Disabling animations" "To change animations Press SUPER + H"
)

disabled
