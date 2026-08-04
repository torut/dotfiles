;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs 本体に関する設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package emacs
  :bind (("C-z" . undo))
  :init
  ;;;; 表示関係 (GUI起動時のみ適用)
  (when (display-graphic-p)
    (setq initial-frame-alist '((top . 1) (left . 1) (width . 160) (height . 52)))
    (tool-bar-mode -1))
  (menu-bar-mode -1)
  (setq scroll-conservatively 20
        scroll-margin 2
        scroll-step 1)

  ;;;; 基本的な編集設定
  (setq line-move-visual nil) ; 論理行単位での移動
  (setq fill-column 78)
  (add-hook 'text-mode-hook #'auto-fill-mode) ; テキストモードでのみ auto-fill を有効化
  (setq next-line-add-newlines nil) ; バッファ末尾の自動改行を無効化

  ;;;; 日本語環境とエンコーディング
  (set-language-environment "Japanese")
  (set-default-coding-systems 'utf-8-unix)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)

  ;;;; フォント
  (set-face-attribute 'default nil :family nil :height 180)

  ;;;; インデントとタブ
  (setq-default tab-width 4
                c-basic-offset 4
                indent-tabs-mode t)

  ;;;; ファイル名の補完
  (setq read-file-name-completion-ignore-case t
        completion-ignore-case t)


  ;;;; 自動バックアップ
  (setq make-backup-files t
        backup-directory-alist '(("." . "~/.emacs.d/backup"))
        auto-save-default nil
        vc-make-backup-files t)

  ;;;; UIと挙動
  (setq initial-scratch-message "")
  (setq inhibit-startup-message t)
  (fset 'yes-or-no-p 'y-or-n-p) ; [yes or no] を [y or n] に
  (setq confirm-kill-emacs 'y-or-n-p) ; 終了確認

  (keyboard-translate ?\C-h ?\C-?)
  (global-set-key "\C-h" nil)

  ;; NOTE: iswitchb-mode は古い機能です。
  ;;       ステップバイステップガイドで提案した Vertico + Consult の利用を推奨します。
  ;;       (use-package consult) の :bind で ("C-x b" . consult-buffer) のように設定します。
  ;; (iswitchb-mode 1)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 各種パッケージ設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 対応する括弧をハイライト
(use-package paren
  :ensure nil
  :config
  (show-paren-mode 1))

;; 行番号表示 (linum-mode の後継)
(use-package display-line-numbers
  :ensure nil
  :hook (prog-mode . display-line-numbers-mode) ; プログラミングモードでのみ有効化
  :config
  (setq display-line-numbers-width 4))

;; 自動補完 (auto-complete)
;; NOTE: corfu への移行を検討

;; バッファ名が重複した場合のユニーク化
(use-package uniquify
  :ensure nil
  :config
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

;; ステータスバーに時刻を表示
(use-package time
  :ensure nil
  :init
  (setq display-time-day-and-date nil
        display-time-24hr-format t
		display-time-format "%Y-%m-%d %H:%M"))
  :config
  (display-time-mode 1)

;; dired (ディレクトリ編集)
(use-package dired
  :ensure nil ; 本体付属なのでインストールしない
  :config
  (setq dired-listing-switches "-alh --time-style=long-iso")
  (setq dired-dwim-target t)
  (setq dired-recursive-copies 'always)
  (setq dired-isearch-filenames t)
  (setq find-ls-option '("-exec ls -ld --time-style=long-iso {} \;" . "-ld")))

;; wdired (diredバッファでの直接リネーム)
(use-package wdired
  :ensure nil
  :hook (dired-mode . (lambda () (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode))))

;; ファイルの自動再読み込み
(use-package autorevert
  :ensure nil
  :config
  (global-auto-revert-mode 1))

;; grep-findのコマンド設定
(use-package grep
  :ensure nil
  :config
  (setq grep-find-command "find . -type f ! -path '*.svn*' ! -path '*.log*' ! -path '*.git*' -exec grep -nHi -e  {} /dev/null \\;"))

;; シェルモードでANSIカラーを有効化
(use-package ansi-color
  :hook (shell-mode . ansi-color-for-comint-mode-on))

;; 保存時に実行権限を付与
(use-package executable
  :ensure nil
  :hook (after-save . executable-make-buffer-file-executable-if-script-p))
