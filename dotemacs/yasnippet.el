(add-to-list 'load-path "~/.elisp/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

(setq yas-buffer-local-condition
      '(if (or (nth 8 (syntax-ppss (point))) (not (eol)))
	   '(require-snippet-condition . force-in-comment)
	 t))
(define-key yas-minor-mode-map (kbd "SPC") 'yas-expand)

(defun eol ()
  (save-excursion
    (let ((current-point (point)))
      (end-of-line)
      (if (eq (point) current-point)
	  t
	nil
	)
      )
    )
  )
