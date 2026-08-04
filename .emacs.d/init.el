;; ロードパスを追加する関数を定義 (Emacs 24-26 系の init-loader が使用)
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	            (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	        (normal-top-level-add-subdirs-to-load-path))))))

;; package.el の初期化 (新旧共通)
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; vertico/consult/marginalia/orderless は Emacs 27.1 以降が必須のため、
;; Emacs のバージョンで設定ファイル一式を丸ごと出し分ける。
(if (version< emacs-version "27.1")
    ;; Emacs 24-26: 旧来の anything + init-loader 構成
    (progn
      (add-to-load-path "elisp" "inits-legacy")
      (require 'init-loader)
      (custom-set-variables
       '(init-loader-show-log-after-init nil))
      (init-loader-load "~/.emacs.d/inits-legacy"))

  ;; Emacs 27.1 以降: use-package + vertico 構成
  (progn
    ;; use-package は Emacs 29 以降のみ本体組み込み。
    ;; 27.1/28系では未インストールの場合に package.el 経由で導入する。
    (unless (package-installed-p 'use-package)
      (package-refresh-contents)
      (package-install 'use-package))
    (require 'use-package)
    (setq use-package-always-ensure t)

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
    (load (expand-file-name "inits/20_lang-yaml.el" user-emacs-directory))))
