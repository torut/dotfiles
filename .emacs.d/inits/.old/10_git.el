;; magit
(require 'magit)

;; magit の diff モードの設定
(defun magit-setup-diff ()
  ;; 'allではなくtにすると現在選択中のhunkのみ強調表示する
  (setq magit-diff-refine-hunk t)
  ;; diff用のfaceを設定する
  (diff-mode-setup-faces)
  ;; diffの表示設定が上書きされてしまうのでハイライトを無効にする
  (set-face-attribute 'magit-item-highlight nil :inherit nil)
  )
(add-hook 'magit-mode-hook 'magit-setup-diff)
