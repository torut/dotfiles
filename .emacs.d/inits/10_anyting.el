;; Anything.el
(require 'anything)
(require 'anything-config)
(require 'recentf-ext)
(setq anything-sources
      '(anything-c-source-buffers+
        anything-c-source-recentf
        anything-c-source-emacs-commands
        anything-c-source-emacs-functions
        anything-c-source-files-in-current-dir
        )
      )
(define-key global-map "\C-x\C-a" 'anything)
(eval-after-load "anything"
  '(define-key anything-map (kbd "C-h") 'delete-backward-char)
  )
;; recentf の最大数を変更
(setq recentf-max-saved-items 100)

;; popwin.el
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq anything-samewindow nil)
(push '("*anything*" :height 20) popwin:special-display-config)

