# git-deltaのインストール

1. githubからパッケージをダウンロード.
   - https://github.com/dandavison/delta/releases/download/0.19.2/git-delta_0.19.2_amd64.deb
   - （最新版要確認）
2. dpkg コマンドでインストール
   - `sudo dpkg -i git-delta_0.19.2_amd64.deb`

# lazygitのインストール

1. githubからパッケージをダウンロード.
   - https://github.com/jesseduffield/lazygit/releases
2. tar展開して `lazygit` バイナリをPATHの通るところに配置.
3. `.config/lazygit` をシンボリックリンク貼る.


# AWS-CLIのインストール

1. 以下のコマンドを実行してcliをインストール.
   - `curl -fsSL https://awscli.amazonaws.com/v2/install.sh | bash`
2. インストールしたら認証を通す.
   - `aws login`
   - ブラウザが開くのでそっちで認証する.

# uvのインストール

1. 以下のコマンドを実行してuv,uvxをインストール.
   - `curl -LsSf https://astral.sh/uv/install.sh | sh`

