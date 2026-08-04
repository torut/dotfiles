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

## tmux

`.tmux.conf`はtmuxのバージョンで読み込む設定を自動的に切り替える(`if-shell`によるバージョン判定).

- tmux 2.9以降: `.tmux.conf.d/2.9-and-later.conf` (`-style`系オプション、ペインのディレクトリ引き継ぎ対応)
- tmux 2.9未満: `.tmux.conf.d/pre-2.9.conf` (`-fg`/`-bg`/`-attr`系オプション)

tmux 2.9で`-fg`/`-bg`/`-attr`系オプションが削除され`-style`に統合されたための分岐. バージョン判定は
`.tmux.conf.d/tmux-is-2.9-or-later.sh`で行う(`if-shell`の`-F`フラグは古いtmux(1.8など)には無いため).
`.tmux.conf`と`.tmux.conf.d/`をあわせてシンボリックリンクする.

```
$ ln -s dotfiles/.tmux.conf ~/.tmux.conf
$ ln -s dotfiles/.tmux.conf.d ~/.tmux.conf.d
```

## ZShell

(過去は`.zsh.d/git-prompt.zsh`がPCRE拡張を要求していたが、該当のデッドコードを削除したため現在は不要)

