#!/usr/bin/env bash

set -e

tools() {

	cat <<EOF

 _____           _   _  ___ _
|_   _|__   ___ | | | |/ (_) |_
  | |/ _ \ / _ \| | | ' /| | __|
  | | (_) | (_) | | | . \| | |_
  |_|\___/ \___/|_| |_|\_\_|\__|


EOF
}

clear
tools

select=$(echo -e "Security Check\nPassword Generator\nMetasploitable2\nLearn and Code\nAbout\nBack\nQuit" | gum choose --header="Select the tool: ")
tool=~/.config/hypr/menu/tools

case "$select" in
	'Security Check')
		sudo sh $tool/check.sh
		sh $tool/../tools.sh
		;;
	'Password Generator')
		sh $tool/password.sh
		;;
	'Metasploitable2')
		sh $tool/metasploitable.sh
		;;
	'Learn and Code')
		sh $tool/practice.sh
		;;
	'About')
		sh $tool/details.sh
		;;
	Back)
		sh $tool/../update.sh
		;;
	Quit)
		exit 0
		;;
esac
