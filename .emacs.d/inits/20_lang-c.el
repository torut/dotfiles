;; C言語
(use-package cc-mode
  :ensure nil ; Emacs本体付属の機能
  :init
  ;; C/C++やJavaなど、cc-modeから派生するモードのデフォルト設定
  (setq c-default-style "bsd"
        c-basic-offset 4))
