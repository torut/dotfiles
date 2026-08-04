# TODO

## zshテーマ/フレームワーク導入の検討 (2026-08-04時点のメモ)

### oh-my-zsh

フル導入は非推奨。`compinit`呼び出し、テーマ(プロンプト)、git補完/エイリアスを
自前で丸ごと持ってくるため、現状の以下とほぼ全て競合する。

- `.zsh.d/50_completion.zsh` (compinit)
- `.zsh.d/10_prompt.zsh` + `.zsh.d/git-prompt.zsh` (プロンプト)
- `.zsh.d/_git` + `.zsh.d/git-completion.bash` (git補完)

導入するなら、oh-my-zshの起動スクリプトに`.zshrc`を明け渡すのではなく、
欲しいプラグインだけを`.zsh.d/`に個別ファイルとして持ち込む
「つまみ食い」方式が今の構成と相性がいい。

- フル導入: 利便性・エコシステムの広さがある一方、今の薄く監査しやすい構成を失う
- つまみ食い: 今の構成を維持できる一方、手動管理の手間が増える

### Powerlevel10k

oh-my-zsh必須ではなく単独導入できるため、フルフレームワークより相性はいい。

ただし導入する場合は以下を置き換える前提で考える。

- `.zsh.d/10_prompt.zsh` (PROMPT/RPROMPT手組み)
- `.zsh.d/git-prompt.zsh` (git branch表示hook)

p10k自身がgit状態(staged/untracked/ahead-behind等)込みのプロンプトを
持っているため、両方生かすと二重描画で衝突する。

また、p10kの「instant prompt」機能はほぼ`.zshrc`の最上部で読み込むことを
前提にしており、今の「番号順に`.zsh.d/`を読み込む」設計とは順序面で
相性が悪い。instant promptを活かすには番号ローダーより先に置く特別扱いが
必要になる。
