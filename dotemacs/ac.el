(add-to-list 'load-path "~/.elisp/auto-complete/")
(add-to-list 'load-path "~/.elisp/auto-complete/lib/fuzzy")
(add-to-list 'load-path "~/.elisp/auto-complete/lib/popup/")

(require 'auto-complete)
(require 'auto-complete-config)
;; (ac-config-default)
(ac-flyspell-workaround)

(define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
(define-key ac-complete-mode-map (kbd "C-p") 'ac-previous)
(setq ac-fuzzy-enable t)

(setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
(add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)




