# users generic .zshrc file for zsh(1)
#
# 機能別に .zsh.d/ 以下へ分割している。ファイル名先頭の2桁の数字が読み込み順。
for zshrc_part in ${HOME}/.zsh.d/[0-9][0-9]_*.zsh(N); do
  source "$zshrc_part"
done
unset zshrc_part

## load user .zshrc configuration file
#
[ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine
