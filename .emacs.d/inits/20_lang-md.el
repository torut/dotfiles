;; markdown
(use-package markdown-mode
  :ensure t ; markdown-mode は外部パッケージなのでインストールを指示
  :mode ("\\.md\\'" . markdown-mode)
  :hook
  (markdown-mode .
                 (lambda ()
                   ;; インデントにタブを使わない
                   (setq-local indent-tabs-mode nil))))
