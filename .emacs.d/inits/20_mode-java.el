;; JAVAモードの設定
(defun java-mode-setup ()
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4)
)

(add-hook 'java-mode-hook 'jave-mode-setup)
