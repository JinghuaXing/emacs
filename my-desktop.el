;; Installation:
;; (require 'my-desktop)
;; (my-desktop-mode t)
;;
;; Usage:
;; M-x switch-session
;; M-x remove-session
;;
;; note:
;; you should turn `desktop-save-mode` off before tunring on my-desktop-mode
;;
;; Acknowledgement:
;; http://stackoverflow.com/questions/847962/what-alternate-session-managers-are-available-for-emacs
;; 

(require 'desktop)

(defvar my-desktop-session-dir
  (concat (getenv "HOME") "/.emacs.d/desktop-sessions/")
  "*Directory to save desktop sessions in")

(defvar my-desktop-last-session-file
  (concat (getenv "HOME") "/.emacs.d/desktop-last-session")
  "*Directory to save desktop sessions in")

(defvar my-desktop-session-name-hist nil
  "Desktop session name history")

(defun my-desktop-save (&optional name)
  "Save desktop by name."
  (interactive)
  (unless name
    (setq name (my-desktop-get-session-name "Save session" t)))
  (when name
    (make-directory (concat my-desktop-session-dir name) t)
    (desktop-save (concat my-desktop-session-dir name) t)
    (if wg-list
	(wg-update-all-workgroups-and-save)
	)
    ))

(defun my-desktop-save-and-clear ()
  "Save and clear desktop."
  (interactive)
  (call-interactively 'my-desktop-save)
  (desktop-clear)
  (setq desktop-dirname nil))

(defun my-desktop-read (&optional name)
  "Read desktop by name."
  (interactive)
  (unless name
    (setq name (my-desktop-get-session-name (concat "Load session (" (my-desktop-get-current-name) ")"))))
  (when (and name (not (string= name "")))
    (desktop-clear)
    (desktop-read (concat my-desktop-session-dir name))
    ;; indicator
    (setq my-desktop-mode-indicator (my-desktop-get-current-name))
    (force-mode-line-update)
    (wg-reset)
    (setq wg-file (concat my-desktop-session-dir name "/wg"))
    (if (file-exists-p wg-file)
	(wg-load wg-file)
	)
    ))

(defun session-remove ()
  (interactive)
  (setq name (my-desktop-get-session-name (concat "Remove session (" (my-desktop-get-current-name) ")")))
  (setq current (my-desktop-get-current-name))
  (if (and name (or (not current) (not (string= name current))))
      (unless (or (string= name "") (string= name "tmp"))
	(delete-directory (concat my-desktop-session-dir name) t)
	(message (concat name " removed"))
	)
    (message "Can't remove desktop")
    )
  )

(defun session-dup ()
  (interactive)
  (let ((name (my-desktop-get-current-name))
	(new_name (concat my-desktop-session-dir (my-desktop-get-current-name) "-" (format-time-string "%m-%d-%T")))
	)
    (copy-directory (concat my-desktop-session-dir name) new_name)
    (message new_name)
    )
  )

(defun switch-session (&optional name)
  "Change desktops by name."
  (interactive)
  (let ((name (my-desktop-get-current-name)))
    (when name
      (my-desktop-save name))
    (call-interactively 'my-desktop-read)))

(defun my-desktop-name ()
  "Return the current desktop name."
  (interactive)
  (let ((name (my-desktop-get-current-name)))
    (if name
        (message (concat "Desktop name: " name))
      (message "No named desktop loaded"))))

(defun my-desktop-get-current-name ()
  "Get the current desktop name."
  (when desktop-dirname
    (let ((dirname (substring desktop-dirname 0 -1)))
      ;; (when (string= (file-name-directory dirname) my-desktop-session-dir)
        (file-name-nondirectory dirname))))

(defun my-desktop-get-session-name (prompt &optional use-default)
  "Get a session name."
  (let* ((default (and use-default (my-desktop-get-current-name)))
         (full-prompt (concat prompt (if default
                                         (concat " (default " default "): ")
                                       ": "))))
    (ido-completing-read full-prompt (and (file-exists-p my-desktop-session-dir)
					  (remove (my-desktop-get-current-name) (cdr (cdr (directory-files my-desktop-session-dir)))))
			 nil nil nil my-desktop-session-name-hist default)))

(defun my-desktop-kill-emacs-hook ()
  "Save desktop before killing emacs."
  (let ((current (my-desktop-get-current-name)))
    (if current
	(my-desktop-save current)
      (progn
	(when (file-exists-p (concat my-desktop-session-dir "tmp"))
	  (setq desktop-file-modtime
		(nth 5 (file-attributes (desktop-full-file-name (concat my-desktop-session-dir "tmp"))))))
	(my-desktop-save "tmp")
	)
      )
    (let ((buf (find-file-noselect my-desktop-last-session-file)))
      (with-current-buffer buf
	(kill-region (point-min) (point-max))
	(if current
	    (insert current)
	  (insert "tmp")
	  )
	(write-file my-desktop-last-session-file)
	)
      )
    )
  )



(defun reload-last-session ()
  (let ((buf (find-file-noselect my-desktop-last-session-file)))
    (setq last-session (with-current-buffer buf
			 (buffer-substring (point-min) (point-max))
			 ))
    (if last-session
	(progn
	  (setq last-session (replace-regexp-in-string "\n" "" last-session))
	  (if (string-match last-session " +")
	      (setq last-session "tmp")	    
	    )
	  )
      (setq last-session "tmp")
      )
    (desktop-read (concat my-desktop-session-dir last-session))
    (setq wg-file (concat my-desktop-session-dir last-session "/wg"))
    (if (file-exists-p wg-file) 
	(wg-load wg-file)
      )
    (kill-buffer buf)
    (setq my-desktop-mode-indicator last-session)
    (force-mode-line-update)
    )
  )

(add-to-list 'desktop-globals-to-save 'kill-ring)
(add-to-list 'desktop-globals-to-save 'search-ring)
(add-to-list 'desktop-globals-to-save 'extended-command-history)
(add-to-list 'desktop-globals-to-save 'command-history)
(add-to-list 'desktop-globals-to-save 'minibuffer-history)
(add-to-list 'desktop-globals-to-save 'register-alist)
(add-to-list 'desktop-globals-to-save 'file-cache-alist) 
(add-to-list 'desktop-globals-to-save 'compile-command)

(add-to-list 'desktop-locals-to-save 'default-directory)

(defvar my-desktop-mode-indicator "")

(add-hook
 'after-init-hook
 (lambda ()
   (when my-desktop-mode
     (reload-last-session)      
     )))


(define-minor-mode my-desktop-mode
  ""
  :global t
  :group 'my-desktop-mode
  (if my-desktop-mode
;;; ON
      (progn 
	(add-hook 'kill-emacs-hook 'my-desktop-kill-emacs-hook)
;;	(global-set-key (kbd "s-l") 'switch-session)
	(setq default-mode-line-format (insert-after default-mode-line-format 6 '(:eval (concat "[" my-desktop-mode-indicator "] "))))
	;; (add-to-list 'default-mode-line-format '(:eval (concat "[" my-desktop-mode-indicator "]")))
	)
;;; OFF
    (remove-hook 'kill-emacs-hook 'my-desktop-kill-emacs-hook)
;;    (global-unset-key (kbd "s-l"))
    (setq default-mode-line-format (remove '(:eval (concat "[" my-desktop-mode-indicator "] ")) default-mode-line-format))
    ))

(defun insert-after (lst index newelt) (push newelt (cdr (nthcdr index lst))) lst)
(defalias 'ss 'switch-session)
(provide 'my-desktop)
