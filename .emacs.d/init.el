;; ロードパスを追加する関数を定義 (Emacs 24-28 系の init-loader が使用)
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
;; GNU ELPAの署名鍵ローテーションにローカルのgnupgキーリングが追従できていない環境では
;; archive-contents/パッケージ本体の署名検証が失敗しインストールできなくなるため無効化する。
;; (MELPA由来のパッケージはそもそも署名なしで配布されている)
(setq package-check-signature nil)
(package-initialize)

;; MELPAで現在配布されているvertico/consult/marginaliaはEmacs 29.1以降を、
;; modus-themes/magit/markdown-modeはEmacs 28.1以降を要求する
;; (package.elは過去バージョンへのフォールバックができないため、
;;  古いEmacsでは配布中のバージョンをそもそもインストールできない)。
;; そのため一番厳しい要求に合わせ29.1をしきい値に設定ファイル一式を丸ごと出し分ける。
(if (version< emacs-version "29.1")
    ;; Emacs 24-28: 旧来の anything + init-loader 構成
    (progn
      (add-to-load-path "elisp" "inits-legacy")
      (require 'init-loader)
      (custom-set-variables
       '(init-loader-show-log-after-init nil))
      (init-loader-load "~/.emacs.d/inits-legacy"))

  ;; Emacs 29.1 以降: use-package + vertico 構成 (use-packageは本体組み込み)
  (progn
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
