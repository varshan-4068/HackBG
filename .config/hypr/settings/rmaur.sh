while true; do
	paru -Qq | fzf --height=100% \
		--algo=v1 \
		--list-border \
		--list-label=" INSTALLED PACKAGES " \
		--reverse \
		--highlight-line \
	  --margin=1% \
		--border=sharp \
		--border-label=" PARU AUR PACKAGE MANAGER " \
		--no-info \
		--no-scrollbar \
		--input-border \
		--input-label=" REMOVE PACKAGES " \
		--multi \
		--preview 'echo "alt-t: toggle description Ctrl-k/j: scroll up/down,";echo;paru -Qi {1}' \
		--bind 'alt-t:toggle-preview' \
		--preview-window=right:75% \
		--preview-label=" PACKAGE INFO " \
		--preview-border=sharp \
		--preview-label-pos=bottom -0 | xargs -ro paru -Rns
done
