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
