#!/usr/bin/env bash

hyprctl keyword animations:enabled 0
hyprshot -m region --raw |
  satty --filename - \
    --output-filename "$HOME/Pictures/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" \
    --early-exit 
hyprctl keyword animations:enabled 1
