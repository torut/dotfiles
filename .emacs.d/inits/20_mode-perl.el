;; Perlモードの設定
(defalias 'perl-mode 'cperl-mode)
(setq cperl-indent-level 4)
(setq cperl-close-paren-offset -4)
(setq cperl-auto-newline nil)
(setq cperl-indent-parens-as-block t)
(setq cperl-continued-statement-offset 4)
(setq cperl-label-offset -4)
(setq cperl-invalid-face nil)
(setq cperl-highlight-variables-indiscriminately t)

(defun cperl-mode-setup ()
  (setq tab-width 4)
  (copy-face 'font-lock-variable-name-face 'cperl-array-face)
  (copy-face 'font-lock-variable-name-face 'cperl-hash-face)
  (copy-face 'font-lock-function-name-face 'cperl-nonoverridable-face)
)
(add-hook 'cperl-mode-hook 'cperl-mode-setup)

;; Template-Toolkitモードの設定
(autoload 'tt-mode "tt-mode")
(setq auto-mode-alist
      (append '(("\\.tt$" . tt-mode)) auto-mode-alist))
