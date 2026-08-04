;; テーマ読み込み
(use-package modus-themes
  :ensure t
  :init
  (setq modus-themes-bold-constructs t
        modus-themes-italic-constructs nil)
  :config
  (load-theme 'modus-vivendi t))

;; 行末の空白をハイライト
(use-package emacs
  :ensure nil
  :init
  (setq-default show-trailing-whitespace t)
  (set-face-background 'trailing-whitespace "#990000"))

;; 現在行のハイライト (hl-line-mode)
(use-package hl-line
  :ensure nil
  :hook (prog-mode . hl-line-mode) ; プログラミングモードでのみ有効化など
  :config
  (global-hl-line-mode 1))

