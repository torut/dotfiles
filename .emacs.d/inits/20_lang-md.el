;; markdown
(use-package markdown-mode
  :ensure t ; markdown-mode は外部パッケージなのでインストールを指示
  :mode ("\\.md\\'" . markdown-mode))
