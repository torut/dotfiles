;; htmlモードの設定
(defun html-mode-setup ()
  ;; 空白2文字
  (setq sgml-basic-offset 2)
  ;; インデントにタブを使わない
  (setq indent-tabs-mode nil)
)

(add-hook 'html-mode-hook 'html-mode-setup)
(add-to-list 'auto-mode-alist '("\\.phtml(.*)?$" . html-mode))

