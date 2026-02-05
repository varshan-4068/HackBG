wallpaper=$(cat ~/.config/waypaper/config.ini | grep -E "wallpaper\s+=\s+" | awk '{print $3}')
printf "* {%s\n    wallpaper: url(\"$wallpaper\", height);\n}\n\n #imagebox {\n    background-image: @wallpaper;\n }" > ~/.cache/current_wallpaper.rasi
