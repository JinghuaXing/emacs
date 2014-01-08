(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-g") 'goto-line)

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-l") 'recenter)
(global-set-key (kbd "C-M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-k") 'ido-kill-buffer)
(global-set-key (kbd "<f11>") 'douban-music)
(global-set-key (kbd "M-m") 'ace-jump-mode)
(global-set-key (kbd "M-I") 'aj-toggle-fold)
(global-set-key (kbd "M-J") 'idomenu)


(add-hook 'sql-interactive-mode-hook
	  '(lambda ()
	     (define-key sql-interactive-mode-map (kbd "<up>") 'comint-previous-input)
	     (define-key sql-interactive-mode-map (kbd "<down>") 'comint-next-input)
	     ))

(global-set-key (kbd "M-s k") 'keep-lines)
(global-set-key (kbd "M-s f") 'flush-lines)

(global-set-key (kbd "C-x v t") 'magit-status)
(global-set-key (kbd "<s-return>") 'magit-status)
(defalias 'mt 'magit-status)
(defalias 'occur 'moccur)

(defun my-find-dired ()
  (interactive)
  (let ((dir (read-directory-name "Find files in directory: " nil nil t))
	)
    (setq wildcard (read-string (concat "Find files in `" (file-name-nondirectory (directory-file-name dir))  "': ") ))
    (find-dired dir (concat "-iname " "\"*" wildcard "*\"" ))
    )
  )

(global-set-key (kbd "M-,") (lambda ()
			      (interactive)
			      (if current-prefix-arg
				  (call-interactively 'my-find-dired)
				(call-interactively 'ack)
				)
			      ))
