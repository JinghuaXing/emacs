;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;dired
(require 'dired-x)
(require 'wdired)
(require 'dired-details+)
(require 'dired-tar)
(defvar sunway/dired-buffer nil)
;;(require 'dired-single)
(setq dired-details-initially-hide t)
(setq dired-details-hidden-string nil)
(setq dired-listing-switches "-lak")
(setq dired-dwim-target t)

(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
(add-hook 'dired-mode-hook
	  (lambda ()
	    (dired-omit-mode 1)
	    (hl-line-mode t)
	    (local-unset-key (kbd "C-o"))
	    (add-to-list 'sunway/dired-buffer (current-buffer))
	    ))
(autoload 'wdired-change-to-wdired-mode "wdired")

;;(define-key dired-mode-map (kbd "RET") 'joc-dired-single-buffer)
;; (define-key dired-mode-map (kbd "<C-return>") 'dired-advertised-find-file)
;;(define-key dired-mode-map (kbd "C-x C-j") '(lambda () (interactive) (joc-dired-single-buffer "..")))
;;(define-key dired-mode-map (kbd "^") '(lambda () (interactive) (joc-dired-single-buffer "..")))

(setq dired-recursive-copies 'always
      dired-recursive-deletes 'top)
(defun my-start-process-shell-command (cmd)
  "Don't create a separate output buffer."
  (start-process-shell-command cmd nil cmd))

;; redefine this function to disable output buffer.
(defun dired-run-shell-command (command)
  (let ((handler
	 (find-file-name-handler (directory-file-name default-directory)
				 'shell-command)))
    (if handler (apply handler 'shell-command (list command))
      (my-start-process-shell-command command)))
  ;; Return nil for sake of nconc in dired-bunch-files.
  nil)

(setq dired-guess-shell-alist-user
      `(
	("\\(\\.gif$\\)\\|\\(\\.png$\\)\\|\\(\\.bmp$\\)\\|\\(\\.jpg$\\)\\|\\(\\.tif$\\)" "gthumb")
	("\\(\\.avi$\\)\\|\\(\\.mkv$\\)\\|\\(\\.mpg$\\)\\|\\(\\.mpe?g$\\)\\|\\(\\.flv$\\)\\|\\(\\.wmv$\\)\\|\\(\\.mov$\\)\\|\\(\\.divx$\\)" " mplayer")
	("\\(\\.wav$\\)\\|\\(\\.rm$\\)\\|\\(\\.rmvb$\\)\\|\\(\\.ra$\\)" " mplayer")
	("\\.hd$" " mplayer -vo x11")
	("\\.tar\\.bz2$" "tar jxvf")
	("\\chm$" "chmsee")
	("\\.torrent$" "ed2kopera")
	("\\(\\.xls$\\)\\|\\(\\.doc$\\)\\|\\(\\.ppt$\\)" "soffice")
	("\\.tar\\.gz$"  "tar zxvf")
	("\\.tar$"   "tar xvf")
	("\\(\\.rar$\\)\\|\\(\\.r[0-9]+$\\)" "unrar x")
	("\\.htm[l]?$\\|.mht$" " google-chrome")
	("\\.pdf$" " acroread")
	("\\.dvi$" " xdvi")
	)
      )

(setq dired-omit-extensions '("CVS" "RCS" ".o" "~" ".bin" ".lbin" ".fasl" ".ufsl" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".fmt" ".tfm" ".class" ".fas" ".lib" ".x86f" ".sparcf" ".lo" ".la" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".idx" ".lof" ".lot" ".glo" ".blg" ".bbl" ".cp" ".cps" ".fn" ".fns" ".ky" ".kys" ".pg" ".pgs" ".tp" ".tps" ".vr" ".vrs"))

(add-hook 'dired-mode-hook (lambda ()
			     (interactive)
			     (make-local-variable  'dired-sort-map)
			     (setq dired-sort-map (make-sparse-keymap))
			     (define-key dired-mode-map "s" dired-sort-map)
			     (define-key dired-sort-map "s"
			       '(lambda () "sort by Size"
				  (interactive) (dired-sort-other (concat dired-listing-switches "S"))))
			     (define-key dired-sort-map "x"
			       '(lambda () "sort by eXtension"
				  (interactive) (dired-sort-other (concat dired-listing-switches "X"))))
			     (define-key dired-sort-map "t"
			       '(lambda () "sort by Time"
				  (interactive) (dired-sort-other (concat dired-listing-switches "t"))))
			     (define-key dired-sort-map "n"
			       '(lambda () "sort by Name"
				  (interactive) (dired-sort-other (concat dired-listing-switches ""))))))

;; (add-hook 'dired-mode-hook 'hl-line-mode)
;; (setq dired-free-space-program "df")
;; (setq directory-free-space-args "-m")
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
(define-key dired-mode-map "T" 'dired-tar-pack-unpack)
(define-key dired-mode-map (kbd "c") (lambda ()
				       (interactive)
				       (unless (equal (length dired-subdir-alist) 1)
					 (dired-kill-subdir)
					 (pop-mark)
					 (goto-char (mark t))
					 )
				       ))
(define-key dired-mode-map (kbd "C-c C-c") 'droid)

;; (define-key dired-mode-map (kbd "c") (lambda ()
;; 					     (interactive)
;; 					     (setq sunway/dired-buffer (delete (current-buffer) sunway/dired-buffer))
;; 					     (kill-buffer (current-buffer))
;; 					     ))

(define-key dired-mode-map (kbd "f") (lambda (wildcard)
				       (interactive "MWildcard: ")
				       (find-dired "./" (concat "-iname " "\"*" wildcard "*\"" ))
				       ))

;; (define-key dired-mode-map (kbd "F") (lambda (reg)
;; 				       (interactive "MReg: ")
;; 				       (kill-new reg)
;; 				       (find-grep-dired "./" reg)
;; 				       )
;;   )
(define-key dired-mode-map (kbd "F") (lambda ()
				       (interactive)
				       (call-interactively 'ack)
				       )
  )


;;(define-key dired-mode-map (kbd "h") 'dired-hide-subdir)
;;(define-key dired-mode-map (kbd "H") 'dired-hide-all)
;;(define-key dired-mode-map (kbd "j") 'dired-goto-file)
;; (define-key dired-mode-map (kbd "<tab>") (lambda ()
;; 					   (interactive)
;; 					   (unless (dired-next-subdir 1 t t)
;; 					     (goto-char (point-min))
;; 					     (forward-line 2)
;; 					     )
;; 					   )
;;   )
;; (define-key dired-mode-map (kbd "<tab>") (lambda ()
;; 					   (interactive)
;; 					   (setq sunway/dired-buffer (append (cdr sunway/dired-buffer) (list (car sunway/dired-buffer))))
;; 					   (switch-to-buffer (car sunway/dired-buffer))
;; 					   )
;;   )
(define-key dired-mode-map (kbd "M-<")
  (lambda ()
    (interactive)
    (beginning-of-buffer)
    (forward-line 2)
    )
  )
(define-key dired-mode-map (kbd "M->")
  (lambda ()
    (interactive)
    (end-of-buffer)
    (previous-line 1)
    )
  )
;;(global-unset-key (kbd "C-x C-j"))
;;(define-key dired-mode-map (kbd "RET") nil)
;;(define-key dired-mode-map (kbd "i") nil)

(defun sunway/dired-sort ()
  "Dired sort hook to list directories first."
  (interactive)
  (save-excursion
    (let (
	  (buffer-read-only)
	  (point-from)
	  (point-to)
	  (succ 't)
	  )
      (goto-char (point-min))
      (while succ
	(forward-line 2)
	(setq point-from (point))
	(setq succ (dired-next-subdir 1 t t))
	(if succ
	    (previous-line)
	  (goto-char (point-max))
	  )
	(setq point-to (point))
	(sort-regexp-fields t "^.*$" "[ ]*." point-from point-to)
	(forward-line)
	)
      ))
  (set-buffer-modified-p nil)
  )
(add-hook 'dired-after-readin-hook 'sunway/dired-sort)

(defvar sunway/oldreg-to-keep "")
(defvar sunway/oldreg-to-omit "")
(defvar sunway/mode-indicator "")
(defcustom sunway/reg-seprator "/"
  "seprator for sunway/reg"
  )
(make-variable-buffer-local 'sunway/oldreg-to-omit)
(make-variable-buffer-local 'sunway/oldreg-to-keep)
(make-variable-buffer-local 'sunway/mode-indicator)
(add-hook 'dired-after-readin-hook (lambda()
				     (setq sunway/mode-indicator "")
				     (unless (equal sunway/oldreg-to-keep "")
				       (progn
					 (sunway/dired-keep-or-omit-regexp nil sunway/oldreg-to-keep)
					 (setq sunway/mode-indicator " KEEP")
					 )
				       )
				     (unless (equal sunway/oldreg-to-omit "")
				       (progn
					 (sunway/dired-keep-or-omit-regexp 1 sunway/oldreg-to-omit)
					 (setq sunway/mode-indicator " KEEP")
					 )
				       )
				     (force-mode-line-update)
				     )
	  )
(setq minor-mode-alist (add-to-list  'minor-mode-alist '(dired-omit-mode  sunway/mode-indicator)))
(defun sunway/dired-keep-or-omit-regexp (p reg)
  (interactive
   (list current-prefix-arg (if current-prefix-arg
				(read-string "File to omit:" (concat sunway/oldreg-to-omit sunway/reg-seprator) nil "")
			      (read-string "File to keep:" (concat sunway/oldreg-to-keep sunway/reg-seprator) nil ""))
	 ))
  (if p
      (setq sunway/oldreg-to-omit reg)
    (setq sunway/oldreg-to-keep reg)
    )
  (let ((sp (split-string reg sunway/reg-seprator))
	)
    (if p
	(mapc (lambda (str)
		(cond ((equal str "dir")
		       (dired-mark-directories nil)
		       (dired-do-kill-lines)
		       )
		      ((equal str "file")
		       (dired-mark-directories nil)
		       (dired-toggle-marks)
		       (dired-do-kill-lines)
		       )
		      ((not (equal str ""))
		       (dired-mark-files-regexp str)
		       (dired-do-kill-lines)
		       )
		      )
		)
	      sp)
      (mapc (lambda (str)
	      (cond ((equal str "dir")
		     (dired-mark-directories nil)
		     (dired-toggle-marks)
		     (dired-do-kill-lines)
		     )
		    ((equal str "file")
		     (dired-mark-directories nil)
		     (dired-do-kill-lines)
		     )
		    (t
		     (dired-mark-files-regexp str)
		     (dired-toggle-marks)
		     (dired-do-kill-lines)
		     )
		    )
	      )
	    sp)
      )
    )
  )

(define-key dired-mode-map "/" (lambda() (interactive) (call-interactively 'sunway/dired-keep-or-omit-regexp) (revert-buffer)))

;; (defun dired-hide-subdir (arg)
;;   "Hide or unhide the current subdirectory and move to next directory.
;; Optional prefix arg is a repeat factor.
;; Use \\[dired-hide-all] to (un)hide all directories."
;;   (interactive "p")
;;   (dired-hide-check)
;;   (let ((modflag (buffer-modified-p)))
;;     (while (>=  (setq arg (1- arg)) 0)
;;       (let* ((cur-dir (dired-current-directory))
;; 	     (hidden-p (dired-subdir-hidden-p cur-dir))
;; 	     (elt (assoc cur-dir dired-subdir-alist))
;; 	     (end-pos (1- (dired-get-subdir-max elt)))
;; 	     buffer-read-only)
;; 	;; keep header line visible, hide rest
;; 	(goto-char (dired-get-subdir-min elt))
;; 	(skip-chars-forward "^\n\r")
;; 	(if hidden-p
;; 	    (subst-char-in-region (point) end-pos ?\r ?\n)
;; 	  (subst-char-in-region (point) end-pos ?\n ?\r)))
;;       ;;(dired-next-subdir 1 t))
;;     (restore-buffer-modified-p modflag))))

(setq dired-garbage-files-regexp "\\.\\(?:aux\\|out\\|bak\\|dvi\\|log\\|orig\\|rej\\|toc\\|class\\)\\'")

(defun dired-get-size ()
  (interactive)
  (let ((files (dired-get-marked-files)))
    (with-temp-buffer
      (apply 'call-process "/usr/bin/du" nil t nil "-sch" files)
      (message "Size of all marked files: %s"
               (progn 
                 (re-search-backward "\\(^[0-9.,]+[A-Za-z]+\\).*total$")
		 (match-string 1))))))

(define-key dired-mode-map (kbd "?") 'dired-get-size)

