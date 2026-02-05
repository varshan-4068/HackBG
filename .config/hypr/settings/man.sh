#!/usr/bin/env bash

export MANPAGER="nvim +Man!"

while true; do
	man -k . | fzf --height=100% \
		--border=rounded \
		--border-label=" SEARCH FOR ANY MANPAGES " \
		--reverse \
		--no-info \
		--highlight-line \
		--no-scrollbar \
		--list-border \
		--list-border=none | awk '{print $1}' | xargs -ro man
done
