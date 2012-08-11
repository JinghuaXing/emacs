(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files") 
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode)) 
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode)) 
(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")  
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")  
(require 'ruby-electric)
(add-hook 'ruby-mode-hook  
    '(lambda ()  
        (inf-ruby-keys)
	(ruby-electric-mode t)
	))  
(add-hook 'ruby-mode-hook 'turn-on-font-lock)  

(require 'rdoc-mode)
(require 'rails)
(add-to-list 'load-path "~/.elisp/rhtml/")
(require 'rhtml-mode)

