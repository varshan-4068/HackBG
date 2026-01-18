#!/usr/bin/env bash

set -euo pipefail

select=$(echo -e "TryHackMe\nHackTheBox\nChatGPT\nArch Wiki\nLeetCode\nHackerRank\nCodeChef\nBack\nQuit"| gum choose --header="Learn From: ")

launch() {
	setsid brave --app="$1" >"$HOME/.cache/brave-launch.log" 2>&1 &
	sleep 0.28
}

case "$select" in
	TryHackMe)
		launch https://tryhackme.com/dashboard/
		;;
	HackTheBox)
		launch https://academy.hackthebox.com/dashboard/
		;;
	ChatGPT)
		launch https://chatgpt.com
		;;
	'Arch Wiki')
		launch https://wiki.archlinux.org/title/Arch_Linux
		;;
	LeetCode)
		launch https://leetcode.com/problemset/
		;;
	HackerRank)
		launch https://www.hackerrank.com/dashboard/
		;;
	CodeChef)
		launch https://www.codechef.com/dashboard/
		;;
	Back)
		sh ~/.config/hypr/menu/tools.sh
		;;
	Quit)
		exit 0
		;;
esac
