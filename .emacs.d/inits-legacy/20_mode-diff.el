;; diff モードの設定
(defun diff-mode-setup-faces ()
  ;; 追加された文字の色、背景色の設定
  (set-face-attribute 'diff-added nil
					  :foreground "white" :background "dark green")
  ;; 削除された文字の色、背景色の設定
  (set-face-attribute 'diff-removed nil
					  :foreground "white" :background "red")
  )
(add-hook 'diff-mode-hook 'diff-mode-setup-faces)
