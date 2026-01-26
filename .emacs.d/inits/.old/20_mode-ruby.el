;; Rubyモードの設定
(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(setq auto-mode-alist
  (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq auto-mode-alist
  (append '(("Gemfile$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist
  (append '(("ruby" . ruby-mode))
    interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook '(lambda () (inf-ruby-keys)))

;; Ruby-electric
(defun ruby-insert-end ()
  (interactive)
  (insert "end")
  (ruby-indent-line t)
  (end-of-line))

(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

;; ruby-block
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

;; magic comment を自動挿入するように
(defun ruby-insert-magic-comment-if-needed ()
  "バッファのcoding-systemをもとにmagic commentをつける。"
  (when (and (eq major-mode 'ruby-mode)
    (find-multibyte-characters (point-min) (point-max) 1))
    (save-excursion
      (goto-char 1)
      (when (looking-at "^#!")
        (forward-line 1))
      (if (re-search-forward "^#.+coding" (point-at-eol) t)
        (delete-region (point-at-bol) (point-at-eol))
        (open-line 1))
      (let* ((coding-system (symbol-name buffer-file-coding-system))
        (encoding (cond ((string-match "japanese-iso-8bit\\|euc-j" coding-system) "euc-jp")
                        ((string-match "shift.jis\\|sjis\\|cp932" coding-system) "shift_jis")
                        ((string-match "utf-8" coding-system)  "utf-8")
        )))
        (insert (format "# -*- coding: %s -*-" encoding))
      )
    )
  )
)
(add-hook 'before-save-hook 'ruby-insert-magic-comment-if-needed)

;; Railsモードの設定
;; (add-to-list 'auto-mode-alist '("\\.rhtml$" . html-mode))
;; (add-to-list 'auto-mode-alist '("\\.erb$" . html-mode))

