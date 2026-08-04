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
esac

# 256
if [ "$TERM" != "xterm-color" ]; then
	eval `tset -sQI xterm-256color`
fi
