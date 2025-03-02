# Keep 4000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=4000
SAVEHIST=4000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

PROMPT_EOL_MARK=''

setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.

# properly clears screen
function clear-scrollback-buffer {
  clear && printf '\e[3J'
  zle && zle .reset-prompt && zle -R
}

# Alt + backspace stops at / character
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
    zle -f kill
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

zle -N clear-scrollback-buffer
bindkey '^L' clear-scrollback-buffer


# Use modern completion system
autoload -U compinit
zstyle ':completion:*' menu select=0
zmodload zsh/complist
compinit
_comp_options+=(globdots)


# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^[[Z' vi-up-line-or-history
bindkey -v '^?' backward-delete-char

# Yank to the system clipboard
zvm_vi_yank () {
	zvm_yank
	printf %s "${CUTBUFFER}" | xclip -sel c
	zvm_exit_visual_mode
}

bindkey -s '^o' 'lfcd\n'
bindkey -s '^[y' 'pwdc\n'

# disable sounds 
unsetopt BEEP

# fix for cursor after vim closes
_fix_cursor() {
	echo -ne "\e[5 q"
}
precmd_functions+=(_fix_cursor)

# alias and stuff
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/profile" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/profile"

bindkey "^[[H" beginning-of-line # control + a
bindkey "^H" backward-kill-word # control + h
bindkey '^[[1;5C' forward-word  # control + ->
bindkey '^[[1;5D' backward-word # control + <-
bindkey '^K' kill-line # control + k
bindkey '^E' end-of-line # control + e
bindkey '^[[4~' end-of-line # end key
bindkey '^[[P' delete-char # delete key

# plugins
export ZVM_TERM=xterm-256color
export ZSH_SYSTEM_CLIPBOARD_METHOD=xcc
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
. <(zr jeffreytse/zsh-vi-mode.git/zsh-vi-mode.plugin.zsh)
. <(zr woefe/git-prompt.zsh.git/git-prompt.plugin.zsh)

# Set up the prompt
autoload -U colors && colors
# ZSH_THEME_GIT_PROMPT_UNMERGED="x"
# ZSH_THEME_GIT_PROMPT_STAGED="o"
# ZSH_THEME_GIT_PROMPT_UNSTAGED="+"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="..."
# ZSH_THEME_GIT_PROMPT_STASHED="F"
# ZSH_THEME_GIT_PROMPT_CLEAN="/"
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
RPROMPT='$(gitprompt)'


# redefine a function from zsh-vi-mode plugin to enable global clipboard
function zvm_vi_yank() {
  zvm_yank
  echo "${CUTBUFFER}" |  xclip -i -sel clipboard
  zvm_exit_visual_mode
}

