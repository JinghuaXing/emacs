;;;something about C program
(require 'dtrt-indent)

(defun my-c-common-hook()
  (interactive)
  (make-variable-buffer-local 'hippie-expand-try-functions-list)

  (local-set-key (kbd "C-c C-h") 'ff-find-other-file)
  (c-set-style "k&r")
  (c-subword-mode t)
  (dtrt-indent-mode t)
  ;; (electric-pair-mode t)
  (setq c-subword-mode t)
  (c-toggle-auto-state -1)
  (c-toggle-hungry-state t)
  (c-toggle-electric-state t)
  (setq c-basic-offset 4)
  (glasses-mode t)
  (c-set-offset 'case-label 4)
  (imenu-add-menubar-index)
  (which-function-mode 1)
  (add-to-list 'which-func-modes 'java-mode)
  (hs-minor-mode t)
  (hide-ifdef-mode t)
  ;; (setq hide-ifdef-initially t)
  ;; (hide-ifdefs)
  (auto-fill-mode 1)
  (linum-mode 1)
  (flyspell-prog-mode)
  (local-set-key (kbd "C-c C-c") 'compile)
  ;; override hs key definition
  (setq c-hanging-braces-alist
  	'((brace-list-open after)
  	  (brace-list-close)
  	  (brace-entry-open)
  	  (statement-cont)
  	  (substatement-open after)
  	  (block-close . c-snug-do-while)
  	  (extern-lang-open after)
  	  (namespace-open after)
  	  (module-open after)
  	  (defun-open after)
  	  (class-open after)
  	  (class-close)
  	  (composition-open after)
  	  (inexpr-class-open after)
  	  (inexpr-class-close before))
  	)
  (setq c-cleanup-list
  	'(
  	  ;; space-before-funcall
  	  ;; compact-empty-funcall
  	  brace-else-brace
  	  brace-elseif-brace
  	  brace-catch-brace
  	  one-liner-defun
  	  defun-close-semi
  	  comment-close-slash
  	  scope-operator
  	  )
  	)
  )

(setq compilation-scroll-output t)
(require 'doxymacs)
(defun my-doxymacs-font-lock-hook ()
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
      (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)
(add-hook 'c++-mode-hook 'my-c-common-hook)
(add-hook 'c-mode-common-hook 'my-c-common-hook)
(add-hook 'c-mode-common-hook 'doxymacs-mode)



(add-hook 'java-mode-hook 'my-c-common-hook)

(setq imenu-sort-function 'imenu--sort-by-name)

(setq compilation-finish-function 
      (lambda (buf str) 
        (save-excursion 
          (with-current-buffer buf 
            (goto-char (point-min)) 
            (if (re-search-forward "abnormally" nil t) 
                (message "compilation errors, press C-x ` to visit") 
              (run-at-time 0.5 nil 'delete-windows-on buf) 
              (message "NO COMPILATION ERRORS!"))))))


;; (based on work by Arndt Gulbrandsen, Troll Tech)
(defun jk/c-mode-common-hook ()
  ;; base-style
  ;;   (c-set-style "stroustrup")
  ;; set auto cr mode
  (c-toggle-auto-hungry-state 1)
  
  ;; qt keywords and stuff ...
  ;; set up indenting correctly for new qt kewords
  (setq c-protection-key (concat "\\<\\(public\\|public slot\\|protected"
				 "\\|protected slot\\|private\\|private slot"
				 "\\)\\>")
	c-C++-access-key (concat "\\<\\(signals\\|public\\|protected\\|private"
				 "\\|public slots\\|protected slots\\|private slots"
				 "\\)\\>[ \t]*:"))
  (progn
    ;; modify the colour of slots to match public, private, etc ...
    (font-lock-add-keywords 'c++-mode
			    '(("\\<\\(slots\\|signals\\)\\>" . font-lock-type-face)))
    ;; make new font for rest of qt keywords
    (make-face 'qt-keywords-face)
    (set-face-foreground 'qt-keywords-face "BlueViolet")
    ;; qt keywords
    (font-lock-add-keywords 'c++-mode
			    '(("\\<Q_OBJECT\\>" . 'qt-keywords-face)))
    (font-lock-add-keywords 'c++-mode
			    '(("\\<SIGNAL\\|SLOT\\>" . 'qt-keywords-face)))
    (font-lock-add-keywords 'c++-mode
			    '(("\\<Q[A-Z][A-Za-z]*" . 'qt-keywords-face)))
    (font-lock-add-keywords 'c++-mode
			    '(("\\<foreach" . 'font-lock-keyword-face)))
    
    ))

(add-hook 'c-mode-common-hook 'jk/c-mode-common-hook)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-hook 'find-file-hook 'hs-hide-initial-comment-block)

(setq skeleton-pair t)
(setq skeleton-pair-alist
      '((?\( _ ?\))
	(?[  _ ?])
	(?{  _ ?})
	;; (?\" _ ?\")
	))
(defun autopair-insert (arg)
  (interactive "P")
  (let (pair)
    (if (nth 8 (syntax-ppss (point))) 
	(self-insert-command (prefix-numeric-value arg))
      (cond
       ((assq last-command-char skeleton-pair-alist)
	(autopair-open arg))
       (t
	(autopair-close arg))))))
(defun autopair-open (arg)
  (interactive "P")
  (let ((pair (assq last-command-char
		    skeleton-pair-alist)))
    (cond
     ((and (not mark-active)
	   (eq (car pair) (car (last pair)))
	   (eq (car pair) (char-after)))
      (autopair-close arg))
     (t
      (skeleton-pair-insert-maybe arg)))))
(defun autopair-close (arg)
  (interactive "P")
  (cond
   (mark-active
    (let (pair open)
      (dolist (pair skeleton-pair-alist)
	(when (eq last-command-char (car (last pair)))
	  (setq open (car pair))))
      (setq last-command-char open)
      (skeleton-pair-insert-maybe arg)))
   ((looking-at
     (concat "[ \t\n]*"
	     (regexp-quote (string last-command-char))))
    (replace-match (string last-command-char))
    (indent-according-to-mode))
   (t
    (self-insert-command (prefix-numeric-value arg))
    (indent-according-to-mode))))
(defadvice delete-backward-char (before autopair activate)
  (when (and (char-after)
	     (eq this-command 'delete-backward-char)
	     (eq (char-after)
		 (car (last (assq (char-before) skeleton-pair-alist)))))
    (delete-char 1)))
(add-hook 'c-mode-common-hook
	  '(lambda()
	     (local-set-key "("  'autopair-insert)
	     (local-set-key ")"  'autopair-insert)
	     (local-set-key "["  'autopair-insert)
	     (local-set-key "]"  'autopair-insert)
	     (local-set-key "{"  'autopair-insert)
	     (local-set-key "}"  'autopair-insert)
	     ;; (local-set-key "\"" 'autopair-insert)
	     ))

