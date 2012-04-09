;;;something about C program
(require 'dtrt-indent)

(defun my-c-common-hook()
  (interactive)
  (make-variable-buffer-local 'hippie-expand-try-functions-list)

  (local-set-key (kbd "C-c C-h") 'ff-find-other-file)
  (c-set-style "k&r")
  (c-subword-mode t)
  (dtrt-indent-mode t)
  (if (boundp electric-pair-mode)
      (electric-pair-mode t)
    )
  (setq c-subword-mode t)
  (c-toggle-auto-state -1)
  (c-toggle-hungry-state t)
  (c-toggle-electric-state t)
  (setq c-basic-offset 4)
  (glasses-mode t)
  (c-set-offset 'case-label 4)
  (imenu-add-menubar-index)
  (which-function-mode 1)
  ;; (add-to-list 'which-func-modes 'java-mode)
;;  (hs-minor-mode t)
  (define-key c-subword-mode-map (kbd "<C-left>") nil)
  (define-key c-subword-mode-map (kbd "<C-right>") nil)
  (define-key c-subword-mode-map (kbd "<M-left>") nil)
  (define-key c-subword-mode-map (kbd "<M-right>") nil)
  
  (hide-ifdef-mode t)
  ;; (setq hide-ifdef-initially t)
  ;; (hide-ifdefs)
  (auto-fill-mode 1)
  (linum-mode 1)
  (flyspell-prog-mode)
  (local-set-key (kbd "C-c C-c") 'compile)
  (outline-minor-mode t)
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

(require 'ajc-java-complete)
(add-hook 'java-mode-hook
	  '(lambda ()
	     (define-key java-mode-map (kbd "C-c i") '(lambda ()
							(interactive)
							(ajc-reload-tag-buffer-maybe)
							(ajc-import-class-under-point)
							))
	     )
	  )

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
;;(add-hook 'find-file-hook 'hs-hide-initial-comment-block)

;;(require 'hideshow)
;;(define-key hs-minor-mode-map (kbd "C-o C-o") 'hs-toggle-hiding)
;;(define-key hs-minor-mode-map (kbd "C-o C-s") 'hs-show-all)
;;(define-key hs-minor-mode-map (kbd "C-o C-h") 'hs-hide-level)

(defun show-onelevel ()
  "show entry and children in outline mode"
  (interactive)
  (show-entry)
  (show-children))
(require 'outline)    
(defun cjm-outline-bindings ()
      "sets shortcut bindings for outline minor mode"
      (interactive)
      (local-set-key [C-up] 'outline-previous-visible-heading)
      (local-set-key [C-down] 'outline-next-visible-heading)
      (local-set-key [C-left] 'hide-subtree)
      (local-set-key [C-right] 'show-onelevel)
      (local-set-key [M-up] 'outline-backward-same-level)
      (local-set-key [M-down] 'outline-forward-same-level)
      (local-set-key [M-left] 'hide-subtree)
      (local-set-key [M-right] 'show-subtree))

(add-hook 'outline-minor-mode-hook
	  'cjm-outline-bindings)

