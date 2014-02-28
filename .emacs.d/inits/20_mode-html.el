;; htmlモードの設定
(add-hook 'html-mode-hook
          (lambda()
            (setq sgml-basic-offset 2) ;; 空白2文字
            (setq indent-tabs-mode nil) ;; インデントにタブを使わない
            )
          )
