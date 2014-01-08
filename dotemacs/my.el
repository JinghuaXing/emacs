(defun ascii-table-show ()
  "Print the ascii table"
  (interactive)
  (switch-to-buffer "*ASCII table*")
  (erase-buffer)
  (let ((i   0)
	(tmp 0))
    (insert (propertize
	     "                                [ASCII table]\n\n"
	     'face font-lock-comment-face))
    (while (< i 32)
      (dolist (tmp (list i (+ 32 i) (+ 64 i) (+ 96 i)))
	(insert (concat
		 (propertize (format "%3d " tmp)
			     'face font-lock-function-name-face)
		 (propertize (format "[%2x]" tmp)
			     'face font-lock-constant-face)
		 "      "
		 (propertize (format "%3s" (single-key-description tmp))
			     'face font-lock-string-face)
		 (unless (= tmp (+ 96 i))
		   (propertize " | " 'face font-lock-variable-name-face)))))
      (newline)
      (setq i (+ i 1)))
    (beginning-of-buffer))
  (toggle-read-only 1)
  )

;;;;;;;;;;;;;;; count Chinese, English words
(defun my-count-ce-word (beg end)
  "Count Chinese and English words in marked region."
  (interactive "r")
  (let* ((cn-word 0)
	 (en-word 0)
	 (total-word 0)
	 (total-byte 0))
    (setq cn-word (count-matches "\\cc" beg end)
	  en-word (count-matches "\\w+\\W" beg end)
	  total-word (+ cn-word en-word)
	  total-byte (+ cn-word (abs (- beg end))))
    (message (format "字数: %d (汉字: %d, 英文: %d) , %d 字节."
		     total-word cn-word en-word total-byte))))
;;;;;;;;;;;;;;;;;

(defun quick-copy-line ()
  "Copy the whole line that point is on and move to the beginning of the next line.
  Consecutive calls to this command append each line to the kill-ring."
  (interactive)
  (let ((beg (line-beginning-position 1))
	(end (line-beginning-position 2)))
    (if (eq last-command 'quick-copy-line)
	(kill-append (buffer-substring beg end) (< end beg))
      (kill-new (buffer-substring beg end))))
  (beginning-of-line 2))
(defun lev/find-tag (&optional show-only)
  "Show tag in other window with no prompt in minibuf."
  (interactive)
  (let ((default (funcall (or find-tag-default-function
                              (get major-mode 'find-tag-default-function)
                              'find-tag-default))))
    (if show-only
        (progn (find-tag-other-window default)
               (shrink-window (- (window-height) 12)) ;; ÏÞÖÆÎª 12 ÐÐ
               (recenter 1)
               (other-window 1))
      (find-tag default))))

(defun my-locate-command-line (search-string)
  (list locate-command "-i" search-string))
(setq locate-make-command-line 'my-locate-command-line)

(defun my-bookmark-jump (bookmark)
  (interactive
   (progn
     (require 'bookmark)
     (bookmark-maybe-load-default-file)
     (list (ido-completing-read "Jump to bookmark: "
				(mapcar 'car bookmark-alist)))))
  (if (or (eq major-mode 'sr-mode) (eq major-mode 'sr-virtual-mode)) 
      (sr-quit)
      )
  (bookmark-jump bookmark))

(defun my-bookmark-set (bookmark)
  (interactive
   (progn
     (require 'bookmark)
     (bookmark-maybe-load-default-file)
     (list (ido-completing-read "Set bookmark: "
				(mapcar 'car bookmark-alist)))))
  (bookmark-set bookmark))

(global-set-key (kbd "C-x r b") 'my-bookmark-jump)
(global-set-key (kbd "C-x r m") 'my-bookmark-set)

(add-hook 'diary-mode-hook
	  '(lambda ()
	     (local-set-key (kbd "C-x C-s") '(lambda()
					       (interactive)
					       (save-buffer)
					       (kill-buffer-and-window)
					       (exit-calendar)
					       )
			    )
	     )
	  )
(add-hook 'calendar-mode-hook
	  '(lambda ()
	     (local-set-key (kbd "q") '(lambda()
					 (interactive)
					 (setq foo (get-buffer ".diary"))
					 (if foo
					     (progn
					       (set-buffer foo)
					       (save-buffer)
					       (kill-buffer foo)
					       )
					   )
					 (exit-calendar)
					 (if (get-buffer "\*Calendar\*")
					     (kill-buffer "\*Calendar\*")
					   )
					 )
			    )
	     (local-set-key (kbd "<f12>") '(lambda()
					     (interactive)
					     (setq foo (get-buffer ".diary"))
					     (if foo
						 (progn
						   (set-buffer foo)
						   (save-buffer)
						   (kill-buffer foo)
						   )
					       )
					     (exit-calendar)
					     (if (get-buffer "\*Calendar\*")
						 (kill-buffer "\*Calendar\*")
					       )
					     )
			    )

	     )
	  )

(defvar find-file-root-prefix (if (featurep 'xemacs) "/[sudo/root@localhost]" "/sudo:root@localhost:" )
  "*The filename prefix used to open a file with `find-file-root'.")

(defvar find-file-root-history nil
  "History list for files found using `find-file-root'.")

(defvar find-file-root-hook nil
  "Normal hook for functions to run after finding a \"root\" file.")

(defun find-file-root ()
  "*Open a file as the root user.
   Prepends `find-file-root-prefix' to the selected file name so that it
   maybe accessed via the corresponding tramp method."

  (interactive)
  (require 'tramp)
  (let* ( ;; We bind the variable `file-name-history' locally so we can
   	 ;; use a separate history list for "root" files.
   	 (file-name-history find-file-root-history)
   	 (name (or buffer-file-name default-directory))
   	 (tramp (and (tramp-tramp-file-p name)
   		     (tramp-dissect-file-name name)))
   	 path dir file)

    ;; If called from a "root" file, we need to fix up the path.
    (when tramp
      (setq path (tramp-file-name-path tramp)
   	    dir (file-name-directory path)))

    (when (setq file (read-file-name "Find file (UID = 0): " dir path))
      (find-file (concat find-file-root-prefix file))
      ;; If this all succeeded save our new history list.
      (setq find-file-root-history file-name-history)
      ;; allow some user customization
      (run-hooks 'find-file-root-hook))))
;; (global-set-key [(control x) (control r)] 'find-file-root)

(setq my-shebang-patterns
      (list "^#!/usr/.*/perl\\(\\( \\)\\|\\( .+ \\)\\)-w *.*"
	    "^#!/usr/.*/sh"
	    "^#!/usr/.*/bash"
	    "^#!/bin/sh"
	    "^#!/.*perl"
	    "^#!/.*python"
	    "^#!/.*awk"
	    "^#!/.*sed"
	    "^#!/.*ruby"
	    "^#!/bin/bash"
	    "^#!.*env .*"
	    ))
(if (eq system-type 'gnu/linux)
    (add-hook
     'after-save-hook
     (lambda ()
       (if (not (= (shell-command (concat "test -x " (buffer-file-name))) 0))
	   (progn
	     ;; This puts message in *Message* twice, but minibuffer
	     ;; output looks better.
	     (message (concat "Wrote " (buffer-file-name)))
	     (save-excursion
	       (goto-char (point-min))
	       ;; Always checks every pattern even after
	       ;; match.  Inefficient but easy.
	       (dolist (my-shebang-pat my-shebang-patterns)
		 (if (looking-at my-shebang-pat)
		     (if (= (shell-command
			     (concat "chmod u+x " (buffer-file-name)))
			    0)
			 (message (concat
				   "Wrote and made executable "
				   (buffer-file-name))))))))
	 ;; This puts message in *Message* twice, but minibuffer output
	 ;; looks better.
	 (message (concat "Wrote " (buffer-file-name))))))
    )


(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (let ((col (current-column))
	start
	end)
    (beginning-of-line)
    (setq start (point))
    (end-of-line)
    (forward-char)
    (setq end (point))
    (let ((line-text (delete-and-extract-region start end)))
      (forward-line n)
      (insert line-text)
      ;; restore point to original column in moved line
      (forward-line -1)
      (forward-char col))))

(defun move-line-down ()
  (interactive)
  (let ((col (current-column)))
    (forward-line 1)
    (transpose-lines 1)
    (previous-line 1)
    (forward-char col)
    ))
(defun move-line-up ()
  (interactive)
  (let ((col (current-column)))
    (transpose-lines 1)
    (previous-line 2)
    (forward-char col)
    ))
(global-set-key (kbd "<M-up>") 'move-line-up)
(global-set-key (kbd "<M-down>") 'move-line-down)
(defun reverse-sentence-region (&optional separator)
  (interactive "P")
  (let ((beg (point))
	(sentence)
	(separator))
    (when current-prefix-arg
      (setq separator (read-string "Separator: ")))
    (kill-region beg (mark))
    (setq sentence (nth 0 kill-ring))
    (setq sentence (split-string sentence (if separator
					      separator)))
    (setq sentence (reverse sentence))
    (setq sentence (mapconcat #'(lambda (x) x)
			      sentence
			      (if separator
				  separator
				" ")))
    (insert sentence)))
(global-set-key (kbd "M-^")
		(lambda ()
		  (interactive)
		  (delete-indentation 1)
		  (delete-char 1)
		  )
		)

(defun sacha/increase-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (ceiling (* 1.10
                                  (face-attribute 'default :height)))))
(defun sacha/decrease-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (floor (* 0.9
				(face-attribute 'default :height)))))
(global-set-key (kbd "<C-mouse-4>") 'sacha/increase-font-size)
(global-set-key (kbd "<C-mouse-5>") 'sacha/decrease-font-size)

;;#+BEGIN_EXAMPLE
;;#+END_EXAMPLE
(defun org-enclose-region-example (beg end)
  "Count Chinese and English words in marked region."
  (interactive "r")
  (kill-region beg end)
  (beginning-of-line)
  (insert "#+BEGIN_EXAMPLE\n")
  (yank)
  (insert "\n")
  (beginning-of-line)
  (insert "#+END_EXAMPLE")
  )

(defun org-enclose-code (beg end code)
  "Count Chinese and English words in marked region."
  (interactive "r\nMCode: ")
  (kill-region beg end)
  (beginning-of-line)
  (insert (concat "#+BEGIN_HTML\n<pre lang=\"" code "\" line=\"1\">\n"))
  (yank)
  (insert "\n")
  (beginning-of-line)
  (insert "</pre>\n#+END_HTML")
  )

(defun org-enclose-code (beg end code)
   "Count Chinese and English words in marked region."
  (interactive "r\nMCode: ")
  (kill-region beg end)
  (beginning-of-line)
  (insert (concat "#+begin_src " code "\n") )
  (yank)
  (insert "\n")
  (beginning-of-line)
  (insert "#+end_src")
  )

(setq last_buffer nil)
(defun toggle-eshell ()
  "toggle eshell."
  (interactive)
  (setq current_buffer (current-buffer))
  (if (string-equal (buffer-name current_buffer) "*eshell*")
      (switch-to-buffer last_buffer)
    (progn
      (setq last_buffer current_buffer)
      (eshell)
      )
    )
  )

(defun open-next-line (arg)
  "Move to the next line and then opens a line.
    See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (indent-according-to-mode))

;;(global-unset-key (kbd "C-o"))
;; Behave like vi's O command

(defun beginning-of-string(&optional arg)
  "  "
  (re-search-backward "[ \t(]" (line-beginning-position) 3 1)
  (if (looking-at "[\t (]")  (goto-char (+ (point) 1)) )
  )
(defun end-of-string(&optional arg)
  " "
  (re-search-forward "[ \t()]" (line-end-position) 3 arg)
  (if (looking-back "[\t ()]") (goto-char (- (point) 1)) )
  )

(defun thing-kil-string-to-mark(&optional arg)
  " Try to copy a string and paste it to the mark
     When used in shell-mode, it will paste string on shell prompt by default "
  (interactive "P")
  (beginning-of-string)
  (setq a (point))
  (end-of-string)
  (setq b (point))
  (kill-region a b)
  )

(defun thing-copy-string-to-mark(&optional arg)
  " Try to copy a string and paste it to the mark
     When used in shell-mode, it will paste string on shell prompt by default "
  (interactive "P")
  (copy-thing 'beginning-of-string 'end-of-string arg)
  )

(global-set-key (kbd "<M-S-backspace>") (quote thing-kil-string-to-mark))
(global-set-key (kbd "C-c s") (quote thing-copy-string-to-mark))
(defun beginning-of-parenthesis(&optional arg)
  "  "
  (re-search-backward "[[<(?\"]" (line-beginning-position) 3 1)
  (if (looking-at "[[<(?\"]")  (goto-char (+ (point) 1)) )
  )

(defun end-of-parenthesis(&optional arg)
  " "
  (re-search-forward "[]>)?\"]" (line-end-position) 3 arg)
  (if (looking-back "[]>)?\"]") (goto-char (- (point) 1)) )
  )

(defun thing-copy-parenthesis-to-mark(&optional arg)
  " Try to copy a parenthesis and paste it to the mark
     When used in shell-mode, it will paste parenthesis on shell prompt by default "
  (interactive "P")
  (copy-thing 'beginning-of-parenthesis 'end-of-parenthesis arg)
  )

(global-set-key (kbd "C-c a")         (quote thing-copy-parenthesis-to-mark))

(defun get-point (symbol &optional arg)
  "get the point"
  (funcall symbol arg)
  (point)
  )

(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "copy thing between beg & end into kill ring"
  (let ((beg (get-point begin-of-thing 1))
	(end (get-point end-of-thing arg)))
    (copy-region-as-kill beg end))
  )

(defun uniquify-all-lines-region (start end)
  "Find duplicate lines in region START to END keeping first occurrence."
  (interactive "*r")
  (save-excursion
    (let ((end (copy-marker end)))
      (while
	  (progn
	    (goto-char start)
	    (re-search-forward "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t))
	(replace-match "\\1\n\\2")))))

(defun isearch-save-and-exit ()
  "Exit search normally. and save the `search-string' on kill-ring."
  (interactive)
  (isearch-done)
  (isearch-clean-overlays)
  (kill-new isearch-string))

(define-key isearch-mode-map    "\M-w" 'isearch-save-and-exit)
(define-key isearch-mode-map    "\C-y" 'isearch-yank-kill)

(add-hook 'isearch-mode-end-hook 'my-goto-match-beginning)
(defun my-goto-match-beginning ()
  (when isearch-forward (goto-char isearch-other-end)))

(defadvice isearch-exit (after my-goto-match-beginning activate)
  "Go to beginning of match."
  (when isearch-forward (goto-char isearch-other-end)))

(defun isearch-yank-sexp ()
  "Pull next word from buffer into search string."
  (interactive)
  (isearch-yank-internal (lambda () (forward-sexp 1) (point))))
(define-key isearch-mode-map    "\C-w" 'isearch-yank-sexp)

;; show Unicode table
;; inspired by http://www.chrislott.org/geek/emacs/dotemacs.html
(defun unicode-table ()
  "Print the utf16 table. Based on a defun by Alex Schroeder <asc@bsiag.com>"
  (interactive)
  (switch-to-buffer "*Unicode Table*")
  (erase-buffer)
  (insert (format "Unicode characters:\n"))

  ;; Generate list of all unicode code points
  ;; See http://en.wikipedia.org/wiki/Unicode_plane#Overview
  (setq code-points (append (number-sequence  ?\x0000  ?\xffff)
			    (number-sequence ?\x10000 ?\x1ffff)
			    (number-sequence ?\x20000 ?\x2ffff)
			    (number-sequence ?\xe0000 ?\xeffff)))

  ;; Iterate code points
  (dolist (code-point code-points)
    ;; Get description from emacs internals
    (let ((description (get-char-code-property code-point
					       'name)))
      ;; Insert code-point, character and description
      (insert (format "%4d 0x%02X %c %s\n"
		      code-point
		      code-point
		      code-point
		      description))))
  ;; Jump to beginning of buffer
  (beginning-of-buffer))

(defun clean-buffer ()
  (interactive)
   (save-excursion
     (goto-char (point-min))
     ;; 判断多个空行
     (while (re-search-forward "^[ \t]*\n[ \t]*$" nil t)
       (delete-blank-lines)
       (forward-line))
     (delete-trailing-whitespace)
     ))


(defun nautilus ()
  "Open ROX-Filer window for named file"
  (interactive)
  (call-process "nautilus" nil 0 nil (expand-file-name default-directory) "--no-desktop")
  )

(defun aj-toggle-fold ()
  "Toggle fold all lines larger than indentation on current line"
  (interactive)
  (let ((col 1))
    (save-excursion
      (back-to-indentation)
      (setq col (+ 1 (current-column)))
      (set-selective-display
       (if selective-display nil (or col 1))))))

(defun beagrep ()
  (interactive)
  (let ((symbol (thing-at-point 'symbol))
	(for-file "")
	(orig-command compile-command)
	)
    (if last-prefix-arg
	(setq for-file "-f ")
	)
    (setq query (read-from-minibuffer
		 (format (concat "Beagrep " (if (eq for-file "") 
						"contents: "
					      "files: "
					      )))
		 symbol nil nil nil))
    (if (get-buffer "*beagrep*")
	(kill-buffer "*beagrep*")
	)
    (setq command (concat "beagrep " for-file " -e '" query "'"))
    (with-current-buffer (compilation-start command nil)
      (rename-buffer "*beagrep*")
      )
    (switch-to-buffer-other-window "*beagrep*")
    (delete-other-windows)
    (setq compile-command orig-command)
    )
  )

(global-set-key [(M /)] (lambda ()
			  (interactive)
			  (beagrep)
			  )
		)

(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
	   (and (not current-prefix-arg)
		;; (member major-mode '(emacs-lisp-mode lisp-mode java-mode nxml-mode
		;; 				     clojure-mode    scheme-mode
		;; 				     haskell-mode    ruby-mode
		;; 				     rspec-mode      python-mode
		;; 				     c-mode          c++-mode
		;; 				     objc-mode       latex-mode
		;; 				     plain-tex-mode))
		(let ((mark-even-if-inactive transient-mark-mode))
		  (indent-region (region-beginning) (region-end) nil))))))


(defalias 'mbm 'menu-bar-mode)

(defadvice pwd (after my-pwd activate)
  ""
  (if current-prefix-arg
      (kill-new (buffer-file-name))
      )
  )

(defun dos2unix ()
  "Automate M-% C-q C-m RET RET"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (search-forward (string ?\C-m)  nil t)
      (replace-match "" nil t))))

(defun unix2dos ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t) (replace-match "\r\n")))


(defun my-move-begin-of-line ()
  (interactive)
  (let ((current_point (point)))
    (back-to-indentation)
    (if (= current_point (point))
	(beginning-of-line)
	)
    )
  )

(defun my-move-end-of-line ()
  (interactive)
  (let ((current_point (point)))
    (when (comment-search-forward (line-end-position) t)
      (goto-char (match-beginning 0))
      (skip-syntax-backward " " (line-beginning-position))
      (if (= current_point (point))
	  (move-end-of-line nil)
	)
      )
    )
  )
;; (global-set-key (kbd "C-a") (lambda()
;; 			      (interactive)
;; 			      (my-move-begin-of-line)
;; 			      ))
;; (global-set-key (kbd "C-e") (lambda()
;; 			      (interactive)
;; 			      (my-move-end-of-line)
;; 			      ))


(require 'nxml-mode)
(define-key nxml-mode-map "\M-\C-a" '(lambda ()
				       (interactive)
				       (beginning-of-line)
				       (call-interactively 'nxml-backward-up-element))
  )
(define-key nxml-mode-map "\M-\C-e" '(lambda ()
				       (interactive)
				       (end-of-line)
				       (call-interactively 'nxml-backward-up-element)
				       (call-interactively 'nxml-forward-element)
				       )
  )

(defun gist ()
  (interactive)
  (if (get-buffer "*gist*")
      (kill-buffer "*gist*")
    )
  (if current-prefix-arg
      (progn
        (setq url (read-from-minibuffer "update: "))
        (with-current-buffer (compilation-start (concat "gist -P -c -f " (file-name-nondirectory (buffer-file-name)) " -u " url) nil)
          (rename-buffer "*gist*")
          )
        )
    (progn
      (with-current-buffer (compilation-start (concat "gist -P -c -f " (file-name-nondirectory (buffer-file-name))) nil)
        (rename-buffer "*gist*")
        )
      )
    )
  (switch-to-buffer-other-window "*gist*")
  (delete-other-windows)
  )

(defun grep-live-buffer (l)
  (let ((buffer (car l)))
    (if buffer
	(progn
	  (if (get-buffer buffer)
	      (cons buffer (grep-live-buffer (cdr l)))
	    (grep-live-buffer (cdr l)) 
	    )
	  )
      )
    )
  )

(global-set-key (kbd "C-x C-x") '(lambda ()
				   (interactive)
				   (setq search_candidates (grep-live-buffer '("*beagrep*" "*ack*" "*Find*" "*Moccur*" "*etags-select*")))
				   (when search_candidates
				     (if (not (cdr search_candidates))
					 (setq select_name (car search_candidates))
				       (setq select_name (ido-completing-read "Switch to query: " search_candidates))
				       )
				     (switch-to-buffer select_name)
				     )
				   )
		)
