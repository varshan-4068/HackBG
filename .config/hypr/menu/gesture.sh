#!/usr/bin/env bash

file="$HOME/.config/hypr/input.conf"

GESTURES=$(cat <<'EOF'
gesture = 3, horizontal, workspace
gesture = 3, down, mod: SUPER, resize
EOF
)

if grep -qxF "$GESTURES" "$file"; then
  STATUS="ON"
else
  STATUS="OFF"
fi

gum style \
  --border normal \
  --margin "1 0" \
  --padding "0 2" \
  --border-foreground 2 \
  "Gesture status: $STATUS"

update_status() {
  local status="$1"

  tput cuu 3

  tput cuf 19

  printf "%-3s" "$status"

  tput cud 2
}

choice=$(printf "On\nOff" | gum choose --header="Gesture:")

case "$choice" in
  On)
    if ! grep -qxF "gesture = 3, horizontal, workspace" "$file"; then
      printf "\n%s\n" "$GESTURES" >> "$file"
      STATUS="ON"
    fi
    ;;
  Off)
    sed -i \
      -e '/^gesture = 3, horizontal, workspace$/d' \
      -e '/^gesture = 3, down, mod: SUPER, resize$/d' \
      "$file"
    STATUS="OFF"
    ;;
esac

hyprctl reload >/dev/null 2>&1

update_status "$STATUS"

echo
read -rp "Press Enter to Escape"

exec ~/.config/hypr/menu/update.sh
