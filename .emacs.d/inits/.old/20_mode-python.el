;; Pythonモードの設定
(autoload 'python-mode "python-mode" "Mode for editing Python source files")
(add-to-list 'auto-mode-alist '("\\.py" . python-mode))
