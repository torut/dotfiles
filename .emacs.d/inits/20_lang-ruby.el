;; Ruby Mode (本体)
(use-package ruby-mode
  :ensure t ; ruby-mode は外部パッケージなのでインストールを指示
  :mode (("\.rb\'" . ruby-mode)
         ("Gemfile\'" . ruby-mode))
  :interpreter ("ruby" . ruby-mode)
  :config
  ;; magic comment を自動挿入する関数を定義
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
              (encoding (cond ((string-match "japanese-iso-8bit\|euc-j" coding-system) "euc-jp")
                              ((string-match "shift.jis\|sjis\|cp932" coding-system) "shift_jis")
                              ((string-match "utf-8" coding-system)  "utf-8")
                              )))
          (when encoding
            (insert (format "# -*- coding: %s -*-" encoding))))
      ))
  :hook
  (before-save . ruby-insert-magic-comment-if-needed)))

;; Ruby Electric (自動 'end' 挿入など)
(use-package ruby-electric
  :ensure t ; ruby-electric は外部パッケージなのでインストールを指示
  :config
  (defun ruby-insert-end ()
    (interactive)
    (insert "end")
    (ruby-indent-line t)
    (end-of-line))
  :hook (ruby-mode . ruby-electric-mode))
