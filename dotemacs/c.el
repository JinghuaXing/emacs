;;;something about C program
(defun my-c-common-hook()
  (interactive)
  (make-variable-buffer-local 'hippie-expand-try-functions-list)
  ;; (setq hippie-expand-try-functions-list
  ;; 	'(
  ;; 	  senator-try-expand-semantic
  ;; 	  try-expand-dabbrev
  ;; 	  ;; try-expand-dabbrev-visible
  ;; 	  ;; try-expand-dabbrev-from-kill
  ;; 	  ;; try-expand-dabbrev-all-buffers
  ;; 	  ))
  ;; (local-set-key (kbd "C-c , s") 'semantic-ia-show-summary)
  ;; (local-set-key (kbd "C-c , d") 'semantic-ia-show-doc)
  ;; (local-set-key (kbd "C-c , j") 'semantic-ia-fast-jump)
  ;; (local-set-key (kbd "C-c , ,") 'semantic-mrub-switch-tags)
  (local-set-key (kbd "C-c C-h") 'ff-find-other-file)
  (c-set-style "k&r")
  (subword-mode)
  (setq subword-mode t)
  ;; (c-toggle-auto-state t)
  (c-toggle-hungry-state t)
  (c-toggle-electric-state t)
  (setq c-basic-offset 4)
  ;;(c-set-offset 'case-label 4)
  (imenu-add-menubar-index)
  (which-function-mode 1)
  (hs-minor-mode t)
  (hide-ifdef-mode t)
  (setq hide-ifdef-initially t)
  (hide-ifdefs)
  (auto-fill-mode 1)
  (linum-mode 1)
  (flyspell-prog-mode)
  (local-set-key (kbd "C-c C-c") 'compile)
  
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
(add-hook 'jde-mode-hook 'my-c-common-hook)
;; (defun my-java-common-hook()
;;   (interactive)
;;   (c-toggle-auto-state t)
;;   (c-toggle-hungry-state t)
;;   (c-toggle-electric-state t)
;;   (setq c-basic-offset 4)
;;   (c-set-style "java")
;;   ;;(c-set-offset 'case-label 4)
;;   (imenu-add-menubar-index)
;;   (hs-minor-mode t)
;;   ;;  (fold-mode)
;;   (auto-fill-mode 1)
;;   (linum-mode 1)
;;   (flyspell-prog-mode)
;;   (local-set-key (kbd "C-M-a") 'senator-previous-tag)
;;   (local-set-key (kbd "C-M-e") 'senator-next-tag)
;;   (setq c-hanging-braces-alist
;; 	'((brace-list-open)
;; 	  (brace-entry-open)
;; 	  (statement-cont)
;; 	  (substatement-open after)
;; 	  (block-close . c-snug-do-while)
;; 	  (extern-lang-open after)
;; 	  (namespace-open after)
;; 	  (module-open after)
;; 	  (defun-open after)
;; 	  (class-open after)
;; 	  (class-close)
;; 	  (composition-open after)
;; 	  (inexpr-class-open after)
;; 	  (inexpr-class-close before))
;; 	)
;;   (setq c-cleanup-list
;; 	'(
;; 	  space-before-funcall
;; 	  compact-empty-funcall
;; 	  brace-else-brace
;; 	  brace-elseif-brace
;; 	  brace-catch-brace
;; 	  one-liner-defun
;; 	  empty-defun-braces
;; 	  defun-close-semi
;; 	  comment-close-slash
;; 	  scope-operator
;; 	  )
;; 	)
;;   )


(setq imenu-sort-function 'imenu--sort-by-name)
;; (setq compilation-finish-function 
;;       (lambda (buf str) 
;;         (save-excursion 
;;           (with-current-buffer buf 
;;             (goto-char (point-min)) 
;;             (if (re-search-forward "error:" nil t) 
;;                 (message "compilation errors, press C-x ` to visit") 
;;               (run-at-time 0.5 nil 'delete-windows-on buf) 
;;               (message "NO COMPILATION ERRORS!"))))))

(setq compilation-finish-function 
      (lambda (buf str) 
        (save-excursion 
          (with-current-buffer buf 
            (goto-char (point-min)) 
            (if (re-search-forward "abnormally" nil t) 
                (message "compilation errors, press C-x ` to visit") 
              (run-at-time 0.5 nil 'delete-windows-on buf) 
              (message "NO COMPILATION ERRORS!"))))))


;; (add-hook 'c-mode-hook
;; 	  '(lambda ()
;;               (setq yas/buffer-local-condition
;;                     '(if (nth 8 (syntax-ppss (point)))
;;                          '(require-snippet-condition . force-in-comment)
;;                        t))))
;; (add-hook 'c++-mode-hook
;; 	  '(lambda ()
;;               (setq yas/buffer-local-condition
;;                     '(if (nth 8 (syntax-ppss (point)))
;;                          '(require-snippet-condition . force-in-comment)
;;                        t))))

; syntax-highlighting for Qt
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


