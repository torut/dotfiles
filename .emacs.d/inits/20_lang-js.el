;; java script
(use-package js
  :ensure nil
  :mode ("\.js\'" . js-mode)
  ;; 					))))
  :config
  (setq js-indent-level 2 ;; インデント幅を2に設定
		indent-tabs-mode nil ;; インデントにタブを使わない
		))
