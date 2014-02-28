;; scratch バッファに表示されるメッセージ
(setq initial-scratch-message "")

;; 行の扱いを論理行(改行までを1行)として扱う
(setq line-move-visual nil)

;; 日本語設定
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8-unix)

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

;; C-h でバックスペースキーと同じ動きをするようにする
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
(setq auto-fill-mode t)	;; M-q で78文字で整形できるようにする

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
(setq-default tab-width 4)	  ;; 空白4文字相当
(setq-default indent-tabs-mode t) ;; タブでのインデント
(setq-default c-basic-offset 4)

;; grep-findのコマンドを設定
(setq grep-find-command "find . -type f ! -path '*.svn*' ! -path '*.log*' ! -path '*.git*' -exec grep -nHi -e  {} /dev/null \\;")

;; startup バッファを表示しない
(setq inhibit-startup-message t)

;; バッファの最後に空行を入れないようにする
(setq next-line-add-newlines nil)

;; 対応する括弧をハイライトする
(show-paren-mode 1)

;; Shell
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;; スクロール量設定
(setq scroll-conservatively 20
	  scroll-margin 2
	  scroll-step 1)

