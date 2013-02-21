(load "escreen")
(escreen-install)
(setq escreen-prefix-char "\C-o")
(global-set-key escreen-prefix-char 'escreen-prefix)

(defun escreen-goto-last-screen-dim ()
  (interactive)
  (escreen-goto-last-screen)
  (escreen-get-active-screen-numbers-with-emphasis))

(defun escreen-goto-prev-screen-dim (&optional n)
  (interactive "p")
  (escreen-goto-prev-screen n)
  (escreen-get-active-screen-numbers-with-emphasis))

(defun escreen-get-active-screen-numbers-with-emphasis ()
  "what the name says"
  (interactive)
  (let ((escreens (escreen-get-active-screen-numbers))
        (emphased ""))
    
    (dolist (s escreens)
      (setq emphased
            (concat emphased (if (= escreen-current-screen-number s)
                                 (propertize (number-to-string s)
                                             ;;'face 'custom-variable-tag) " ")
                                             'face 'info-title-3)
			       ;;'face 'font-lock-warning-face)
			       ;;'face 'secondary-selection)
                               (number-to-string s))
                    " ")))
    (message "escreen: active screens: %s" emphased)))

(defun escreen-goto-next-screen-dim (&optional n)
  (interactive "p")
  (escreen-goto-next-screen n)
  (escreen-get-active-screen-numbers-with-emphasis))

(defun escreen-create-screen-dim ()
  (interactive)
  (escreen-create-screen)
  (escreen-get-active-screen-numbers-with-emphasis))

(defun escreen-kill-screen-dim ()
  (interactive)
  (escreen-kill-screen)
  (escreen-get-active-screen-numbers-with-emphasis))

(add-hook 'escreen-goto-screen-hook 'escreen-get-active-screen-numbers-with-emphasis)

(define-key escreen-map (kbd "C-c") 'escreen-create-screen-dim)
(define-key escreen-map (kbd "C-k") 'escreen-kill-screen-dim)
(define-key escreen-map  (kbd "C-n") 'escreen-goto-next-screen-dim)
(define-key escreen-map  (kbd "C-p") 'escreen-goto-next-screen-dim)
(define-key escreen-map  (kbd "C-o") 'escreen-goto-last-screen-dim)
