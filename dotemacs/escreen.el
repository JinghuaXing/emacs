(require 'term)
(setq last_normal_buffer nil)
(setq last_term_buffer nil)
(setq term_buffers nil)
(defun toggle-escreen()
  "toggle escreen"
  (interactive)
  (setq current_buffer (current-buffer))
  (if (eq major-mode 'eshell-mode)
      (progn
	(setq last_term_buffer current_buffer)
	(switch-to-normal)
	)
    (progn
      (setq last_normal_buffer current_buffer)
      (switch-to-screen)
      )
    )
  )
(global-set-key (kbd "C-x C-x") 'toggle-escreen)

(defun switch-to-screen()
  "switch to screen"
  (interactive)
  ;; (setq term_buffers (purge-dead-buffer term_buffers))
  (if (buffer-live-p last_term_buffer)
      (switch-to-buffer last_term_buffer)
    (progn
      (if term_buffers
	  (switch-to-buffer (car term_buffers))
	(create-term)
	)
      )
    )
  )

(defun switch-to-normal()
  "switch to back to normal buffer"
  (interactive)
  (if (buffer-live-p last_normal_buffer)
      (switch-to-buffer last_normal_buffer)
    (ibuffer)
    )
  )

(require 'eshell)

(defun create-term()
  (interactive)
  (setq previous_buffer (current-buffer))
  (eshell)
  (rename-buffer "ESH" t)
  (setq term_buffers (cons (current-buffer) term_buffers))
  ;; sort
  (setq term_buffers (sort term_buffers '(lambda(buffer1 buffer2)
					   (let ((name1 (buffer-name buffer1))
						 (name2 (buffer-name buffer2))
						 )
					     (string-lessp name1 name2)
					     )
					   )
			   )
	)
  )

(setq next_buffer nil)
(add-hook 'eshell-mode-hook
	  (lambda()
	    (define-key eshell-mode-map (kbd "C-x b") 'term-switch-buffer)
	    (define-key eshell-mode-map (kbd "C-o C-c") 'create-term)
	    (define-key eshell-mode-map (kbd "C-o C-n") '(lambda()
							   (interactive)
							   (let (
								 (length (- (length term_buffers) 1))
								 (buffer (current-buffer))
								 )
							     (setq n (find-element-in-list buffer term_buffers))
							     (if (eq n length)
								 (setq n 0)
							       (incf n)
							       )
							     (setq previous_buffer buffer)
							     (switch-to-buffer (nth n term_buffers))
							     )
							   )
	      )
	    (define-key eshell-mode-map (kbd "C-o C-o") '(lambda()
							   "goto previous buffer"
							   (interactive)
							   (let (
								 (next_buffer previous_buffer)
								 (buffer (current-buffer))
								 )

							     (setq previous_buffer buffer)
							     (switch-to-buffer next_buffer)
							     )
							   )
	      )


	  (define-key eshell-mode-map (kbd "C-o C-p") '(lambda()
							 (interactive)
							 ;; (setq term_buffers (purge-dead-buffer term_buffers))
							 (let (
							       (length (- (length term_buffers) 1))
							       (buffer (current-buffer))
							       )
							   (setq n (find-element-in-list buffer term_buffers))
							   (if (eq n 0)
							       (setq n length)
							     (decf n)
							     )
							   (setq previous_buffer buffer)
							   (switch-to-buffer (nth n term_buffers))
							   )
							 )
	    )
	  (define-key eshell-mode-map (kbd  "C-o C-a") 'term-rename)
	  )
	  )






(defun term-switch-buffer()
  "switch term buffer"
  (interactive)
  (let (
	(buffer_names nil)
	(select_name nil)
	(buffer (current-buffer))
	)
    
    (setq buffer_names (mapcar '(lambda (buffer)
				  (buffer-name buffer)
				  )
			       (remove buffer term_buffers)))
    (setq select_name (ido-completing-read "Switch to: " buffer_names))
    (if select_name
	(progn
	  (setq previous_buffer buffer)
	  (switch-to-buffer select_name)
	  )
      )
    )
  )







(defun term-rename(name)
  (interactive "MName: ")
  (rename-buffer (concat (buffer-name)  "@" name ))
  )


(defun find-element-in-list (element list)
  (if (or (eq list nil) (equal element (car list)))
      0
    (+ 1 (find-element-in-list element (cdr list)))
    )
  )

;; (defun purge-dead-buffer(buffers)
;;   (if (eq buffers nil)
;;       nil
;;     (let ((buffer (car buffers))
;; 	  (other (cdr buffers))
;; 	  )
;;       (if (buffer-live-p buffer)
;; 	  (cons buffer (purge-dead-buffer other))
;; 	(purge-dead-buffer other))
;;       )
;;     )
;;   )

(defun purge-dead-buffer(buffers)
  (if (eq buffers nil)
      nil
    (let ((buffer (car buffers))
	  (other (cdr buffers))
	  (current_buffer (current-buffer))
	  )
      (if (eq current_buffer buffer)
	  (purge-dead-buffer other)
	(cons buffer (purge-dead-buffer other))
	)
      )
    )
  )

(add-hook 'kill-buffer-hook '(lambda()
			       (setq term_buffers (purge-dead-buffer term_buffers))		       
			       )
	  )

(defun kill-buffer-when-exit ()
  "Close assotiated buffer when a process exited"
  (let ((current-process (ignore-errors (get-buffer-process (current-buffer)))))
    (when current-process
      (set-process-sentinel current-process
			    (lambda (watch-process change-state)
			      (when (string-match "\\(finished\\|exited\\)" change-state)
				(kill-buffer (process-buffer watch-process))))))))
(add-hook 'gdb-mode-hook 'kill-buffer-when-exit)
(add-hook 'term-mode-hook 'kill-buffer-when-exit)
