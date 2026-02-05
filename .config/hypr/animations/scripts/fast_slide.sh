#!/usr/bin/env bash

fast_slide() (
	dir=~/.config/hypr/animations
	file=~/.config/hypr/animations.conf

	cp $dir/fast-slide.conf $dir/../
	mv $dir/../fast-slide.conf $file
	notify-send -t 2800 "Setting to use fast-slide animation" "To change animations Press SUPER + H"
)

fast_slide
