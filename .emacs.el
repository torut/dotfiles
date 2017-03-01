(add-to-list 'load-path "~/.emacs.d/elisp")
;; (setq load-path (cons "~/.emacs.d/elisp" load-path))

;; カラーテーマ
(require 'color-theme)
(load "./themes/color-theme-library.el")
(color-theme-charcoal-black)
(global-font-lock-mode t)

;; 背景色
(set-background-color "color-233")
;; (set-background-color "#004c4c")

;; scratch バッファに表示されるメッセージ
(setq initial-scratch-message "")

;; 現在行をハイライトする
;; (require 'highlight-current-line)
;; (highlight-current-line-on t)

;; 行の扱いを論理行(改行までを1行)として扱う
(setq line-move-visual nil)

;; install-elisp の設定
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")

;; auto-install の設定
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elisp/")
;; (auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

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

;; 自動補完の設定
(require 'auto-complete)
(global-auto-complete-mode t)

;; C-n/C-p を使って補完リストから選択できるようにする
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

;; 指定した文字数以上入力したら補完をおこなう
(setq ac-auto-start 5)

;; タブキーで補完できるようにする
(define-key ac-complete-mode-map "\t" 'ac-complete)

;; C-z キーで Undo できるようにする
(define-key global-map "\C-z" 'undo)

;; 日本語設定
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8-unix)

;; 日本語IME Anthy の設定
(push "/usr/local/share/emacs/site-lisp/anthy/" load-path)
(load-library "anthy")
(setq default-input-method "japanese-anthy")

;; C-h でバックスペースキーと同じ動きをするようにする
;; (global-set-key "\C-h" 'delete-backward-char)
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)

;; メニューバーを隠す
(menu-bar-mode -1)

;; C-x b のバッファリストが表示できるように
(iswitchb-mode 1)

;; 選択範囲を色つけする
(transient-mark-mode t)

;; ファイル名の問い合わせで大文字小文字を区別しない
(setq read-file-name-completion-ignore-case t)

;; ファイル名の補完で大文字小文字を区別しない
(setq completion-ignore-case t)

;; 外部で編集されたら自動再読み込みする
(global-auto-revert-mode 1)

;; 同名ファイルの場合、識別文字列をディレクトリ名とかにする
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; 1行78文字とする
(setq fill-column 78)
;; M-q で78文字で整形できるようにする
(setq auto-fill-mode t)

;; 行番号を表示する
(require 'linum)
(global-linum-mode)
(line-number-mode t)
(column-number-mode t)

;; 行番号のフォーマット
(setq linum-format "%4d ")

;; 行と桁をステータスバーに表示する
(line-number-mode t)
(column-number-mode t)

;; 行末の空白をハイライトする
(setq-default show-trailing-whitespace t)
;; ハイライトする色
(set-face-background 'trailing-whitespace "#990000")

;; [yes or no] の表示を [y or n] に短縮する
(fset 'yes-or-no-p 'y-or-n-p)

;; ファイルリストで ls を呼ぶオプションを指定
(setq dired-listing-switches "-alh")
;; ファイルリストでリネームができるようにする
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; 自動バックアップ
(setq auto-save-default nil)
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/backup/emacs/") t)))

(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/backup/emacs"))
            backup-directory-alist))
(setq vc-make-backup-files t)

;; 実行できるスクリプトは保存時に実行権限をつける
(add-hook 'after-save-hook
        'executable-make-buffer-file-executable-if-script-p)

;; タブの扱い
(setq-default tab-width 4)				;; 空白4文字相当
(setq-default indent-tabs-mode t)		;; タブでのインデント
(setq-default c-basic-offset 4)

;; diff モードの設定
(defun diff-mode-setup-faces ()
  ;; 追加された文字の色、背景色の設定
  (set-face-attribute 'diff-added nil
					  :foreground "white" :background "dark green")
  ;; 削除された文字の色、背景色の設定
  (set-face-attribute 'diff-removed nil
					  :foreground "white" :background "red")
)
(add-hook 'diff-mode-hook 'diff-mode-setup-faces)

;; スクロール量設定
(setq scroll-conservatively 20
	  scroll-margin 2
	  scroll-step 1)

;; webモード
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-markup-indent-offset   2)

;; htmlモードの設定
(add-hook 'html-mode-hook
          (lambda()
            (setq sgml-basic-offset 2)  ;; 空白2文字
            (setq indent-tabs-mode nil) ;; インデントにタブを使わない
            )
          )

;; C言語モードの設定
(setq c-default-style "bsd")
(setq c-basic-offset 4)

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
(add-hook 'cperl-mode-hook
      (lambda ()
        (setq tab-width 4)
        (copy-face 'font-lock-variable-name-face 'cperl-array-face)
        (copy-face 'font-lock-variable-name-face 'cperl-hash-face)
        (copy-face 'font-lock-function-name-face 'cperl-nonoverridable-face)
        ))
;; Template-Toolkitモードの設定
(autoload 'tt-mode "tt-mode")
(setq auto-mode-alist
      (append '(("\\.tt$" . tt-mode)) auto-mode-alist))

;; Rubyモードの設定
(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq auto-mode-alist
      (append '(("Gemfile$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
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
             (encoding (cond ((string-match "japanese-iso-8bit\\|euc-j" coding-system)
                              "euc-jp")
                             ((string-match "shift.jis\\|sjis\\|cp932" coding-system)
                              "shift_jis")
                             ((string-match "utf-8" coding-system)
                              "utf-8"))))
        (insert (format "# -*- coding: %s -*-" encoding))
        )
      )
    )
  )
(add-hook 'before-save-hook 'ruby-insert-magic-comment-if-needed)

;; Railsモードの設定
;; (add-to-list 'auto-mode-alist '("\\.rhtml$" . html-mode))
;; (add-to-list 'auto-mode-alist  '("\\.erb$" . html-mode))

;; hamlモードの設定
(require 'haml-mode)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))

;; CSSモードの設定
(autoload 'css-mode "css-mode")
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(setq cssm-indent-level 4)
(setq cssm-newline-before-closing-bracket t)
(setq cssm-indent-function #'cssm-c-style-indenter)

;; SCSSモードの設定
(autoload 'scss-mode "scss-mode")
(setq scss-compile-at-save nil) ;; 自動コンパイルをオフにする
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

;; LESSモードの設定
(require 'less-css-mode)
;; (autoload 'less-mode "less-css-mode")
(setq less-compile-at-save nil) ;; 自動コンパイルをオフにする
(add-to-list 'auto-mode-alist '("\\.less$" . less-css-mode))

;; PHPモードの設定
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-hook 'php-mode-user-hook
  '(lambda ()
    (setq tab-width 4)
    (setq c-basic-offset 4)
    (setq indent-tabs-mode t)           ; t => tab, nil => space
  )
)
(add-hook 'php-mode-hook
  '(lambda ()
    (c-set-offset 'case-label' 4)
    (c-set-offset 'arglist-intro' 4)
    (c-set-offset 'arglist-cont-nonempty' 4)
    (c-set-offset 'arglist-close' 0)
  )
)
(add-to-list 'auto-mode-alist '("\\.phtml(.*)?$" . html-mode))

;; YAMLモードの設定
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; Pythonモードの設定
(autoload 'python-mode "python-mode" "Mode for editing Python source files")
(add-to-list 'auto-mode-alist '("\\.py" . python-mode))

;;
(setq auto-coding-functions nil)

;; svn
(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)

;; magit
(require 'magit)

;; magit の diff モードの設定
(defun magit-setup-diff ()
  ;; 'allではなくtにすると現在選択中のhunkのみ強調表示する
  (setq magit-diff-refine-hunk t)
  ;; diff用のfaceを設定する
  (diff-mode-setup-faces)
  ;; diffの表示設定が上書きされてしまうのでハイライトを無効にする
  (set-face-attribute 'magit-item-highlight nil :inherit nil)
)
(add-hook 'magit-mode-hook 'magit-setup-diff)

;; javascriptモードの設定
;; (autoload 'javascript-mode "javascript" nil t)
;; (add-to-list 'auto-mode-alist (cons  "\\.\\(js\\|as\\|json\\|jsn\\)\\'" 'javascript-mode))
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist (cons  "\\.\\(js\\|as\\|json\\|jsn\\)\\'" 'js2-mode))

;; coffeeモードの設定
(autoload 'coffee-mode "coffee-mode" "Major mode for editing CoffeeScript." t)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(defun coffee-custom ()
  "coffee-mode-hook"
  (and (set (make-local-variable 'tab-width) 2)
       (set (make-local-variable 'coffee-tab-width) 2))
)
(add-hook 'coffee-mode-hook  '(lambda() (coffee-custom)))


;; grep-findのコマンドを設定
(setq grep-find-command "find . -type f ! -path '*.svn*' ! -path '*.log*' ! -path '*.git*' -exec grep -nHi -e  {} /dev/null \\;")

;; moccur
(require 'color-moccur)
(require 'moccur-edit)

;; startup バッファを表示しない
(setq inhibit-startup-message t)

;; バッファの最後に空行を入れないようにする
(setq next-line-add-newlines nil)

;; 対応する括弧をハイライトする
(show-paren-mode 1)

;; JAVAモードの設定
(add-hook 'java-mode-hook
	(lambda ()
		(setq indent-tabs-mode nil)
		(setq c-basic-offset 4)))

;; Shell
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Mailer Mew
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
