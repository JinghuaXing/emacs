(add-to-list 'load-path "~/.elisp/auto-complete-1.3.1/")
(require 'auto-complete-config)
(ac-config-default)
(ac-flyspell-workaround)

(define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
(define-key ac-complete-mode-map (kbd "C-p") 'ac-previous)
(setq ac-fuzzy-enable t)

(require 'auto-complete)
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))

(global-auto-complete-mode t)