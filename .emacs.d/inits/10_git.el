;; magit
(use-package magit
  :ensure t
  :hook (magit-mode .
                  (lambda ()
                    ;; 'all'ではなく t にすると現在選択中のhunkのみを強調表示する
                    (setq magit-diff-refine-hunk t)
					(setq magit-status-show-untracked-files 'all)

                    ;; diff用のfaceを設定する
                    ;; NOTE: この `diff-mode-setup-faces` 関数は、
                    ;;       `20_mode-diff.el` などで定義されている必要があります。
                    (when (fboundp 'diff-mode-setup-faces)
                      (diff-mode-setup-faces))

                    ;; diffの表示設定が上書きされてしまうのでハイライトを無効にする
                    (set-face-attribute 'magit-section-highlight nil :inherit nil))

				  )

  )
