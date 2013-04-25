;; (add-hook 'ibuffer-mode-hook
;;           (lambda ()
;;             (setq ibuffer-filter-groups
;;                   '(
;; 		    ("Java" (mode . java-mode))
;; 		    ("C" (or (mode . c++-mode) (mode . c-mode)))
;;                     ("Dired" (mode . dired-mode))
;; 		    ))))

(require 'bs)
(require 'ibuffer)

(add-hook 'ibuffer-mode-hook
	  (lambda()
	    (local-set-key (kbd "~") 'ibuffer-mark-special-buffers)
	    )
	  )
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

;; (defun switch-to-previous-buffer ()
;;   (interactive)
;;   (switch-to-buffer (other-buffer (current-buffer) 1)))
;; (global-set-key (kbd "<f1>") 'switch-to-previous-buffer)


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

;; (require 'ibuffer-vc)
;; (add-hook 'ibuffer-hook
;; 	  (lambda ()
;; 	    (ibuffer-vc-set-filter-groups-by-vc-root)
;; 	    (unless (eq ibuffer-sorting-mode 'alphabetic)
;; 	      (ibuffer-do-sort-by-recency))))
;; (setq ibuffer-formats
;;       '((mark modified read-only vc-status-mini " "
;; 	      (name 18 18 :left :elide)
;; 	      " "
;; 	      (size 9 -1 :right)
;; 	      " "
;; 	      (mode 16 16 :left :elide)
;; 	      " "
;; 	      (vc-status 16 16 :left)
;; 	      " "
;; 	      filename-and-process)))
