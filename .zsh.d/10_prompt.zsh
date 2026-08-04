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
