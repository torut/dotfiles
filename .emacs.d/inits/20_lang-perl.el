;; Perl Mode (CPerl Mode)
(use-package cperl-mode
  :ensure nil ; Emacs本体付属の機能
  :init
  ;; perl-mode は cperl-mode のエイリアスとして設定
  (defalias 'perl-mode 'cperl-mode)

  ;; CPerl Mode のデフォルトインデント設定など
  (setq cperl-indent-level 4
        cperl-close-paren-offset -4
        cperl-auto-newline nil
        cperl-indent-parens-as-block t
        cperl-continued-statement-offset 4
        cperl-label-offset -4
        cperl-invalid-face nil
        cperl-highlight-variables-indiscriminately t
		indent-tabs-mode nil)
  :hook
  (cperl-mode .
              (lambda ()
                ;; タブ幅の設定
                (setq tab-width 4)
				(setq-local indent-tabs-mode nil)
                ;; フェイスのコピー (シンタックスハイライト関連)
                (copy-face 'font-lock-variable-name-face 'cperl-array-face)
                (copy-face 'font-lock-variable-name-face 'cperl-hash-face)
                (copy-face 'font-lock-function-name-face 'cperl-nonoverridable-face))))

;; Template-toolkit Mode
(use-package tt-mode
  :ensure t ; tt-mode は外部パッケージなのでインストールを指示
  :mode (("\.tt$" . tt-mode)))
