(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-g") 'goto-line)

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-l") 'recenter)
(global-set-key (kbd "C-M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-k") 'ido-kill-buffer)
(global-set-key (kbd "C-x k") '(lambda()
				   (interactive)
				   (kill-buffer (current-buffer))
				   ))
(global-set-key (kbd "<f11>") 'douban-music)
(global-set-key (kbd "M-m") 'ace-jump-mode)
(global-set-key (kbd "M-I") 'aj-toggle-fold)
(global-set-key (kbd "M-J") 'imenu)


(add-hook 'sql-interactive-mode-hook
	  '(lambda ()
	     (define-key sql-interactive-mode-map (kbd "<up>") 'comint-previous-input)
	     (define-key sql-interactive-mode-map (kbd "<down>") 'comint-next-input)
	     ))

(global-set-key (kbd "M-s k") 'keep-lines)
(global-set-key (kbd "M-s f") 'flush-lines)

(global-set-key (kbd "C-x v t") 'magit-status)
(global-set-key (kbd "C-x v b") 'magit-blame-mode)

(global-set-key (kbd "<s-return>") 'magit-status)
(defalias 'mt 'magit-status)
(defalias 'occur 'moccur)

(defun my-find-dired ()
  (interactive)
  (let ((dir (read-directory-name "Find files in directory: " nil nil t)))
    (setq wildcard (read-string (concat "Find files in `" (file-name-nondirectory (directory-file-name dir))  "': ") ))
    (find-dired dir (concat "-iname " "\"*" wildcard "*\"" ))
    ))

(global-set-key (kbd "M-,") (lambda ()
			      (interactive)
			      (if current-prefix-arg
				  (call-interactively 'my-find-dired)
				(call-interactively 'ack)
				)
			      ))

(eval-after-load 'diff-hl
  '(progn
     (define-key diff-hl-mode-map (kbd "C-x v n") 'diff-hl-next-hunk)
     (define-key diff-hl-mode-map (kbd "C-x v p") 'diff-hl-previous-hunk)
     (define-key diff-hl-mode-map (kbd "C-x v u") 'diff-hl-revert-hunk)
     (define-key diff-hl-mode-map (kbd "C-x v =") 'diff-hl-diff-goto-hunk)
     )
)

(eval-after-load 'browse-kill-ring
  '(global-set-key (kbd "M-y") 'browse-kill-ring)
  )

(global-unset-key (kbd "<C-wheel-up>"))
(global-unset-key (kbd "<C-wheel-down>"))

(eval-after-load 'etags-select
  '(global-set-key "\M-." 'etags-select-find-tag)
  )

(eval-after-load 'deft
  '(progn
    (global-set-key (kbd "<f12>") 'deft)
    (define-key deft-mode-map (kbd "<f12>") 'quit-window)
    )
  )

(eval-after-load 'org
  '(progn
    (global-set-key (kbd "C-c k") 'org-capture)
    (global-set-key (kbd "C-c a") 'agenda)
    (global-set-key (kbd "C-c l") 'org-store-link)
    )
  )

(eval-after-load 'sdcv
  '(global-set-key (kbd "M-?") 'sdcv-search-input+)
  )

(global-set-key (kbd "C-x b") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(eval-after-load 'ibuffer
  '(define-key ibuffer-mode-map (kbd "~") 'ibuffer-mark-special-buffers)
  )

(eval-after-load 'eim
  '(global-set-key ";" 'eim-insert-ascii)
  )

(eval-after-load 'back-button
  '(progn
     (global-set-key (kbd "M-n") 'back-button-local-forward)
     (global-set-key (kbd "M-p") 'back-button-local-backward)
     (global-set-key (kbd "M-N") 'back-button-global-forward)
     (global-set-key (kbd "M-P") 'back-button-global-backward)
     )
  )

(global-set-key (kbd "C-x C-r") 'file-cache-ido-find-file)

;;(global-set-key (kbd "C-x r b") 'sw/bookmark-jump)
;;(global-set-key (kbd "C-x r m") 'sw/bookmark-set)
(global-set-key (kbd "<M-up>") 'sw/move-line-up)
(global-set-key (kbd "<M-down>") 'sw/move-line-down)
(global-set-key (kbd "M-T") 'sw/transporse-region)
(global-set-key (kbd "M-^") 'sw/join-line)

;; (global-set-key (kbd "<C-mouse-4>") 'sw/increase-font-size)
;; (global-set-key (kbd "<C-mouse-5>") 'sw/decrease-font-size)

(define-key isearch-mode-map "\M-w" 'sw/isearch-save-and-exit)
(define-key isearch-mode-map "\C-y" 'isearch-yank-kill)

(global-set-key [(M /)] 'sw/beagrep)


(eval-after-load 'nxml-mode
  '(progn
     (define-key nxml-mode-map "\M-\C-a" '(lambda ()
					    (interactive)
					    (beginning-of-line)
					    (call-interactively 'nxml-backward-up-element)))
     (define-key nxml-mode-map "\M-\C-e" '(lambda ()
					    (interactive)
					    (end-of-line)
					    (call-interactively 'nxml-backward-up-element)
					    (call-interactively 'nxml-forward-element)))))

(global-set-key (kbd "C-x C-x") 'sw/switch-to-query)
