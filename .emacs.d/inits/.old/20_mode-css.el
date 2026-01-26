;; CSSモードの設定
(autoload 'css-mode "css-mode")
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(setq cssm-indent-level 4)
(setq cssm-newline-before-closing-bracket t)
(setq cssm-indent-function #'cssm-c-style-indenter)

;; SCSSモードの設定
(autoload 'scss-mode "scss-mode")
;; 自動コンパイルをオフにする
(setq scss-compile-at-save nil)
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

;; LESSモードの設定
(require 'less-css-mode)
;; 自動コンパイルをオフにする
(setq less-compile-at-save nil)
(add-to-list 'auto-mode-alist '("\\.less$" . less-css-mode))

