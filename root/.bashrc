#!/usr/bin/bash

[[ $- != *i* ]] && return

# eval section
eval "$(starship init bash)"
eval "$(fzf --bash)"
eval "$(zoxide init bash)"

# checks window size after wach command
shopt -s checkwinsize

#makes bash to append instead of overwriting the history
shopt -s histappend

# export seciton
export LS_COLORS="di=39:fi=35:ln=37:ex=34"
export EDITOR=nvim
export HISTFILESIZE=10000
export COLORTERM=truecolor
export HISTSIZE=1000
export CLICOLOR=1
export FZF_DEFAULT_OPTS=' --height=45% --layout=reverse --border=bold --no-info --highlight-line --no-scrollbar --list-label=" SEARCH FOR ANY FILE " --list-border=sharp --preview-label=" PREVIEW OF THE FILE " --preview-border=sharp ' 
export HISTCONTROL=erasedups
export MANPAGER="nvim +Man!"
export HISTSIZE=500
export HISTCONTROL=erasedups:ignoredups:ignorespace
export GUM_INPUT_CURSOR_FOREGROUND="#ff0555"
export GUM_INPUT_PROMPT_FOREGROUND="#cdd6f4"
export PARU_COLOR=never

# alias section
alias eza='eza --icons --git'
alias grep='grep --color=auto'
alias cp='cp -r'
alias rm='rm -r'
alias mkdir='mkdir -p'
alias ls='eza --color=auto --group-directories-first'
alias nv='fzf --preview "less {}" | xargs -ro nvim'
alias v='fzf --preview "less {}" | xargs -ro vim'
alias grubmk='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias rl='source .bashrc'
alias pacsyu='sudo pacman -Syu'
alias cat='bat'
alias c='clear'
alias ll='eza -lah --color=auto --group-directories-first'
alias la='eza -a --color=auto --group-directories-first'
alias lt='eza -aT --color=auto --group-directories-first'
alias l.='eza -lah --color=auto --group-directories-first ../'
alias l..='eza -lah --color=auto --group-directories-first ../../'
alias l...='eza -lah --color=auto --group-directories-first ../../../'
alias .='cd ../'
alias ..='cd ../../'
alias ...='cd ../../../'
alias h='history'
alias f='find . | grep'
alias check='journalctl -xb -p 3'
alias cpu='auto-cpufreq --stats'
alias bar='waybar &'
alias k='killall'
alias pacs='sudo pacman -S'
alias pacrns='sudo pacman -Rns'
alias rm='trash -v'
alias chx='chmod +x'
alias ff='fastfetch'
alias ts-gtk='sudo -E timeshift-launcher'
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f "     
alias add="git add"
alias commit="git commit -m"
alias gcm="git commit -m 'Updates..'"
alias push="git push"
alias pull="git pull"
alias fetch="git fetch"
alias status="git status"
alias clone="git clone"
alias tag="git tag"
alias newtag="git tag -a"
alias checkout="git checkout"
alias branch="git branch"
alias ips="whatsmyip"

color1="$(tput setaf 2)"
color2="$(tput setaf 3)"

function whatsmyip () {
    if command -v ip &> /dev/null; then
        echo -n "${color1}Internal IP: ${color2}"
				interface=$(ip route | grep '^default' | awk '{print $5}')
        ip addr show "$interface" | grep "inet " | awk '{print $2}' | cut -d/ -f1
    else
        echo -n "${color1}Internal IP: ${color2}"
        ifconfig "$interface" | grep "inet " | awk '{print $2}'
    fi
}

function y() {
	local tmp
	tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd" || return
	fi
	rm -f -- "$tmp"
}

# keybind section
if [[ $- == *i* ]]; then   # zoxide
    bind '"\C-f":"zi\n"'
fi

if [[ $- == *i* ]]; then   # nvim with fzf integretion
	  bind '"\C-n":"nv\n"'
fi

if [[ $- == *i* ]]; then   # nvim with fzf integretion
	  bind '"\C-v":"v\n"'
fi

manfzf(){
	man -k . | fzf | awk '{print $1}' | xargs -ro man 
}

# whenever doing cd the ll will be executed too
cd() {
	builtin cd "$@" || return
	la
	echo -e "\nCurrently on $(pwd)"
}

zi() {
	__zoxide_zi "$@"
	EXIT_CODE=$?
	if [ "$EXIT_CODE" -eq 0 ];then
		la
		echo -e "\nCurrently on $(pwd)"
	fi
}

z ()
{
    __zoxide_z "$@"
		la
		echo -e "\nCurrently on $(pwd)"
}

# bash_completion section
if [ -f /etc/bash_completion ]; then
		./etc/bash_completion
elif [ -f /usr/share/bash_completion ]; then
		./usr/share/bash_completion
fi

export PATH=$PATH:/usr/share/blackarch/bin

echo -e "\n[NOTE] $(tput setaf 2)Entering as Root User"
