(load (expand-file-name (concat (getenv "HOME") "/.emacs.d/init")))

;; HOMEディレクトリに .my_emacs.el があれば追加で読み込む。
(if (file-exists-p (expand-file-name (concat (getenv "HOME") "/.my_emacs.el")))
  (load (expand-file-name (concat (getenv "HOME") "/.my_emacs.el"))))
