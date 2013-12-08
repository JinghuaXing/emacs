(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files") 
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode)) 
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

(require 'inf-ruby)
(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)

(add-hook 'ruby-mode-hook  
    '(lambda ()  
	(auto-highlight-symbol-mode t)
	))
(add-hook 'ruby-mode-hook 'turn-on-font-lock)  

(require 'rdoc-mode)
(require 'yari)
(defun ri-bind-key ()
  (local-set-key (kbd "C-c C-d") 'yari))

(add-hook 'ruby-mode-hook 'ri-bind-key)

(require 'ruby-block)
(ruby-block-mode t)
;; (setq ruby-block-highlight-toggle 'overlay)
;; (setq ruby-block-highlight-toggle 'minibuffer)
(setq ruby-block-highlight-toggle t)

(require 'ruby-tools)
