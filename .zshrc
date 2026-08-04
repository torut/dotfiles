# users generic .zshrc file for zsh(1)
#
# history の保存件数。変更したい場合はここを編集する。
HISTSIZE=50000
SAVEHIST=50000

# 機能別に .zsh.d/ 以下へ分割している。読み込む順序はここで明示する
# (例えばPowerlevel10kのinstant promptのように最上部での読み込みを
# 要求するものを差し込みたい場合、ここに1行追加すればよい)。
source ${HOME}/.zsh.d/00_locale.zsh
source ${HOME}/.zsh.d/10_prompt.zsh
source ${HOME}/.zsh.d/20_options.zsh
source ${HOME}/.zsh.d/30_keybind.zsh
source ${HOME}/.zsh.d/40_history.zsh
source ${HOME}/.zsh.d/50_completion.zsh
source ${HOME}/.zsh.d/60_alias.zsh
source ${HOME}/.zsh.d/70_terminal.zsh
source ${HOME}/.zsh.d/80_environment.zsh

## load user .zshrc configuration file
#
[ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine
