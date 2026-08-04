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
