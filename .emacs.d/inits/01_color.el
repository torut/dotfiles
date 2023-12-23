;; カラーテーマ
(require 'color-theme)
(load "./themes/color-theme-library.el")
(color-theme-charcoal-black)
(global-font-lock-mode t)

;; 背景色
(set-background-color "color-233")

;; 現在行をハイライトする
;; (require 'highlight-current-line)
;; (highlight-current-line-on t)

;; 行末の空白をハイライトする
(setq-default show-trailing-whitespace t)
;; ハイライトする色
(set-face-background 'trailing-whitespace "#990000")

;; 選択範囲を色つけする
(transient-mark-mode t)

