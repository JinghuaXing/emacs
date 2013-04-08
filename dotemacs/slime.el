(add-to-list 'load-path "~/.elisp/slime")
(setq inferior-lisp-program "sbcl")
(require 'slime)
(slime-setup '(slime-fancy slime-asdf slime-banner))
(setq slime-complete-symbol*-fancy t)
(setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)

(add-to-list 'auto-mode-alist '("\\.lisp\\'" . lisp-mode))
(defun lisp-indent-or-complete (&optional arg)
  (interactive "p")
  (if (or (looking-back "^\\s-*") (bolp))
      (call-interactively 'lisp-indent-line)
      (call-interactively 'slime-indent-and-complete-symbol)))
(eval-after-load "lisp-mode"
  '(progn
     (define-key lisp-mode-map (kbd "TAB") 'lisp-indent-or-complete)))

(add-hook 'lisp-mode-hook '(lambda () (flyspell-mode -1)))
(require 'hippie-expand-slime)
(add-hook 'slime-mode-hook 'set-up-slime-hippie-expand)
(add-hook 'slime-repl-mode-hook 'set-up-slime-hippie-expand)