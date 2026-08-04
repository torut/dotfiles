## Command history configuration
#
# HISTSIZE/SAVEHIST は .zshrc 側で設定する
HISTFILE=${HOME}/.zsh_history
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
