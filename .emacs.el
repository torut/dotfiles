(setq load-path (cons "~/.emacs.d/elisp" load-path))

(require 'color-theme)
(load "./themes/color-theme-library.el")
(color-theme-charcoal-black)
(global-font-lock-mode t)

;; no messages for scratch buffer.
(setq initial-scratch-message "")

;; current line highlight
;; (require 'highlight-current-line)
;; (highlight-current-line-on t)

(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")

;; setting auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)
;; Use C-n/C-p to select candidates
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
;; start completion when entered 3 characters
(setq ac-auto-start 5)
;; Completion by TAB
(define-key ac-complete-mode-map "\t" 'ac-complete)

;; C-z is undo
(define-key global-map "\C-z" 'undo)

;; Japanese
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8-unix)


;; Anthy
(push "/usr/local/share/emacs/site-lisp/anthy/" load-path)
(load-library "anthy")
(setq default-input-method "japanese-anthy")

;; delete-backward-char
(global-set-key "\C-h" 'delete-backward-char)

;; hide menu-bar
(menu-bar-mode -1)

;; incremental C-x b
(iswitchb-mode 1)

;; colored region
(transient-mark-mode t)

;; ignore case
(setq read-file-name-completion-ignore-case t)

;; better switch to buffer
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; Set line width to 78 columns...
(setq fill-column 78)
(setq auto-fill-mode t)

;; line number
(line-number-mode t)
(column-number-mode t)
(setq linum-format "%4d ")

;; dired
(setq ls-lisp-dirs-first t)
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; font-lock
(global-font-lock-mode t)

;; background
(set-background-color "color-233")
;; (set-background-color "#004c4c")

;; backup files
(setq auto-save-default nil)
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/backup/emacs/") t)))

(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/backup/emacs"))
            backup-directory-alist))
(setq vc-make-backup-files t)


;; do chmod +x automatically if the saved file is executable.
(add-hook 'after-save-hook
        'executable-make-buffer-file-executable-if-script-p)

;; Tabs
(setq-default tab-width 4)
;; (setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)

;; diff-mode
(defun diff-mode-setup-faces ()
  (set-face-attribute 'diff-added nil
					  :foreground "white" :background "dark green")
  (set-face-attribute 'diff-removed nil
					  :foreground "white" :background "red")
)
(add-hook 'diff-mode-hook 'diff-mode-setup-faces)

(defun magit-setup-diff ()
  ;; 'allではなくtにすると現在選択中のhunkのみ強調表示する
  (setq magit-diff-refine-hunk 't)
  ;; diff用のfaceを設定する
  (diff-mode-setup-faces)
  ;; diffの表示設定が上書きされてしまうのでハイライトを無効にする
  (set-face-attribute 'magit-item-highlight nil :inherit nil)
)
(add-hook 'magit-mode-hook 'magit-setup-diff)


;; physical line
;; (load-library "ce-scroll")
(require 'physical-line)
(setq physical-line-slip-backward t)
(setq-default physical-line-mode t)
(global-set-key "\C-a" 'physical-line-beginning-of-line)
(global-set-key "\C-e" 'physical-line-end-of-line)

;; scroll
(setq scroll-conservatively 20
	  scroll-margin 2
	  scroll-step 1)


;; C
(setq c-default-style "bsd")
(setq c-basic-offset 4)


;; Perl
(defalias 'perl-mode 'cperl-mode)
(setq cperl-indent-level 4)
(setq cperl-close-paren-offset -4)
(setq cperl-auto-newline nil)
(setq cperl-indent-parens-as-block t)
(setq cperl-continued-statement-offset 4)
(setq cperl-label-offset -4)
(setq cperl-invalid-face nil)
(setq cperl-highlight-variables-indiscriminately t)
(add-hook 'cperl-mode-hook
      (lambda ()
        (setq tab-width 4)
        (copy-face 'font-lock-variable-name-face 'cperl-array-face)
        (copy-face 'font-lock-variable-name-face 'cperl-hash-face)
        (copy-face 'font-lock-function-name-face 'cperl-nonoverridable-face)
        ))
(autoload 'tt-mode "tt-mode")
(setq auto-mode-alist
      (append '(("\\.tt$" . tt-mode)) auto-mode-alist))

;; Ruby
(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys)))
(custom-set-variables
 '(ruby-insert-encoding-magic-comment nil))

;; Rails
;; (setq load-path (cons "~/.lisp/emacs-rails" load-path))
;; (require 'rails)
(setq auto-mode-alist  (cons '("\\.rhtml$" . html-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '("\\.erb$" . html-mode) auto-mode-alist))


;; CSS
(autoload 'css-mode "css-mode")
(setq auto-mode-alist (cons '("\\.css$" . css-mode) auto-mode-alist))
(setq cssm-indent-level 4)
(setq cssm-newline-before-closing-bracket t)
(setq cssm-indent-function #'cssm-c-style-indenter)


;; PHP
;;(load-library "php-mode")
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-hook 'php-mode-user-hook
  (lambda ()
    (setq tab-width 4)
    (setq c-basic-offset 4)
    ;; (setq indent-tabs-mode nil)
  )
)
(add-to-list 'auto-mode-alist '("\\.phtml(.*)?$" . html-mode))

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; Python
(autoload 'python-mode "python-mode" "Mode for editing Python source files")
(add-to-list 'auto-mode-alist '("\\.py" . python-mode))

;;
(setq auto-coding-functions nil)


;; svn
;;(require 'psvn)
(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)

;; git
(require 'magit)

;; javascript-mode
(autoload 'javascript-mode "javascript" nil t)
(add-to-list 'auto-mode-alist (cons  "\\.\\(js\\|as\\|json\\|jsn\\)\\'" 'javascript-mode))

;; grep-find
(setq grep-find-command "find . -type f ! -path '*.svn*' ! -path '*.log*' ! -path '*.git*' -exec grep -nH -e  {} /dev/null \\;")


;; moccur
(require 'color-moccur)
(require 'moccur-edit)


(setq inhibit-startup-message t)
(setq next-line-add-newlines nil)

;; show pattern mode
(show-paren-mode 1)

(add-hook 'java-mode-hook
	(lambda ()
;;		(setq indent-tabs-mode nil)
		(setq c-basic-offset 4)))

;; show line number for left side
(require 'linum)
(global-linum-mode)


;; move screen lines
(defun screen-column ()
  "get screen column"
  (save-excursion
    (let ((s-column (current-column)))
        (vertical-motion 0)
          (- s-column (current-column)))))

(defun move-beginning-of-screen-line ()
  "move beginning of screen line"
  (interactive)
  (vertical-motion 0))
 
(defun move-end-of-screen-line ()
  "move end of screen line"
  (interactive)
  (vertical-motion 1)
  (backward-char 1))
 
(defun next-screen-line ()
  "next screen line"
  (interactive)
  (if truncate-lines
        (next-line 1)
    (if (not (eq last-command 'next-screen-line))
        (setq keep-screen-column (screen-column)))
    (vertical-motion 1)
    (move-to-column (+ (current-column) keep-screen-column))))
 
(defun previous-screen-line ()
  "previous screen line"
  (interactive)
  (if truncate-lines  (previous-line 1)
    (if (not (eq last-command 'next-screen-line))
        (setq keep-screen-column (screen-column)))
    (vertical-motion -1)
    (move-to-column (+ (current-column) keep-screen-column)))
  (setq this-command 'next-screen-line))

(global-set-key "\C-a" 'move-beginning-of-screen-line)
(global-set-key "\C-e" 'move-end-of-screen-line)
(global-set-key "\C-n" 'next-screen-line)
(global-set-key "\C-p" 'previous-screen-line)

;; Shell
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Mailer Mew
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
