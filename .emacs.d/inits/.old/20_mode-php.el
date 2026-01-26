;; PHPモードの設定
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

(defun php-mode-user-setup ()
  (setq tab-width 4)
  (setq c-basic-offset 4)
  (setq indent-tabs-mode t) ; t => tab, nil => space
)
(add-hook 'php-mode-user-hook 'php-mode-user-setup)

(defun php-mode-setup ()
  (c-set-offset 'case-label' 4)
  (c-set-offset 'arglist-intro' 4)
  (c-set-offset 'arglist-cont-nonempty' 4)
  (c-set-offset 'arglist-close' 0)
)
(add-hook 'php-mode-hook 'php-mode-setup)

