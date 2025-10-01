#Prompt
autoload -U colors && colors
PS1="%B%{$fg[grey]%}[%{$fg[white]%}%n%{$fg[grey]%}@%{$fg[white]%}%M %{$fg[white]%}%~%{$fg[grey]%}]%{$reset_color%}$%b "

#Quality of life improvements
setopt autocd
stty stop undef
setopt interactive_comments

#History
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
setopt inc_append_history

#Load aliases and shotcuts if it is there
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

#basic autotab
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Add case-insensitive tab completion (new line)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' #'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

#vi mode
bindkey -v
export KEYTIMEOUT=1

#Use vim keys in tab menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

#Change cursor shape for different vi mode
function zle-keymap-select () {
	case $KEYMAP in
		vicmd) echo -ne '\e[1 q';;
		viins|main) echo -ne '\e[5 q';;
	esac
}
zle -N zle-keymap-select
zle-line-init () {
	zle -K viins
	echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'
preexec () {
	echo -ne '\e[5 q';
}

#Lf cd with ctrl-o
lfcd () {
	tmp="$(mktemp -uq)"
	trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
	lf -last-dir-path="$tmp" "$@"
	if [ -f "$tmp" ]; then
		dir="$(cat "$tmp")"
		[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
	fi
}
bindkey -s '^o' '^ulfcd\n'

bindkey -s '^a' '^ubc -lq\n'

bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'

bindkey -s '^[[P' delete-char

#Edit in vim
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

#Syntax highlighting(Always last)
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
