(require 'tabbar)
(tabbar-mode 1)
(setq tabbar-cycling-scope (quote tabs))
(setq tabbar-buffer-list-function
      (lambda ()
	(remove-if
	 (lambda(buffer)
	   (and
	    (or
	     (string-match "\\(^ *\\*.*\\*.*$\\)\\|\\(^\\*?\\+.*\\)\\|\\(^TAGS.*\\)\\|\\(^Browsing by.*\\)" (buffer-name buffer)) ;remove all buffer like *....*
	     (member (buffer-name buffer)
		     '(".diary" "*Messages*") ;and remove .diary
		     )
	     )
	    (not (or (member (buffer-name buffer) '("*info*" "*w3m*")) ;but keep *info*
		     (string-match "\\(^\\*WoMan .*\\*$\\)" (buffer-name buffer)) ;and keep
		     )
		 )
	    )
	   ) (buffer-list))
	)
      )
(defun tabbar-buffer-groups (buffer)
  "Return the list of group names BUFFER belongs to.
Return only one group for each buffer."
  (with-current-buffer (get-buffer buffer)
    (cond
     ((member (buffer-name)
	      '("*scratch*" "*Messages*"))
      '("Common"))
     ((eq major-mode 'dired-mode)
      '("Dired"))
     ((or (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode)) (eq major-mode 'makefile-gmake-mode))
      '("C"))
     ((eq major-mode 'java-mode)
      '("java"))
     (t
      '("Others")))))


(custom-set-faces
 '(tabbar-default-face
   ((t (:background "black"
        :foreground "white"
        :height 1.1))))
 '(tabbar-selected-face
   ((t (:foreground "cyan"
	:background "black"
	;;:box (:line-width 1 :color "grey75")
	:height 1.5
	))))
 '(tabbar-button-face
   ((t (:foreground "cyan"
	))))
 '(tabbar-separator-face
   ((t (:foreground "black"
	:background "black"
	))))
 '(tabbar-unselected-face
   ((t (:foreground "grey60"
       :background "black"
       :height 1.1
       ;;:box (:line-width 1 :color "grey75")
       )))))

(global-set-key (kbd "<M-up>") 'tabbar-forward-group)
(global-set-key (kbd "<M-down>") 'tabbar-backward-group)
(global-set-key (kbd "<M-left>") 'tabbar-backward)
(global-set-key (kbd "<M-right>") 'tabbar-forward)

