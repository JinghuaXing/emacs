(add-hook 'ibuffer-mode-hook
          (lambda ()
            (setq ibuffer-filter-groups
                  '(
		    ("Java" (mode . java-mode))
		    ("C" (or (mode . c++-mode) (mode . c-mode)))
                    ("Dired" (mode . dired-mode))
		    ))))

(require 'bs)
(require 'ibuffer)
(setq ido-ignore-buffers (quote ("\\` \\|\\(^\\*\\)\\|\\(TAGS.*\\)\\|*ESH.*")))
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

(defun ido-ibuffer-switch-to-saved-filters (name)
  "Set this buffer's filters to filters with NAME from `ibuffer-saved-filters'."
  (interactive
   (list
    (if (null ibuffer-saved-filters)
	(error "No saved filters")
      (ido-completing-read "Switch to saved filters: "
			   ibuffer-saved-filters nil t))))
  (setq ibuffer-filtering-qualifiers (list (cons 'saved name)))
  (ibuffer-update nil t))

(define-key ibuffer-mode-map (kbd "/ r") 'ido-ibuffer-switch-to-saved-filters)
