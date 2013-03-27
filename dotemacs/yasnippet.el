(add-to-list 'load-path "~/.elisp/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

(define-key yas-minor-mode-map (kbd "SPC") 'yas-expand)
(add-hook 'c-mode-common-hook 
	  '(lambda () 
	     (setq yas/buffer-local-condition 
		   '(if (nth 8 (syntax-ppss (point))) 
			'(require-snippet-condition . force-in-comment) 
		      t)))) 