;; Diffモード
(use-package diff-mode
  :ensure nil ; Emacs本体付属の機能
  :hook
  (diff-mode .
             (lambda ()
               ;; 追加された行のフェイス
               (set-face-attribute 'diff-added nil
                                   :foreground "white" :background "dark green")
               ;; 削除された行のフェイス
               (set-face-attribute 'diff-removed nil
                                   :foreground "white" :background "red"))))
