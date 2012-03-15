(require 'eshell)
(defun my-eshell-clear-buffer ()
  (interactive)
  (let ((eshell-buffer-maximum-lines 0))
    (eshell-truncate-buffer)))

(defalias 'eshell/clear 'my-eshell-clear-buffer)
(add-hook 'eshell-mode-hook
	  '(lambda ()
	     (define-key eshell-mode-map "\C-l" 'my-eshell-clear-buffer)
	     (define-key eshell-mode-map "\C-u" 'eshell-kill-input)
	     ))

;;(setq eshell-cp-interactive-query t
;;      eshell-ln-interactive-query t
;;      eshell-mv-interactive-query t
;;      eshell-rm-interactive-query t
;;      eshell-mv-overwrite-files nil)

(defun my-eshell-prompt-function ()
  "Return the prompt for eshell."
  (format "%s%s "
          ;;(eshell/basename (eshell/pwd))
          (eshell/pwd)
          ;;(replace-regexp-in-string "\\..*" "" (system-name))
          (if (zerop (user-uid)) "#" "$")))
(setq eshell-prompt-function 'my-eshell-prompt-function
      eshell-prompt-regexp "^.*[#$] "
      eshell-ask-to-save-history 'always
      )
;;(set-face-foreground 'eshell-prompt-face "light blue")

(setq eshell-cmpl-cycle-completions nil)

(add-hook
 'eshell-first-time-mode-hook
 (lambda ()
   (setq
    eshell-visual-commands
    (append
     '("vim" "mutt" "vi" "telnet" "ssh" "alsamixer")
     eshell-visual-commands))))

(setq eshell-save-history-on-exit t)

(require 'ansi-color)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)

(add-hook 'eshell-preoutput-filter-functions
          'ansi-color-apply)

(defface my-eshell-code-face
  '((t (:foreground "Green")))
  "Eshell face for code (.c, .f90 etc) files.")

(defface my-eshell-img-face
  '((t (:foreground "magenta" :weight bold)))
  "Eshell face for image (.jpg etc) files.")

(defface my-eshell-movie-face
  '((t (:foreground "white" :weight bold)))
  "Eshell face for movie (.mpg etc) files.")

(defface my-eshell-music-face
  '((t (:foreground "magenta")))
  "Eshell face for music (.mp3 etc) files.")

(defface my-eshell-ps-face
  '((t (:foreground "cyan")))
  "Eshell face for PostScript (.ps, .pdf etc) files.")

(setq my-eshell-code-list '("f90" "f" "c" "cpp" "h" "hpp" "cxx" "C" "bash" "sh" "csh" "awk" "el")
      my-eshell-img-list
      '("jpg" "jpeg" "png" "gif" "bmp" "ppm" "tga" "xbm" "xpm" "tif" "fli")
      my-eshell-movie-list '("mpg" "avi" "gl" "dl" "wmv")
      my-eshell-music-list '("mp3" "ogg")
      my-eshell-ps-list    '("ps" "eps" "cps" "pdf")
      eshell-ls-highlight-alist nil)

(let (list face)
  (mapcar (lambda (elem)
            (setq list (car elem)
                  face (cdr elem))
            (add-to-list 'eshell-ls-highlight-alist
                         (cons `(lambda (file attr)
                                  (string-match
                                   (concat "\\." (regexp-opt ,list t) "$")
                                   file))
                               face)))
          '((my-eshell-code-list  . my-eshell-code-face)
            (my-eshell-img-list   . my-eshell-img-face)
            (my-eshell-movie-list . my-eshell-movie-face)
            (my-eshell-music-list . my-eshell-music-face)
            (my-eshell-ps-list    . my-eshell-ps-face))))

;; time
(setq last-command-start-time (time-to-seconds))
(add-hook 'eshell-pre-command-hook
          (lambda()(setq last-command-start-time (time-to-seconds))))
(add-hook 'eshell-before-prompt-hook
          (lambda()
              (message "spend %g seconds"
                       (- (time-to-seconds) last-command-start-time))))

;; ignore some history
(setq eshell-histignore  '("\\`\\(ls\\|ll\\|cd\\|clear
\\|hs
\\)\\'"  "\\`\\s-*\\'"))
(setq eshell-input-filter  
      #'(lambda (str)  
	  (let ((regex eshell-histignore))  
	    (not  
	     (catch 'break  
	       (while regex  
		 (if (string-match (pop regex) str)  
		     (throw 'break t))))))))
(setq eshell-hist-ignoredups t)

;; alias
(defalias 'ff 'find-file)
