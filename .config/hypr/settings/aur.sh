while true; do
	paru -Slq | grep -E '^[a-z0-9+._-]*$' 2>/dev/null | fzf --height=100% \
		--list-border \
		--list-label=" PACKAGE LIST " \
		--reverse \
		--highlight-line \
		--margin=1% \
		--border=sharp \
		--border-label=" PACMAN PACKAGE MANAGER " \
		--no-info \
		--no-scrollbar \
		--input-border \
		--input-label=" SEARCH PACKAGES " \
		--multi \
		--preview 'echo "alt-t: toggle description Ctrl-k/j: scroll up/down,";echo;paru -Sii {1}' \
		--bind 'alt-t:toggle-preview' \
		--preview-window=right:75% \
		--preview-label=" PACKAGE INFO " \
		--preview-border=sharp \
		--preview-label-pos=bottom -0 | xargs -ro paru -S --needed
done
