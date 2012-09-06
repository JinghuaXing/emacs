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
	(auto-highlight-symbol-mode t)
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

 ; When Rinari mode is loaded, add extra bindings to its key map enabling the
  ; use of M-R and M-r as its prefixes. The easier to type M-r is used for the
  ; frequently used `find' functions and M-R is used for the more infrequently
  ; used rake/script/web-server commands. M-r is normally bound to
  ; `move-to-window-line-top-bottom', which I can do without, and M-R is
  ; normally unbound. Examples of the changes below; it should be obvious how to
  ; pick your own prefixes if you don't like mine.
  ;
  ; Function                  Default Binding    New Binding
  ; ========                  ===============    ===========
  ; rinari-find-controller    C-c ; f c          M-r c
  ; rinari-web-server         C-c ; w            M-R w
(add-hook 'rinari-minor-mode-hook (lambda ()
	(define-prefix-command 'pd-rinari-map1)
	(define-prefix-command 'pd-rinari-map2)
	(local-set-key (kbd "M-R") 'pd-rinari-map1)
	(local-set-key (kbd "M-r") 'pd-rinari-map2)

	(define-key pd-rinari-map1 "'" 'rinari-find-by-context)
	(define-key pd-rinari-map1 ";" 'rinari-find-by-context)
	(define-key pd-rinari-map1 "c" 'rinari-console)
	(define-key pd-rinari-map1 "d" 'rinari-cap)
	(define-key pd-rinari-map1 "e" 'rinari-insert-erb-skeleton)
	(define-key pd-rinari-map1 "g" 'rinari-rgrep)
	(define-key pd-rinari-map1 "p" 'rinari-goto-partial)
	(define-key pd-rinari-map1 "q" 'rinari-sql)
	(define-key pd-rinari-map1 "r" 'rinari-rake)
	(define-key pd-rinari-map1 "s" 'rinari-script)
	(define-key pd-rinari-map1 "t" 'rinari-test)
	(define-key pd-rinari-map1 "w" 'rinari-web-server)
	(define-key pd-rinari-map1 "x" 'rinari-extract-partial)

	(define-key pd-rinari-map2 ";" 'rinari-find-by-context)
	(define-key pd-rinari-map2 "C" 'rinari-find-cells)
	(define-key pd-rinari-map2 "F" 'rinari-find-features)
	(define-key pd-rinari-map2 "M" 'rinari-find-mailer)
	(define-key pd-rinari-map2 "S" 'rinari-find-steps)
	(define-key pd-rinari-map2 "Y" 'rinari-find-sass)
	(define-key pd-rinari-map2 "a" 'rinari-find-application)
	(define-key pd-rinari-map2 "c" 'rinari-find-controller)
	(define-key pd-rinari-map2 "e" 'rinari-find-environment)
	(define-key pd-rinari-map2 "f" 'rinari-find-file-in-project)
	(define-key pd-rinari-map2 "h" 'rinari-find-helper)
	(define-key pd-rinari-map2 "i" 'rinari-find-migration)
	(define-key pd-rinari-map2 "j" 'rinari-find-javascript)
	(define-key pd-rinari-map2 "l" 'rinari-find-lib)
	(define-key pd-rinari-map2 "m" 'rinari-find-model)
	(define-key pd-rinari-map2 "n" 'rinari-find-configuration)
	(define-key pd-rinari-map2 "o" 'rinari-find-log)
	(define-key pd-rinari-map2 "p" 'rinari-find-public)
	(define-key pd-rinari-map2 "r" 'rinari-find-rspec)
	(define-key pd-rinari-map2 "s" 'rinari-find-script)
	(define-key pd-rinari-map2 "t" 'rinari-find-test)
	(define-key pd-rinari-map2 "u" 'rinari-find-plugin)
	(define-key pd-rinari-map2 "v" 'rinari-find-view)
	(define-key pd-rinari-map2 "w" 'rinari-find-worker)
	(define-key pd-rinari-map2 "x" 'rinari-find-fixture)
	(define-key pd-rinari-map2 "y" 'rinari-find-stylesheet)
	(define-key pd-rinari-map2 "z" 'rinari-find-rspec-fixture)
	))

(setq rsense-home (concat (getenv "HOME")  "/.elisp/rsense-0.3/"))
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)


(require 'yari)
(defun ri-bind-key ()
  (local-set-key [f1] 'yari))

(add-hook 'ruby-mode-hook 'ri-bind-key)