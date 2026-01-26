# dotfiles

それぞれ $HOME ディレクトリでシンボリックリンクを張るなどして使う.

## Emacs

バージョン29以降用.
それ以前は master ブランチを参照.


## Git

gitignoreは `.gitignore` はこのリポジトリの.gitignoreなので、利用するときは `gitignore` ファイルを利用する.

```
$ ln -s dotfiles/gitignore ~/.gitignore
```

## ZShell

`.zshrc.mine` を使う場合はZShellのPCRE拡張が必要.


## tmux

バージョンが2.9以上の場合は `.tmux.up_2_9.conf` を使う.

