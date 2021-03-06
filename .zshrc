# users generic .zshrc file for zsh(1)
## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8
case ${UID} in
0)
  LANG=C
  ;;
esac


## Default shell configuration
#
# set prompt
#
autoload colors
colors
case ${UID} in
0)
  PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*}) %B%{${fg[red]}%}%n %{${reset_color}%}#%b "
  PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
  RPROMPT="[%/]"
  SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  ;;
*)
  PROMPT="%{${fg[magenta]}%}%n %{${reset_color}%}%{${fg[green]}%}$%{${reset_color}%} "
  PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
#  RPROMPT="[%/]"
  RPROMPT="%(5~,%-2~/.../%2~,%~)"
  SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
      PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*}) ${PROMPT}"
  ;;
esac

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep


## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a gets to line head and Ctrl-e gets
#   to end) and something additions
#
bindkey -e
bindkey "^[[1~" beginning-of-line # Home gets to line head
bindkey "^[[4~" end-of-line # End gets to line end
bindkey "^[[3~" delete-char # Del
bindkey "^[f" emacs-forward-word
bindkey "^[b" emacs-backward-word
export WORDCHARS=""

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# reverse menu completion binded to Shift-Tab
#
bindkey "\e[Z" reverse-menu-complete


## Command history configuration
#
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data


## Completion configuration
#
fpath=(${HOME}/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z} r:|[-_.]=**'


## zsh editor
#
autoload zed


## Prediction configuration
#
#autoload predict-on
#predict-off


## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
freebsd*|darwin*)
  if [ -e "/usr/local/opt/coreutils/libexec/gnubin/ls" ]; then
	# if installed coreutils
    alias ls="ls --color"
  else
    alias ls="ls -G -w"
  fi
  ;;
linux*)
  alias ls="ls --color"
  ;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -alh"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias screen="screen -UR"
alias scr="screen -UR"
alias root="su - root"
alias emacs="emacs -nw"
alias e="emacs -nw"
alias em="emacs -nw"
alias l="less"
alias tma="tmux attach -d"
alias tmw="tmux new-session \; split-window -h -d"

## terminal configuration
#
case "${TERM}" in
screen)
  export TERM=xterm-256color
  ;;
esac

case "${TERM}" in
xterm|xterm-color|xterm-256color)
#  export LSCOLORS=exfxcxdxbxegedabagacad
  export LSCOLORS=ExFxCxdxBxegedabagacad
  export LS_COLORS='di=;34;1:ln=;35;1:so=;32;1:pi=33:ex=;31;1:bd=;46;34:cd=;43;34:su=;41;30:sg=;46;30:tw=;42;30:ow=;43;30'
  zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=;31;1' 'bd=46;34' 'cd=43;34' # 補完表示用
  ;;
kterm-color)
  stty erase '^H'
#  export LSCOLORS=exfxcxdxbxegedabagacad
  export LSCOLORS=ExFxCxdxBxegedabagacad
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
  ;;
kterm)
  stty erase '^H'
  ;;
cons25)
  unset LANG
#  export LSCOLORS=ExFxCxdxBxegedabagacad
  export LSCOLORS=ExFxCxdxBxegedabagacad
  export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
  ;;
jfbterm-color)
#  export LSCOLORS=gxFxCxdxBxegedabagacad
  export LSCOLORS=ExFxCxdxBxegedabagacad
  export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
  ;;
esac

# set terminal title including current directory
#
# case "${TERM}" in
# xterm|xterm-color|kterm|kterm-color|screen|xterm-256color)
#   precmd() {
#     echo -ne "\ek$(basename $(pwd))\e\\"
# #    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
#   }
#   preexec() {
#     case ${UID} in
#   		0)
#   			echo -ne "\ek%${1%% *}\e\\"
#   			;;
#   		*)
#   			echo -ne "\ek#${1%% *}\e\\"
#   		esac
#   }
#   ;;
# esac

# 256
if [ "$TERM" != "xterm-color" ]; then
	eval `tset -sQI xterm-256color`
fi

# set default editor and more.
export PATH=$PATH:$HOME/bin
export SVN_EDITOR=emacs
export EDITOR=emacs
export PAGER=less
export LESSCHARSET=utf-8

if [[ -x `whence -p lv` ]]; then
	export PAGER="lv -c"
fi

## load user .zshrc configuration file
#
[ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine

