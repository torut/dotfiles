# dotfiles

それぞれ $HOME ディレクトリでシンボリックリンクを張るなどして使う.

## Emacs

php-modeはEmacsのバージョン24以上で想定.
24未満の場合は `php-mode.el.under24` をリネームして使う.

```
$ mv php-mode.el php-mode.el.upper23
$ mb php-mode.el.under24 php-mode.el
```

## Git

gitignoreは `.gitignore` はこのリポジトリの.gitignoreなので、利用するときは `gitignore` ファイルを利用する.

```
$ ln -s dotfiles/gitignore ~/.gitignore
```

## ZShell

`.zshrc.mine` を使う場合はZShellのPCRE拡張が必要.


## tmux

バージョンが2.9以上の場合は `.tmux.up_2_9.conf` を使う.

