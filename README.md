# dotfiles

それぞれ $HOME ディレクトリでシンボリックリンクを張るなどして使う.

## Claude Code

[dotfiles/.claude](./.claude) 以下にあるものをそれぞれでシンボリックリンクで利用

### プラグイン

- [claude-code-starter-kit](https://github.com/cloudnative-co/claude-code-starter-kit)
    - 最優先でインストール.
    - Standardプロファイルを利用.

- [agent-plugins](https://github.com/awslabs/agent-plugins/blob/main/README.jp.md)
    - deploy-on-aws: コスト見積やアーキテクチャ検討、構成図生成ができる.

### ツール

- [ccstatusline](https://github.com/sirmalloc/ccstatusline)
    - ステータスラインの表示の設定ツール.
    - 設定ファイルは `.config/ccstatusline/settings.json` を利用する.


## Emacs

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

.gitconfigは `.gitconfig.d` も参照するので同じ用にシンボリックリンクする.
```
$ ln -s dotfiles/.gitconfig.d ~/.gitconfig.d
$ ln -s dotfiles/.gitconfig ~/.gitconfig
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

端末固有の設定を行う場合は `.zshrc.local` を $HOME ディレクトリに準備すると自動的に読み込む.

