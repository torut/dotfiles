; 表示関係
;; 表示位置、縦行数、横列数の設定
(setq initial-frame-alist
  '((top . 1) (left . 1) (width . 160) (height . 52)))

;; ツールバーの非表示
(tool-bar-mode -1)

;; メニューバーの非表示
(menu-bar-mode -1)

;; スクロール量設定
(setq scroll-conservatively 20)
(setq scroll-margin 2)
(setq scroll-step 1)

; 行や行番号など
;; 行の扱いを論理行(改行までを1行)として扱う
(setq line-move-visual nil)

;; 1行78文字とする
(setq fill-column 78)
(setq auto-fill-mode t)	;; M-q で78文字で整形できるようにする

;; 行番号を表示する
(require 'linum)
(global-linum-mode)
(line-number-mode t)
(column-number-mode t)

;; 行番号のフォーマット
(setq linum-format "%4d|")

; 日本語設定(文字コードはUTF8)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8-unix)

;; フォントサイズ
(set-face-attribute 'default nil :family nil :height 180)

; タブの扱い
;; 空白4文字相当
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
;; タブでのインデント
(setq-default indent-tabs-mode t)

;; 対応する括弧をハイライトする
(show-paren-mode 1)

; キーマッピングの変更
;; C-z キーで Undo できるようにする
(define-key global-map "\C-z" 'undo)
;; C-h でバックスペースキーと同じ動きをするようにする
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)

; 自動補完の設定
(require 'auto-complete)
(global-auto-complete-mode t)

;; C-n/C-p を使って補完リストから選択できるようにする
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

;; 指定した文字数以上入力したら補完をおこなう
(setq ac-auto-start 5)

;; タブキーで補完できるようにする
(define-key ac-complete-mode-map "\t" 'ac-complete)

; ファイル名などの設定
;; ファイル名の問い合わせで大文字小文字を区別しない
(setq read-file-name-completion-ignore-case t)

;; ファイル名の補完で大文字小文字を区別しない
(setq completion-ignore-case t)

;; 同名ファイルの場合、識別文字列をディレクトリ名とかにする
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

; ステータスバーの設定
;; 行と桁をステータスバーに表示する
(line-number-mode t)
(column-number-mode t)

;; ステータスバーに時刻表示
(setq display-time-day-and-date t)
(setq display-time-interval 60)
;; 時刻表示のフォーマット
(setq display-time-string-forms
  '((format "%d-%02d-%02d %02d:%02d"
    (string-to-number year) (string-to-number month) (string-to-number day)
    (string-to-number 24-hours) (string-to-number minutes) (string-to-number seconds)
)))
;; 時刻表示の左隣に日付を追加。
(setq display-time-kawakami-form t)
;; 24時間制
(setq display-time-24hr-format t)
(display-time-mode t)

; diredなどファイルリスト表示関係
;; ファイルリストで ls を呼ぶオプションを指定
(unless (eq system-type 'darwin)
  (setq dired-listing-switches "-alh --time-style=long-iso"))
;; diredを2つのウィンドウで開いている時に、デフォルトの移動orコピー先をもう一方のdiredで開いているディレクトリにする
(setq dired-dwim-target t)
;; ディレクトリを再帰的にコピーする
(setq dired-recursive-copies 'always)
;; diredバッファでC-sした時にファイル名だけにマッチするように
(setq dired-isearch-filenames t)
;; find-dired の ls コマンドの変更
(setq find-ls-option '("-exec ls -ld --time-style=long-iso {} \\;" . "-ld"))
;; ファイルリストでリネームができるようにする
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)


; 自動バックアップ設定
(setq auto-save-default nil)
(setq auto-save-file-name-transforms
  `((".*" ,(expand-file-name "~/backup/emacs/") t)))
(setq make-backup-files t)
(setq backup-directory-alist
  (cons (cons "\\.*$" (expand-file-name "~/backup/emacs"))
    backup-directory-alist))
(setq vc-make-backup-files t)





;; scratch バッファに表示されるメッセージを空白にする
(setq initial-scratch-message "")

;; startup バッファを表示しない
(setq inhibit-startup-message t)

;; C-x b のバッファリストが表示できるように
(iswitchb-mode 1)

;; 外部で編集されたら自動再読み込みする
(global-auto-revert-mode 1)

;; [yes or no] の表示を [y or n] に短縮する
(fset 'yes-or-no-p 'y-or-n-p)

;; 実行できるスクリプトは保存時に実行権限をつける
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; grep-findのコマンドを設定
(setq grep-find-command "find . -type f ! -path '*.svn*' ! -path '*.log*' ! -path '*.git*' -exec grep -nHi -e  {} /dev/null \\;")

;; バッファの最後に空行を入れないようにする
(setq next-line-add-newlines nil)

;; Shell
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; 終了確認
(setq confirm-kill-emacs 'y-or-n-p)

;; OSXでのlisting directory failed but access-file' worked 回避
(when (eq system-type 'darwin)
  (require 'ls-lisp)
  (setq ls-lisp-use-insert-directory-program nil))

