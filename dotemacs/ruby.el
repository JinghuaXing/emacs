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

(require 'ido)
(ido-mode t)
(add-to-list 'load-path "~/.elisp/rinari/")
(require 'rinari)

(add-to-list 'load-path "~/.elisp/rhtml/")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
     	  (lambda () (rinari-launch)))
(define-key rhtml-mode-map
  "\C-c\C-e" '(lambda ()
		(interactive)
		(insert "<%  %>")
		(backward-char 3)
		(indent-for-tab-command)
		))
(define-key rhtml-mode-map
  "\C-c\C-d" '(lambda ()
		(interactive)
		(insert "<%=  %>")
		(backward-char 3)
		(indent-for-tab-command)
		))

(setq rinari-tags-file-name "TAGS")
