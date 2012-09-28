(require 'dired)
(require 'dbus)
(require 'gnus-util)

(defvar tracker-queries nil
  "Last queries given to Tracker by \\[tracker-dired].")

;; History of tracker-queries values entered in the minibuffer.
(defvar tracker-queries-history nil)

;;;###autoload
(defun tracker-dired (search-term)
  (interactive (list (read-string "Search terms: " (find-tag-default)
				  '(tracker-queries-history . 1))))
  (let ()
    (kill-new search-term)
    (switch-to-buffer (get-buffer-create "*Tracker*"))
    (widen)
    (kill-all-local-variables)
    (setq buffer-read-only nil)
    (erase-buffer)
    (setq tracker-queries search-term)

    (dired-mode search-term)
    (use-local-map (append (make-sparse-keymap) (current-local-map)))
    (define-key (current-local-map) "g" 'undefined)
    (define-key (current-local-map) "f" 'tracker-dired)

    ;; Set subdir-alist so that Tree Dired will work:
    
    (if (fboundp 'dired-simple-subdir-alist)
	;; will work even with nested dired format (dired-nstd.el,v 1.15
	;; and later)
	(dired-simple-subdir-alist)
      ;; else we have an ancient tree dired (or classic dired, where
      ;; this does no harm) 
      (set (make-local-variable 'dired-subdir-alist)
	   (list (cons default-directory (point-min-marker)))))
    
    (setq buffer-read-only nil)
    (insert "  tracker-query: " search-term "\n\n")
    ;; Subdir headlerline must come first because the first marker in
    ;; subdir-alist points there.
    ;; ``wildcard'' line. 
    ;; Start the process that pipes the results of the tracker search through ls -ld.
    (set (make-local-variable 'revert-buffer-function)
	 `(lambda (a b)
	    (tracker-dired ,search-term)))
    (let ((proc (start-process-shell-command "Tracker Search" (current-buffer)
					     (concat "tracker-search  '" search-term "' -f -l 2000|sed '1d;s|^  file://| |'|xargs ls -ld")
					     )))
      (set-process-filter proc (function tracker-dired-filter))
      (set-process-sentinel proc (function tracker-dired-sentinel))
      ;; Initialize the process marker; it is used by the filter.
      (move-marker (process-mark proc) 1 (current-buffer)))
    (setq mode-line-process '(":%s"))))

(defun tracker-dired-filter (proc string)
  ;; Filter for \\[tracker-dired] processes.
  (let ((buf (process-buffer proc)))
    (if (buffer-name buf)		; not killed?
	(save-excursion
	  (set-buffer buf)
	  (save-restriction
	    (widen)
	    (save-excursion
	      (let ((buffer-read-only nil)
		    (end (point-max)))
		(goto-char end)
		(insert string)
		(goto-char end)
		(or (looking-at "^")
		    (forward-line 1))
		(while (looking-at "^")
		  (insert "  ")
		  (forward-line 1))
		;; Convert ` ./FILE' to ` FILE'
		;; This would lose if the current chunk of output
		;; starts or ends within the ` ./', so back up a bit:
		(goto-char (- end 3))	; no error if < 0
		(while (search-forward " ./" nil t)
		  (delete-region (point) (- (point) 2)))
		;; Find all the complete lines in the unprocessed
		;; output and process it to add text properties.
		(goto-char end)
		(if (search-backward "\n" (process-mark proc) t)
		    (progn
		      (dired-insert-set-properties (process-mark proc)
						   (1+ (point)))
		      (move-marker (process-mark proc) (1+ (point)))))
		))))
      ;; The buffer has been killed.
      (delete-process proc))))

(defun tracker-dired-sentinel (proc state)
  ;; Sentinel for \\[tracker-dired] processes.
  (let ((buf (process-buffer proc)))
    (if (buffer-name buf)
	(save-excursion
	  (set-buffer buf)
	  (let ((buffer-read-only nil))
	    (save-excursion
	      (goto-char (point-max))
	      (insert "\n  tracker-query finished")
	      (forward-char -1)		;Back up before \n at end of STATE.
	      (forward-char 1)
	      (setq mode-line-process
		    (concat ":"
			    (symbol-name (process-status proc))))
	      ;; Since the buffer and mode line will show that the
	      ;; process is dead, we can delete it now.  Otherwise it
	      ;; will stay around until M-x list-processes.
	      (delete-process proc)
	      (force-mode-line-update))
	    )
	  (toggle-read-only t)
	  ))))

(provide 'tracker-dired)

;;; tracker-dired.el ends here

