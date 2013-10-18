(require 'dtrt-indent)
(defun my-c-common-hook()
  (interactive)
  (make-variable-buffer-local 'hippie-expand-try-functions-list)
;;  (local-set-key (kbd "C-c C-h") 'ff-find-other-file)
  (c-set-style "k&r")
  (dtrt-indent-mode t)
  (c-toggle-auto-state -1)
  (c-toggle-hungry-state t)
  (c-toggle-electric-state t)
  (setq c-basic-offset 4)
  (subword-mode t)
  (glasses-mode t)
  (if (< buffer-saved-size 1024000)
      (auto-highlight-symbol-mode t)
    )
  (c-set-offset 'case-label 4)
  (imenu-add-menubar-index)
  (which-function-mode 1)
  ;; (add-to-list 'which-func-modes 'java-mode)
  (hs-minor-mode t)
  (hs-hide-initial-comment-block)
  (local-set-key (kbd "C-c o o") 'hs-toggle-hiding)
  (local-set-key (kbd "C-c o s") 'hs-show-all)
  (local-set-key (kbd "C-c o h") 'hs-hide-level)

  (hide-ifdef-mode t)
  ;; (setq hide-ifdef-initially t)
  ;; (hide-ifdefs)
  (auto-fill-mode 1)
  (linum-mode 1)
  (flyspell-prog-mode)
  (local-set-key (kbd "C-c C-c") 'droid)

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
  (local-set-key (kbd "C-M-\\") (lambda ()
				  (interactive)
				  (save-excursion
				    (if (not (region-active-p))
					(c-mark-function)
				      )
				    (call-interactively 'indent-region)
				    )

				  ))
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

;; (setq compilation-finish-function
;;       (lambda (buf str)
;;         (save-excursion
;;           (with-current-buffer buf
;;             (goto-char (point-min))
;;             (if (re-search-forward "abnormally" nil t)
;;                 (tooltip-show "compilation errors, press C-x ` to visit")
;; 	      (progn
;; 		;; (run-at-time 0.5 nil 'delete-windows-on buf)
;; 		(tooltip-show "NO COMPILATION ERRORS!")
;; 		)
;;               )))))

;; (based on work by Arndt Gulbrandsen, Troll Tech)
(defun jk/c-mode-common-hook ()
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

;; (require 'idomenu)
;; (global-set-key (kbd "M-,") 'idomenu)
;; (global-set-key (kbd "M-,") 'imenu-tree)


(setq xml-imenu-generic-expression
      '(("activity"  "<activity[^;]*?android:name=\"\\(.*\\)\"" 1 )
	("receiver"  "<receiver[^;]*?android:name=\"\\(.*\\)\"" 1 )
	("service"  "<service[^;]*?android:name=\"\\(.*\\)\"" 1 )
        ))

(add-hook 'nxml-mode-hook
	  (lambda ()
	    (setq imenu-generic-expression xml-imenu-generic-expression)))

;; (defvar java-function-regexp
;;   (concat
;;    "^[ \t]*"                                   ; leading white space
;;    "\\(public\\|private\\|protected\\|"        ; some of these 8 keywords
;;    "abstract\\|final\\|static\\|"
;;    "synchronized\\|native"
;;    "\\|[ \t\n\r]\\)*"                          ; or whitespace
;;    "\\(<.*?>\\)?"                                     ; meta
;;    "[ \t\n\r]+"                                ; whitespace
;;    "[a-zA-Z0-9_$]+"                            ; return type
;;    "[ \t\n\r]*[[]?[]]?"                        ; (could be array)
;;    "[ \t\n\r]+"                                ; whitespace
;;    "\\([a-zA-Z0-9_$]+\\)"                      ; the name we want!
;;    "[ \t\n\r]*"                                ; optional whitespace
;;    "("                                         ; open the param list
;;    "\\([ \t\n\r]*"                             ; optional whitespace
;;    "\\<[a-zA-Z0-9_$]+\\>"                      ; typename
;;    "[ \t\n\r]*[[]?[]]?"                        ; (could be array)
;;    "[ \t\n\r]+"                                ; whitespace
;;    "\\<[a-zA-Z0-9_$]+\\>"                      ; variable name
;;    "[ \t\n\r]*[[]?[]]?"                        ; (could be array)
;;    "[ \t\n\r]*,?\\)*"                          ; opt whitespace and comma
;;    "[ \t\n\r]*"                                ; optional whitespace
;;    ")"                                         ; end the param list
;;    "[ \t\n\r]*"                                ; whitespace
;; ;   "\\(throws\\([, \t\n\r]\\|[a-zA-Z0-9_$]\\)+\\)?{"
;;    "\\(throws[^{;]+\\)?"                       ; optional exceptions
;;    "[;{]"                                      ; ending ';' (interfaces) or '{'
;;    )
;;   "Matches method names in java code, select match 2")

;; (defvar java-class-regexp
;;   "^[ \t\n\r]*\\(final\\|abstract\\|public\\|[ \t\n\r]\\)*class[ \t\n\r]+\\([a-zA-Z0-9_$]+\\)[^;{]*{"
;;   "Matches class names in java code, select match 2")

;; (defvar java-interface-regexp
;;   "^[ \t\n\r]*\\(abstract\\|public\\|[ \t\n\r]\\)*interface[ \t\n\r]+\\([a-zA-Z0-9_$]+\\)[^;]*;"
;;   "Matches interface names in java code, select match 2")

;; (defvar java-imenu-regexp
;;   (list (list nil java-function-regexp 3)
;;         (list nil java-class-regexp 2)
;;         (list nil java-interface-regexp 2))
;;   "Imenu expression for Java")

;; install it
;; (add-hook 'java-mode-hook
;;           (function (lambda ()
;;                       (setq imenu-generic-expression java-imenu-regexp))))

(define-fringe-bitmap 'hs-marker [0 24 24 126 126 24 24 0])

(defface hs-fringe-face
  '((t (:foreground "#888" :box (:line-width 2 :color "gray75" :style released-button))))
  "Face used to highlight the fringe on folded regions"
  :group 'hideshow)

(custom-set-faces
 '(hs-fringe-face ((t (:foreground "yellow"))) t)
 )

(defun display-code-line-counts (ov)
  (when (eq 'code (overlay-get ov 'hs))
    (let* ((marker-string "*fringe-dummy*")
           (marker-length (length marker-string))
           (display-string (format " ...(%d)" (count-lines (overlay-start ov) (overlay-end ov))))
           )
      (overlay-put ov 'help-echo "Hiddent text. C-c,= to show")
      (put-text-property 0 marker-length 'display
                         (list 'left-fringe 'hs-marker 'hs-fringe-face) marker-string)
      (overlay-put ov 'before-string marker-string)
      (put-text-property 0 (length display-string) 'face 'hs-face display-string)
      (overlay-put ov 'display display-string)
      )))
(setq hs-set-up-overlay 'display-code-line-counts)

(add-hook 'c-mode-common-hook
	  (function (lambda ()
		      (add-hook 'local-write-file-hooks
				'check-parens))))

(require 'etags-select)
(global-set-key "\M-." 'etags-select-find-tag)
(require 'etags-stack)

