#!/usr/bin/env bash

fast_popin() (
	dir=~/.config/hypr/animations
	file=~/.config/hypr/animations.conf

	cp $dir/fast-popin.conf $dir/../
	mv $dir/../fast-popin.conf $file
	notify-send -t 2800 "Setting to use fast-popin animation" "To change animations Press SUPER + H"
)

fast_popin
