# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
PROMPT='$(kube_ps1)'$PROMPT
if [[ -r "$ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme"
fi
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

xrdb -merge ~/.config/X11/Xresources
# for compatibility reasons
export TERM=xterm-256color

# Apps
TERMINAL="alacritty"

# For cache dir
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
## Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
unsetopt nomatch						# Passes the command as is instead of reporting pattern matching failure see Chrysostomus/manjaro-zsh-config#14
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
# Autocomplete ../
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
HISTFILE="$ZDOTDIR"/zhistory
HISTSIZE=1000
SAVEHIST=500
setopt HIST_IGNORE_SPACE
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word
# Theming section  
autoload -U compinit colors zcalc
compinit -d
colors
# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r
## Plugins section: Enable fish style features
# Use syntax highlighting
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use history substring search
[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ] && source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# Use Autosuggestion
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'
## Keybindings section
set -o vi
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up			
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search
    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# XDG Base Directories
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export LESSHISTFILE=-
touch "$XDG_CONFIG_HOME/wgetrc"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export XDG_CACHE_HOME="$HOME/.local/cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc

# Programs
export EDITOR="nvim"

# PATH
export PATH=$PATH:~/.local/scripts
export PATH=$PATH:~/.local/bin
export PATH=$PATH:$XDG_DATA_HOME/gem/ruby/3.0.0/bin
export PATH=$PATH:/opt/appimages/:~/Applications/

# Filetypes
# $ xdg-mime query filetype photo.jpeg
# $ xdg-mime query default image/jpeg
# $ xdg-mime default feh.desktop image/jpeg
xdg-mime default vscodium.desktop text/plain

# Aliases
source "$ZDOTDIR"/zsh_aliases

# Prompt
# enable substitution for prompt
#setopt prompt_subst
# Print a greeting message when shell is started
echo $USER@$HOST  $(uname -srm) 
# zsh pure theme
#fpath+="$ZDOTDIR"/pure
#autoload -U promptinit; promptinit
#prompt pure
# AWS prompt
#source '"$ZDOTDIR"/shell-aws-autoprofile/shell-aws-autoprofile.sh'
#function aws_prompt_info() {
  #[[ -z $AWS_PROFILE ]] && return
  #echo "${ZSH_THEME_AWS_PREFIX:=<AWS:}${AWS_PROFILE}${ZSH_THEME_AWS_SUFFIX:=>}"
#}

#if [[ "$SHOW_AWS_PROMPT" != false && "$PROMPT" != *'$(aws_prompt_info)'* ]]; then
  #PROMPT='$(aws_prompt_info)'"$PROMPT"
#fi

# Start graphical server on tty1 if not already running.
# For Sway
#command -v sway >/dev/null && [ "$(tty)" = "/dev/tty1" ] && [ -z $DISPLAY ] && exec sway
# Fox X
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx $XINITRC
#[ "$(tty)" = "/dev/tty2" ] && ! pgrep -x Xorg >/dev/null && exec nvidia-xrun i3

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
# kubie prompt
#[ -f "$ZDOTDIR"/kube-ps1.sh ] && source "$ZDOTDIR"/kube-ps1.sh && PROMPT='$(kube_ps1)'$PROMPT


# Terraform
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
