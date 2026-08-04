(use-package php-mode
  :ensure t ; php-mode は外部パッケージなのでインストールを指示
  :mode (("\.php$" . php-mode))
  :hook
  ((php-mode .
             (lambda ()
               ;; インデント設定
               (setq tab-width 4
                     c-basic-offset 4
                     indent-tabs-mode nil) ; タブでのインデントを有効/無効
               ))
   ;; php-mode-hook は php-mode-user-hook の後に評価されるため、
   ;; スタイル設定をここで上書きできます。
   (php-mode .
             (lambda ()
               ;; c-set-offset によるスタイル設定
               (c-set-offset 'case-label' 4)
               (c-set-offset 'arglist-intro' 4)
               (c-set-offset 'arglist-cont-nonempty' 4)
               (c-set-offset 'arglist-close' 0))))
  )
