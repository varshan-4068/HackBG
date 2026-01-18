#!/usr/bin/env bash

clear

color1="$(tput setaf 2)"
color2="$(tput setaf 7)"
color3="$(tput setaf 3)"

function input(){
	read -rp "${color1}Enter no. of uppercase letters: " upper
	echo
	read -rp "${color3}Enter no. of lowercase letters: " lower
	echo
	read -rp "${color1}Enter no. of numbers to be kept: " numbers
	echo
	read -rp "${color3}Enter the no. of special characters to be present: ${color2}" symbols
	echo
}

function recommendations() {
    echo "$(tput setaf 6)Recommended presets (optional):$(tput sgr0)"
    echo "  Wi-Fi  → Upper:2  Lower:8  Numbers:2  Symbols:2"
    echo "  SSH    → Upper:4  Lower:8  Numbers:4  Symbols:4"
    echo "  Admin  → Upper:4  Lower:10 Numbers:4  Symbols:4"
    echo
    echo "You can ignore these and choose your own values."
    echo
}

recommendations

input

if [[ -z "$lower" &&  -z "$upper" && -z "$symbols" && -z "$numbers" ]] || [[ "$lower" -eq 0 && "$upper" -eq 0 && "$symbols" -eq 0 && "$numbers" -eq 0 ]];then
	while true;do
		echo "Please enter atleast any one character with non-empty and non-zero number's"
		echo
		echo "Press Enter to Escape"
		read -r
		clear
		exec ~/.config/hypr/menu/tools/password.sh
		if [[ -z "$lower" ]] || [[ -z "$upper" ]] || [[ -z "$symbols" ]] || [[ -z "$numbers" ]];then
			break
		fi
	done
fi

if [[ -z "$numbers" ]]; then
	numbers=0
fi

if [[ -z "$symbols" ]]; then
	symbols=0
fi

if [[ -z "$upper" ]]; then
	upper=0
fi

if [[ -z "$lower" ]]; then
	lower=0
fi

for var in upper lower numbers symbols; do
    if ! [[ "${!var}" =~ ^[0-9]+$ ]]; then
        echo "Invalid input: input must be a number"
				echo 
				read -rp "$(tput setaf 4)Press Enter to close${color2}"
				exec ~/.config/hypr/menu/tools/password.sh
    fi
done

password=$(
  tr -dc 'A-Z' < /dev/urandom | head -c "$upper"
  tr -dc 'a-z' < /dev/urandom | head -c "$lower"
  tr -dc '0-9' < /dev/urandom | head -c "$numbers"
  tr -dc '!@#$%^&*()_+=' < /dev/urandom | head -c "$symbols"
)

password=$(echo "$password" | fold -w1 | shuf | tr -d '\n')

echo -e "${color1}Password$(tput setaf 4): $password${color3}"

echo "$password" | wl-copy

length=${#password}
score=0
classes=0

if (( length >= 8 ));then 
	((score+=1))
fi

if (( length >= 12 ));then 
	((score+=2)) 
fi

if (( length >= 16 ));then 
	((score+=2)); 
fi

if (( upper > 0 )); then
	((classes++))
fi

if (( lower > 0 ));then
	((classes++))
fi

if (( numbers > 0 ));then
	((classes++))
fi

if (( symbols > 0 )); then 
	((classes++))
fi

((score+=classes))

if (( score <= 3 )); then
    strength="Very Weak"
    bar_color=1
    bar_fill=2
elif (( score <= 5 )); then
    strength="Weak"
    bar_color=3
    bar_fill=4
elif (( score <= 7 )); then
    strength="Moderate"
    bar_color=3
    bar_fill=6
elif (( score <= 8 )); then
    strength="Strong"
    bar_color=2
    bar_fill=8
else
    strength="Very Strong"
    bar_color=2
    bar_fill=9
fi

bar_total=9
filled=$(printf "%${bar_fill}s" | tr ' ' '|')
empty=$(printf "%$((bar_total - bar_fill))s" | tr ' ' '-')

(( bar_fill > bar_total )) && bar_fill=$bar_total

percentage=$(( bar_fill*100/bar_total ))

echo
echo -e "Security Level: $(tput setaf $bar_color)$strength$(tput sgr0)"
echo -e "[$(tput setaf $bar_color)$filled$(tput setaf 7)$empty] $percentage%"

HASH_FILE="$HOME/.config/hypr/menu/tools/password_hashes"

if [ ! -f "$HASH_FILE" ];then
	touch "$HASH_FILE"
fi

hash=$(echo -n "$password" | sha256sum | cut -d' ' -f1)

grep -q "$hash" "$HASH_FILE" && echo -e "\nWarning: password reused"

echo "$hash" >> "$HASH_FILE"

echo

echo "password generated and copied to clipboard!"

sleep 1.4

echo

read -rp "$(tput setaf 4)Press Enter to close${color2}"

sh ~/.config/hypr/menu/tools.sh
