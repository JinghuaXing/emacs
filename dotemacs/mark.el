(add-to-list 'load-path "~/.elisp/back-button/")
(require 'back-button)
(back-button-mode 1)
(global-set-key (kbd "M-n") 'back-button-local-forward)
(global-set-key (kbd "M-p") 'back-button-local-backward)
(global-set-key (kbd "M-N") 'back-button-global-forward)
(global-set-key (kbd "M-P") 'back-button-global-backward)

;; (load-file "~/.elisp/dotemacs/pulse.el")
(require 'auto-mark)
(global-auto-mark-mode 1)
(setq auto-mark-command-class-alist (quote (
					    (goto-line . jump)
					    (isearch-forward-regexp . jump)
					    (isearch-backward-regexp . jump)
					    (ace-jump-mode . jump)
					    (idomenu . jump)
					    (beginning-of-buffer . jump)
					    (c-beginning-of-defun . jump)
					    (c-end-of-defun . jump)
					    (end-of-buffer . jump)
					    (ahs-moccur-hl . jump)
					    )))
