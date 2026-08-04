# dotfiles

それぞれ $HOME ディレクトリでシンボリックリンクを張るなどして使う.

## Emacs

バージョン29以降用.
それ以前は master ブランチを参照.


`.emacs.d/init.el` はEmacsのバージョンで読み込む設定を自動的に切り替える.

- Emacs 29.1以降: `.emacs.d/inits/` (use-package + vertico/consult/marginalia/orderless構成)
- Emacs 24-28: `.emacs.d/inits-legacy/` (init-loader + anything構成)

MELPAで現在配布されているvertico/consult/marginaliaがEmacs 29.1以降を要求するため
(package.elは過去バージョンへのフォールバックができない), それ未満のバージョンでは
自動的に旧構成にフォールバックする. 手動でのファイル切り替えは不要.

## Git

gitignoreは `.gitignore` はこのリポジトリの.gitignoreなので、利用するときは `gitignore` ファイルを利用する.

```
$ ln -s dotfiles/gitignore ~/.gitignore
```

## ZShell

`.zshrc.mine` を使う場合はZShellのPCRE拡張が必要.


## tmux

バージョンが2.9以上の場合は `.tmux.up_2_9.conf` を使う.

