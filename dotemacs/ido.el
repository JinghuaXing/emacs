(require 'ido)
(ido-mode t)
(ido-everywhere t)
(setq ido-max-directory-size 100000)
(setq ido-enable-regexp t)
(setq ido-enable-flex-matching t)
(setq ido-ignore-buffers (quote ("\\` \\|\\(^\\*\\)\\|\\(TAGS.*\\)")))
(add-hook 'ido-setup-hook '(lambda ()
			     (interactive)
			     (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
			     (define-key ido-completion-map (kbd "C-p") 'ido-prev-match)
			     (define-key ido-completion-map (kbd "SPC") 'ido-restrict-to-matches)
			     ))