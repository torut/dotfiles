;; Recentf
(use-package recentf
  :ensure nil
  :init
  (recentf-mode 1)
  (setq recentf-max-saved-items 500))

;; Vertico を有効にする
(use-package vertico
  :init
  (setq vertico-count 20
		vertico-resize nil)
  (vertico-mode 1))


(use-package consult
  :after vertico
  :bind ("C-x C-a" . consult-buffer)
  )

;; 補完候補に説明を追加する
(use-package marginalia
  :after vertico
  :init
  (marginalia-mode)
  :config
  (defun my-marginalia-file-date (time)
    (format-time-string "%Y-%m-%d %H:%M:%S" time))
  (advice-add 'marginalia--time :override #'my-marginalia-file-date))

;; 入力順を問わない柔軟な絞り込みを可能にする
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles basic partial-completion)))))

(use-package savehist
  :ensure nil
  :init
  (savehist-mode 1)
  :config
  (setq savehist-additional-variables
        '(search-ring
          regexp-search-ring)))
