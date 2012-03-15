(add-hook 'ibuffer-mode-hook
          (lambda ()
            (setq ibuffer-filter-groups
                  '(
		    ("java" (mode . java-mode))
		    ("c/cpp" (or (mode . c++-mode) (mode . c-mode)))
                    ("dired" (mode . dired-mode))
                    ("tex" (mode . latex-mode))
		    ))))

(require 'bs)
(require 'ibuffer)
(global-set-key (kbd "C-x b") 'ido-switch-buffer)
(setq ido-ignore-buffers (quote ("\\` \\|\\(^\\*\\)\\|\\(TAGS.*\\)\\|*ESH.*")))
(global-set-key (kbd "C-x C-b") 'ibuffer)

(add-to-list 'bs-configurations
	     '("java" nil nil "^\\*.*"
	       (lambda (buf)
		 (with-current-buffer buf
		   (not (eq major-mode 'jde-mode)))) nil))
(add-to-list 'bs-configurations
	     '("c" nil nil "^\\*.*"
	       (lambda (buf)
		 (with-current-buffer buf
		   (and 
		    (not (eq major-mode 'c-mode)
			 )
		    (not (eq major-mode 'c++-mode)
			 )
		    )
		   )
		 ) nil)
	     )
