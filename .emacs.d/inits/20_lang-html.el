;; HTMLモード
(use-package html
  :ensure nil ; Emacs本体付属の機能
  :mode (("\.phtml\'" . html-mode)) ; .phtml ファイルもhtml-modeで開く
  :hook
  (html-mode .
             (lambda ()
               ;; 空白2文字インデント
               (setq-local sgml-basic-offset 2)
               ;; インデントにタブを使わない
               (setq-local indent-tabs-mode nil))))
