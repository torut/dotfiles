;; install-elisp の設定
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")

;; auto-install の設定
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elisp/")
;; (auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

