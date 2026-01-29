;; パッケージ管理 (package.el) と use-package の初期設定
;; package.el の初期化
(require 'package)

;; パッケージリポジトリを追加
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; パッケージリストを初期化
(package-initialize)

;; use-package を有効にする
;; (setq use-package-always-ensure t) を設定すると、
;; use-packageで指定したパッケージが未インストールの場合、自動でインストールされます。
(require 'use-package)
(setq use-package-always-ensure t)

;; ファイルを読み込む
(load (expand-file-name "inits/00_vertico.el" user-emacs-directory))
(load (expand-file-name "inits/00_inits.el" user-emacs-directory))
(load (expand-file-name "inits/00_color.el" user-emacs-directory))
(load (expand-file-name "inits/10_git.el" user-emacs-directory))
(load (expand-file-name "inits/20_lang-c.el" user-emacs-directory))
(load (expand-file-name "inits/20_lang-css.el" user-emacs-directory))
(load (expand-file-name "inits/20_lang-diff.el" user-emacs-directory))
(load (expand-file-name "inits/20_lang-html.el" user-emacs-directory))
(load (expand-file-name "inits/20_lang-js.el" user-emacs-directory))
(load (expand-file-name "inits/20_lang-md.el" user-emacs-directory))
(load (expand-file-name "inits/20_lang-perl.el" user-emacs-directory))
(load (expand-file-name "inits/20_lang-php.el" user-emacs-directory))
(load (expand-file-name "inits/20_lang-python.el" user-emacs-directory))
(load (expand-file-name "inits/20_lang-ruby.el" user-emacs-directory))
(load (expand-file-name "inits/20_lang-yaml.el" user-emacs-directory))


;; --- ここからテスト用

