(add-to-list 'load-path "~/.elisp")
(add-to-list 'load-path "~/.elisp/org-7.9.1/lisp/")
(add-to-list 'load-path "~/.elisp/org-7.9.1/contrib/lisp/")
(add-to-list 'load-path "~/.elisp/org-7.9.1/contrib/lisp/")
(add-to-list 'load-path "~/.elisp/auctex-11.86")
(add-to-list 'load-path "~/.elisp/org2blog")
(add-to-list 'load-path "~/.elisp/expand-region/")
(add-to-list 'load-path "~/.elisp/color-theme-6.6.0/")
(add-to-list 'load-path "~/.elisp/themes/")
(add-to-list 'load-path "~/.elisp/cc-mode")

(add-to-list 'load-path "~/.elisp/eim")
(add-to-list 'load-path "~/.elisp/slime")
(add-to-list 'load-path "~/.elisp/ruby")
(add-to-list 'load-path "~/.elisp/traverselisp/")
(add-to-list 'load-path "~/.elisp/smartparens/")

(setq custom-file "~/.elisp/dotemacs/custom.el")

(load custom-file)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
;; (load-file "~/.elisp/dotemacs/cedet.el")
(load-file "~/.elisp/dotemacs/w32.el")
(load-file "~/.elisp/dotemacs/buffer.el")
(load-file "~/.elisp/dotemacs/dired.el")
(load-file "~/.elisp/dotemacs/my.el")
(load-file "~/.elisp/dotemacs/c.el")
(load-file "~/.elisp/dotemacs/key.el")
;;(load-file "~/.elisp/dotemacs/eshell.el")
(load-file "~/.elisp/dotemacs/escreen.el")
(load-file "~/.elisp/dotemacs/org.el")
(load-file "~/.elisp/dotemacs/abbrev.el")
(load-file "~/.elisp/dotemacs/ruby.el")
(load-file "~/.elisp/dotemacs/scala.el")
(load-file "~/.elisp/dotemacs/magit.el")

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs AceJump minor mode"
  t)

(require 'diff-mode-)
(if (executable-find "w3m")
    (progn
      (add-to-list 'load-path "~/.elisp/emacs-w3m/")
      (require 'w3m)
      (setq w3m-use-cookies t)
      (setq w3m-use-form t)
      (setq w3m-tab-width 8)
      (setq w3m-use-cookies t)
      (setq w3m-use-toolbar t)
      (setq w3m-use-mule-ucs t)
      (setq w3m-fill-column 120)
      (setq w3m-default-display-inline-image t)
      (setq w3m-default-toggle-inline-images t)
      (setq w3m-home-page "http://www.gogole.com")
      (setq browse-url-browser-function 'w3m-browse-url)
      (setq w3m-view-this-url-new-session-in-background t)
      )
  )

(add-hook 'write-file-hooks 'time-stamp)
(if (string= window-system "x")
     (progn
       (create-fontset-from-fontset-spec
        "-*-terminus-medium-r-normal--16-*-*-*-*-*-fontset-gbk,
         chinese-gb2312:-misc-simsun-medium-r-normal--14-*-*-*-*-*-gbk-0,
         chinese-gbk:-misc-simsun-medium-r-normal--14-*-*-*-*-*-gbk-0,
         chinese-cns11643-5:-misc-simsun-medium-r-normal--16-*-*-*-*-*-gbk-0,
         chinese-cns11643-6:-misc-simsun-medium-r-normal--16-*-*-*-*-*-gbk-0,
         chinese-cns11643-7:-misc-simsun-medium-r-normal--16-*-*-*-*-*-gbk-0" t)
       (setq default-frame-alist
       	    '(
       	      (font . "fontset-gbk")
       	      )
       	    )
       ))

(global-font-lock-mode t)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(server-start)

(setq confirm-kill-emacs 'y-or-n-p)
(setq bookmark-save-flag 1)

(fset 'yes-or-no-p 'y-or-n-p)
(setq delete-auto-save-files t)
(setq inhibit-startup-message t)
(setq column-number-mode t)
(setq mouse-yank-at-point t)
(setq default-fill-column 80)
(setq default-major-mode 'text-mode)
(show-paren-mode t)
(setq show-paren-style 'mixed)
(setq frame-title-format "%b - Emacs")
(setq user-mail-address "sunwayforever@gmail.com")
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(load "auctex.el" nil t t)
(add-to-list 'auto-mode-alist '("\\.bmer\\'" . latex-mode))
;; (load "preview-latex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master t)
(add-hook 'LaTeX-mode-hook
	  '(lambda ()
	     (tex-pdf-mode)
	     (turn-on-reftex)
	     (outline-minor-mode)
	     (turn-on-auto-fill)
	     ;;(flyspell-mode nil)
	     ;;(hide-sublevels 2)
	     (set-buffer-file-coding-system 'utf-8)
	     (LaTeX-item-indent 0)
	     )
	  )
(setq hippie-expand-try-functions-list
      '(
	try-expand-dabbrev
	try-expand-dabbrev-visible
	try-expand-dabbrev-from-kill
	try-expand-dabbrev-all-buffers
	try-expand-line
	try-expand-list
	try-expand-list-all-buffers
	try-expand-line-all-buffers
	try-complete-file-name
	try-complete-file-name-partially
	try-complete-lisp-symbol
	try-complete-lisp-symbol-partially
	try-expand-whole-kill))
(setq adaptive-fill-regexp "[ \t]+\\|[ \t]*\\([0-9]+\\.\\|\\*+\\)[ \t]*")
(setq adaptive-fill-first-line-regexp "^\\* *$")
(custom-reset-variables
 '(mm-inline-override-types nil))

(setq view-calendar-holidays-initially)
(setq mark-diary-entries-in-calendar t)
(setq mark-holidays-in-calendar t)
(setq calendar-week-start-day 1)
(setq calendar-latitude +39.92)
(setq calendar-longitude +116.46)
(setq calendar-location-name "Beijing")

(setq diary-file "~/.elisp/.diary")
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  (flet ((process-list ())) ad-do-it))

(autoload 'ibuffer "ibuffer" "List buffers." t)
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(setq woman-use-own-frame nil)
(put 'narrow-to-page 'disabled nil)
(delete-selection-mode nil)

;; (desktop-save-mode 1)
(setq desktop-buffers-not-to-save "\\(^\\*\\|^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\)$")
(setq history-length 250)
(setq gdb-many-windows t)
(setq echo-keystrokes 0.1)
(setq show-trailing-whitespace t)
(require 'ido)
(ido-mode t)
(ido-everywhere t)
(setq ido-max-directory-size 100000)
(setq ido-enable-regexp t)
(setq ido-enable-flex-matching t)
(setq ido-ignore-buffers (quote ("\\` \\|\\(^\\*\\)\\|\\(TAGS.*\\)")))
(add-hook 'ido-setup-hook '(lambda ()
			     (interactive)
			     (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
			     (define-key ido-completion-map (kbd "C-p") 'ido-prev-match)
			     (define-key ido-completion-map (kbd "SPC") 'ido-restrict-to-matches)
			     ))
(modify-syntax-entry ?_ "_")

;; allow for color prompt in shell
(ansi-color-for-comint-mode-on)
;; (set-face-foreground 'font-lock-comment-face "#95917E")
;; (set-face-foreground 'font-lock-comment-face "gold")
;; (set-face-foreground 'font-lock-string-face "#61ce3c")
;; (set-face-foreground 'font-lock-keyword-face "#f8dd2d")
;; (set-face-foreground 'font-lock-function-name-face "#e3611f")
;; (set-face-foreground 'font-lock-variable-name-face "#98fbff")
;; (set-face-foreground 'font-lock-type-face "#A6E22E")
;; (set-face-foreground 'region "#272822")
;; (set-face-background 'region "#66D9EF")
;; (set-face-foreground 'font-lock-constant-face "#66d9ef")
;; (set-background-color "#0b0f23")
;; (set-foreground-color "#f8f8f2")
;; (setq-default cursor-type 'box)
;; (set-cursor-color "red")
(setq default-line-spacing 0.2)

(require 'tramp)
(add-to-list 'tramp-default-user-alist '("ssh" "matlab" "sunway"))
(setq shell-prompt-pattern ":")

(global-unset-key (kbd "<insert>"))
(unify-8859-on-decoding-mode)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq enable-recursive-minibuffers t)
;;(setq next-line-add-newlines t)
(when (and (locate-library "linum") (facep 'fringe))
  (setq linum-format (propertize "%5d " 'face 'fringe)))
(setq ediff-split-window-function 'split-window-horizontally)

(require 'etags-select)
(global-set-key "\M-." 'etags-select-find-tag)
(defun set-tags-table (f)
  (interactive "fSet tag file: ")
  (setq tags-table-list nil)
  (setq tags-file-name nil)
  (visit-tags-table f)
  )
(defalias 'stable 'set-tags-table)

(setq sentence-end "\\([¡££¡£¿]\\|¡­¡­\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]
*")

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(defun py-outline-level ()
  (let (buffer-invisibility-spec)
    (save-excursion
      (skip-chars-forward "\t ")
      (current-column))))

(defun my-python-mode-hook()
  (interactive)
  (c-subword-mode)
  (setq c-subword-mode t)
  (c-toggle-auto-state -1)
  (c-toggle-hungry-state t)
  (setq outline-regexp "[ \t]*\\(def\\|class\\) ")
  (setq outline-level 'py-outline-level)
  (outline-minor-mode t)
  )
(add-hook 'python-mode-hook 'my-python-mode-hook)


(cua-mode t)
(require 'undo-tree)
(global-undo-tree-mode)

(require 'org2blog-autoloads)
(setq org2blog/wp-blog-alist
      '(("wordpress"
	 :url "http://cafebabe.sinaapp.com/xmlrpc.php"
	 :username "sunway"
	 :default-title "Untitled Blog"
	 :tags-as-categories nil)))
(setq org2blog/wp-default-categories '("Uncategorized"))

(add-hook 'text-mode-hook 'turn-on-auto-fill)

(require 'uniquify)

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'text-mode-hook '(lambda () (abbrev-mode t)))
(add-hook 'emacs-lisp-mode-hook '(lambda () (abbrev-mode t)))

(require 'unicad)

(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(require 'color-moccur)

(require 'midnight)

(require 'htmlize)
(require 'boxquote)

(add-hook 'nxml-mode-hook '(lambda () (auto-fill-mode -1)))

(setq ace-jump-mode-move-keys (loop for i from ?a to ?z collect i))

(require 'my-desktop)
(my-desktop-mode t)

(add-hook 'find-file-hook '(lambda()
			     (setq minor-mode-alist nil)
			     ))

(require 'saveplace)
(setq-default save-place t)
(transient-mark-mode t)

;;(require 'quick-jump)
;;(global-set-key (kbd "C-,") 'quick-jump-go-back)
;;(global-set-key (kbd "C-.") 'quick-jump-push-marker)
;; (add-hook
;;  'flyspell-mode-hook
;;  '(lambda ()
;;     (define-key flyspell-mode-map (kbd "C-.") nil)
;;     (define-key flyspell-mode-map (kbd "C-,") nil))
;;  )

;; (require 'find-file-in-project)
;; (global-set-key (kbd "C-x f") 'find-file-in-project)

(setq inferior-lisp-program "sbcl")
(require 'slime)
(slime-setup '(slime-fancy slime-asdf slime-banner))
(setq slime-complete-symbol*-fancy t)
(setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)

(add-to-list 'auto-mode-alist '("\\.lisp\\'" . lisp-mode))
(defun lisp-indent-or-complete (&optional arg)
  (interactive "p")
  (if (or (looking-back "^\\s-*") (bolp))
      (call-interactively 'lisp-indent-line)
      (call-interactively 'slime-indent-and-complete-symbol)))
(eval-after-load "lisp-mode"
  '(progn
     (define-key lisp-mode-map (kbd "TAB") 'lisp-indent-or-complete)))

(add-hook 'lisp-mode-hook '(lambda () (flyspell-mode -1)))

;; (require 'paredit)
;; (add-hook 'paredit-mode (lambda ()
;; 			  (local-unset-key (kbd <M-down>))
;; 			  ))
;; (add-hook 'lisp-mode-hook '(lambda() (paredit-mode t)))
;; (add-hook 'scheme-mode-hook '(lambda() (paredit-mode t)))
;; (add-hook 'emacs-lisp-mode-hook '(lambda() (paredit-mode t)))

(require 'filecache)
(defun file-cache-ido-find-file (file)
  "Using ido, interactively open file from file cache'.
First select a file, matched using ido-switch-buffer against the contents
in `file-cache-alist'. If the file exist in more than one
directory, select directory. Lastly the file is opened."
  (interactive (list (file-cache-ido-read "File: "
                                          (mapcar
                                           (lambda (x)
                                             (car x))
                                           file-cache-alist))))
  (let* ((record (assoc file file-cache-alist)))
    (find-file
     (expand-file-name
      file
      (if (= (length record) 2)
          (car (cdr record))
        (file-cache-ido-read
         (format "Find %s in dir: " file) (cdr record)))))))

;; file-cache
(defun file-cache-add-this-file ()
  (and buffer-file-name
       (file-exists-p buffer-file-name)
       (file-cache-add-file buffer-file-name)))
(add-hook 'kill-buffer-hook 'file-cache-add-this-file)

(defalias 'ffca 'file-cache-add-directory-recursively)
(defalias 'ffcc 'file-cache-clear-cache)

(defun file-cache-ido-read (prompt choices)
  (let ((ido-make-buffer-list-hook
	 (lambda ()
	   (setq ido-temp-list choices))))
    (ido-read-buffer prompt)))

(global-set-key (kbd "C-x C-r") 'file-cache-ido-find-file)
(defalias 'fcc 'file-cache-clear-cache)
(defalias 'fca 'file-cache-add-directory-recursively)

(require 'switch-window)

(setq backup-inhibited t)

(require 'tracker-dired)
(global-set-key (kbd "C-x C-t") 'tracker-dired)

(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)
(setq ahs-default-range (quote ahs-range-beginning-of-defun))
(require 'popup-ruler)
(defalias 'ruler 'popup-ruler)
(require 'sdcv)
(setq sdcv-dictionary-simple-list   
      '("朗道英汉字典5.0"
        "朗道汉英字典5.0"
        ))
(setq sdcv-dictionary-complete-list
      '("朗道英汉字典5.0"
        "朗道汉英字典5.0"
        ))
(global-set-key (kbd "M-?") 'sdcv-search-input+)

(require 'idutils)

(load "~/.elisp/git-wip/git-wip.el")

(eval-after-load 'rcirc
  '(add-to-list 'rcirc-markup-text-functions 'rcirc-smileys))

(defun rcirc-smileys (&rest ignore)
  "Run smiley-buffer on the buffer
but add a temporary space at the end to ensure matches of smiley
regular expressions."
  (goto-char (point-max))
  (insert " ")
  (smiley-buffer)
  (delete-char -1))

(eval-after-load 'rcirc '(require 'rcirc-notify))

(load-file "~/.elisp/dot-mode.el")
(require 'browse-kill-ring)
(global-set-key (kbd "M-y") 'browse-kill-ring)

(add-to-list 'load-path "~/.elisp/back-button/")
(require 'back-button)
(back-button-mode 1)
(global-set-key (kbd "M-n") 'back-button-local-forward)
(global-set-key (kbd "M-p") 'back-button-local-backward)
(global-set-key (kbd "M-N") 'back-button-global-forward)
(global-set-key (kbd "M-P") 'back-button-global-backward)

(load-file "~/.elisp/dotemacs/pulse.el")
(require 'auto-mark)
(global-auto-mark-mode 1)
(setq auto-mark-command-class-alist (quote (
					    (goto-line . jump)
					    (isearch-forward-regexp . jump)
					    (isearch-backward-regexp . jump)
					    (ace-jump-mode . jump)
					    (idomenu . jump)
					    (beginning-of-buffer . jump)
					    (c-beginning-of-defun . jump)
					    (c-end-of-defun . jump)
					    (end-of-buffer . jump)
					    (ahs-moccur-hl . jump)
					    )))

(autoload 'xmsi-mode "xmsi-math-symbols-input" "Load xmsi minor mode for inputting math (Unicode) symbols." t)
(xmsi-mode 1)
(autoload 'xub-mode "xub-mode" "Load xub-mode for browsing Unicode." t)
(defalias 'unicode-browser 'xub-mode)

(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

(require 'quack)

;;(add-to-list 'load-path "~/.elisp/auto-complete-1.3.1/")
;;(require 'auto-complete-config)
;;(ac-config-default)
;;(ac-flyspell-workaround)
;;(require 'ac-slime)
;;(add-hook 'slime-mode-hook 'set-up-slime-ac)
;;(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
;;(eval-after-load "auto-complete"
;;  '(add-to-list 'ac-modes 'slime-repl-mode))

(require 'hippie-expand-slime)
(add-hook 'slime-mode-hook 'set-up-slime-hippie-expand)
(add-hook 'slime-repl-mode-hook 'set-up-slime-hippie-expand)

;;(require 'smex)
;;(smex-initialize)
;;(global-set-key (kbd "M-x") 'smex)
;;(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
;;(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(global-unset-key (kbd "<C-wheel-up>"))
(global-unset-key (kbd "<C-wheel-down>"))

;; (prefer-coding-system 'gb18030)
(prefer-coding-system 'utf-8-unix)
(setq coding-system-for-read 'utf-8-unix)
(setq coding-system-for-write 'utf-8-unix)

;; (add-to-list 'load-path "~/.elisp/sunrise-commander/")
;; (require 'sunrise-commander)
;; (add-to-list 'auto-mode-alist '("\\.srvm\\'" . sr-virtual-mode))
;; (global-set-key (kbd "C-x C-d") 'find-file)
;; (global-set-key (kbd "C-x C-x") 'sunrise)
;; (global-set-key (kbd "C-x C-j") '(lambda ()
;; 				   (interactive)
;; 				   (cond
;; 				    ((eq major-mode 'sr-mode)
;; 				     (sr-dired-prev-subdir))
;; 				    ((eq major-mode 'sr-virtual-mode)
;; 				     (sr-process-kill)
;; 				     (sr-goto-dir default-directory)
;; 				     )
;; 				    (t (sunrise-cd))
;; 				    )
;; 				   ))
;; (define-key sr-mode-map (kbd "C-s") 'sr-fuzzy-narrow)
;; (define-key sr-mode-map (kbd "/") 'sr-fuzzy-narrow)
;; (require 'sunrise-x-popviewer)
;; (require 'sunrise-x-loop)
;; (require 'sunrise-x-modeline)
;; (define-key sr-mode-map "i" nil)
;; (define-key sr-mode-map "r" 'sr-editable-pane)
;; (define-key sr-mode-map "f" 'sr-find-name)
;; (define-key sr-mode-map "F" 'sr-find-grep)
;; (define-key sr-mode-map "B" 'sr-flatten-branch)
;; (define-key sr-mode-map "\M-f" nil)
;; (define-key sr-mode-map "T" 'dired-tar-pack-unpack)

(require 'openwith)
(openwith-mode t)
(when (eq system-type 'gnu/linux)
  (setq openwith-associations
        '(("\\.pdf$" "evince" (file)) ("\\.mp3$" "mplayer" (file) )
          ("\\.mov\\|\\.RM$\\|\\.RMVB$\\|\\.avi$\\|\\.AVI$\\|\\.flv$\\|\\.mp4\\|\\.mkv$\\|\\.rmvb$" "mplayer" (file) )
          ("\\.jpe?g$\\|\\.png$\\|\\.bmp\\|\\.gif$" "display" (file))
          ("\\.CHM$\\|\\.chm$" "chmsee"  (file) )
	  ("\\.xlsx?$\\|\\.XLSX?$" "soffice"  (file) )
          )
        )
  )
(when (eq system-type 'windows-nt)
  (setq openwith-associations
        '(("\\.pdf$" "open" (file)) ("\\.mp3$" "open" (file) )
          ("\\.mov\\|\\.RM$\\|\\.RMVB$\\|\\.avi$\\|\\.AVI$\\|\\.flv$\\|\\.mp4\\|\\.mkv$\\|\\.rmvb$" "open" (file) )
          ("\\.jpe?g$\\|\\.png$\\|\\.bmp\\|\\.gif$" "open" (file))
          ("\\.CHM$\\|\\.chm$" "open"  (file) )
          )
        )
  )

;;(require 'autopair)
;;(autopair-global-mode)
;; (setq autopair-blink t)

(require 'quickrun)
(global-set-key (kbd "<f5>") 'quickrun)
;; (setq url-proxy-services '(("no_proxy" . "work\\.com")
;;                            ("http" . "127.0.0.1:5865")))
;; (setq w3m-command-arguments
;;       (nconc w3m-command-arguments
;; 	     '("-o" "http_proxy=http://127.0.0.1:5866")))

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))
(when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings))

(require 'bm)
(global-set-key (kbd "<f2>") 'bm-previous)
(global-set-key (kbd "<C-f2>")   'bm-toggle)

(when (fboundp 'winner-mode)
      (winner-mode 1))
(windmove-default-keybindings)

(setq-default ispell-program-name "aspell")
(ispell-change-dictionary "american" t)

(require 'eim-extra)
(autoload 'eim-use-package "eim" "Another emacs input method")
(setq eim-use-tooltip nil)
(setq eim-punc-translate-p nil)         ; use English punctuation
(defun my-eim-py-activate-function ()
  (add-hook 'eim-active-hook
	    (lambda ()
	      (let ((map (eim-mode-map)))
		(define-key eim-mode-map "-" 'eim-previous-page)
		(define-key eim-mode-map "=" 'eim-next-page)))))
(register-input-method
 "eim-wb" "euc-cn" 'eim-use-package
 "五笔" "EIM Chinese Wubi Input Method" "wb.txt"
   'my-eim-py-activate-function)
(set-input-method "eim-wb")             ; use Pinyin input method
(setq activate-input-method t)          ; active input method
(toggle-input-method nil)          ; default is turn off
(global-set-key ";" 'eim-insert-ascii)

(require 'smooth-scroll)
(smooth-scroll-mode t)
(global-set-key (kbd "C-S-n")  'scroll-up-1)
(global-set-key (kbd "C-S-p")  'scroll-down-1)

(require 'hl-line)
(require 'imenu-tree)

(require 'ack)
(add-hook 'ack-mode-hook (lambda ()
			   (local-set-key (kbd "q") (lambda ()
						      (interactive)
						      (bury-buffer)
						      (delete-window)
						      ))
			   ))

;; (add-to-list 'load-path "~/.elisp/evil")
;; (require 'evil)
;; (evil-mode 1)
;; (setq evil-default-state (quote emacs))
;; (define-key evil-normal-state-map (kbd "C-]") 'etags-select-find-tag)
;; (define-key evil-normal-state-map (kbd "M-.") 'etags-select-find-tag)
;; (require 'evil-leader)
;; (evil-leader/set-key
;;   "f" 'ack
;;   )

(require 'color-theme)
(require 'color-theme-solarized)
(color-theme-solarized-dark)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(require 'smartparens-config)
(smartparens-global-mode)
;; (sp-use-smartparens-bindings)
