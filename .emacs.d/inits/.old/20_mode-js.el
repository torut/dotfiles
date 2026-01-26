;; javascriptモードの設定
;; (autoload 'javascript-mode "javascript" nil t)
;; (add-to-list 'auto-mode-alist (cons "\\.\\(js\\|as\\|json\\|jsn\\)\\'" 'javascript-mode))

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist (cons "\\.\\(js\\|json\\)\\'" 'js2-mode))
(defun js2-mode-setup ()
  (setq js2-basic-offset 2
    indent-tabs-mode nil ; t => tab, nil => space
  )
)
(add-hook 'js2-mode-hook 'js2-mode-setup)

;; coffeeモードの設定
;; (autoload 'coffee-mode "coffee-mode" "Major mode for editing CoffeeScript." t)
;; (add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
;; (add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
;; (defun coffee-custom ()
;;   "coffee-mode-hook"
;;   (and (set (make-local-variable 'tab-width) 2)
;;        (set (make-local-variable 'coffee-tab-width) 2))
;;   )
;; (add-hook 'coffee-mode-hook '(lambda() (coffee-custom)))

