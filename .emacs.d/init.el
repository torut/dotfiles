;; ロードパスを追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	            (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	        (normal-top-level-add-subdirs-to-load-path))))))
;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "inits")

;; init-loader
(require 'init-loader)

;; ログファイルを表示(nil にすると非表示)
(custom-set-variables
 '(init-loader-show-log-after-init nil))

;; 設定ディレクトリ
(init-loader-load "~/.emacs.d/inits")
