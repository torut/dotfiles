;; CSS Mode (本体付属)
(use-package css-mode
  :ensure nil
  :mode ("\.css\'" . css-mode)
  :config
  ;; Emacs 29標準のcss-modeでは、インデントオフセットはこちらの変数を使います。
  (setq css-indent-offset 4
		cssm-newline-before-closing-bracket t))
