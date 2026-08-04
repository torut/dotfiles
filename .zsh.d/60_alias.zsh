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
