(add-to-list 'load-path "~/.elisp") 
(add-to-list 'load-path "~/.elisp/org-mode/lisp")
(add-to-list 'load-path "~/.elisp/emacs-w3m")
(add-to-list 'load-path "~/.elisp/auctex-11.86")
(add-to-list 'load-path "~/.elisp/auto-complete-1.3.1/")
(add-to-list 'load-path "~/.elisp/yasnippet")
(add-to-list 'load-path "~/.elisp/org2blog")
(add-to-list 'load-path "~/.elisp/cc-mode")
(add-to-list 'load-path "~/.elisp/magit-1.1.1/")
;; (add-to-list 'load-path "~/.elisp/ajc-java-complete-git/")

(setq custom-file "~/.elisp/dotemacs/custom.el")

(load custom-file)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(load-file "~/.elisp/dotemacs/buffer.el")
(load-file "~/.elisp/dotemacs/dired.el")
(load-file "~/.elisp/dotemacs/my.el")
(load-file "~/.elisp/dotemacs/c.el")
(load-file "~/.elisp/dotemacs/key.el")
(load-file "~/.elisp/dotemacs/eshell.el")
(load-file "~/.elisp/dotemacs/org.el")
(load-file "~/.elisp/sourcepair.el")
;; (load-file "~/.elisp/dotemacs/abbrev.el")
;; (load-file "~/.elisp/cedet-1.0/common/cedet.el")
;; (semantic-load-enable-minimum-features)
;; (load-file "~/.elisp/dotemacs/emms.el")

;; (semantic-load-enable-excessive-code-helpers)
;; (global-semantic-decoration-mode nil)
;; (global-semantic-idle-completions-mode nil)

;; (load "jde")
;;(load-file "~/.elisp/dotemacs/tabbar.el")
;; (load-file "~/.elisp/dotemacs/anything.el")
(add-to-list 'load-path "~/.elisp/ace-jump-mode.el/")

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.elisp/auto-complete-1.3.1/dict")
(ac-config-default)
(ac-flyspell-workaround)
(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
		       (if (and (not (minibufferp (current-buffer)))
				(not (eq major-mode 'term-mode))
				)
			   (auto-complete-mode 1))
		       ))
(real-global-auto-complete-mode t)
(define-key ac-completing-map "\t" 'nil)
(define-key ac-completing-map [tab] 'ac-complete)
(define-key ac-completing-map "<return>" 'nil)

;; (require 'ajc-java-complete-config)
;; ;; (add-hook 'jde-mode-hook (lambda () (ajc-java-complete-mode t)))
;; (add-hook 'java-mode-hook (lambda () (ajc-java-complete-mode t)))

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs AceJump minor mode"
  t)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(require 'diff-mode-)
(require 'w3m)
;;(setq w3m-use-cookies t)
(add-hook 'write-file-hooks 'time-stamp)
;; (if (eq emacs-major-version 23)
   (if window-system
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
 ;; )
;
;; (if (string= (getenv "HOSTNAME") "sunway-dorm")
;;     (setq fontsize 13)
;;   (setq fontsize 13)
;;   )
;; (if (eq emacs-major-version 23)
;;    (if window-system
;; 	(progn
;; 	  (set-default-font (concat "consolas-" (number-to-string fontsize)))
;; 	  ;; (set-fontset-font (frame-parameter nil 'font)
;; 	  ;; 		    'han '("Microsoft YaHei" . "unicode-bmp"))
;; 	  ;; (set-fontset-font (frame-parameter nil 'font)
;; 	  ;; 		    'cjk-misc '("Microsoft Yahei" . "unicode-bmp"))
;; 	  ;; (set-fontset-font (frame-parameter nil 'font)
;; 	  ;; 		    'bopomofo '("Microsoft Yahei" . "unicode-bmp"))
;; 	  ;; (set-fontset-font (frame-parameter nil 'font)
;; 	  ;; 		    'gb18030 '("Microsoft Yahei". "unicode-bmp"))
;; 	  ))
;;  )
;
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
(if window-system (mouse-avoidance-mode 'animate))
(setq default-fill-column 80)
(setq default-major-mode 'text-mode)
(show-paren-mode t)
(setq show-paren-style 'mixed)
(setq frame-title-format "%b - Emacs")
;;(display-time)
(setq user-mail-address "sunwayforever@gmail.com")
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(load "auctex.el" nil t t)
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
	     (hide-sublevels 2)
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

;;(require 'cal-china-x)
(setq view-calendar-holidays-initially)
(setq mark-diary-entries-in-calendar t)
(setq mark-holidays-in-calendar t)
(setq calendar-week-start-day 1)
(setq calendar-latitude +39.92)
(setq calendar-longitude +116.46)
(setq calendar-location-name "Beijing")

(setq diary-file "~/.diary")
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  (flet ((process-list ())) ad-do-it))

(autoload 'ibuffer "ibuffer" "List buffers." t)
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(setq woman-use-own-frame nil)
(put 'narrow-to-page 'disabled nil)
(delete-selection-mode nil)

(desktop-save-mode 1)
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
			     ))
(modify-syntax-entry ?_ "_")
(setq transient-mark-mode nil)

;;---------------------------------------------------------------------
;; APPEARANCE
;; color-theme inspired by "blackboard" on textmate
;;---------------------------------------------------------------------

;; allow for color prompt in shell
(ansi-color-for-comint-mode-on)
(set-face-foreground 'font-lock-comment-face "#95917E")
(set-face-foreground 'font-lock-comment-face "gold")
(set-face-foreground 'font-lock-string-face "#61ce3c")
(set-face-foreground 'font-lock-keyword-face "#f8dd2d")
(set-face-foreground 'font-lock-function-name-face "#e3611f")
(set-face-foreground 'font-lock-variable-name-face "#98fbff")
(set-face-foreground 'font-lock-type-face "#A6E22E")
(set-face-foreground 'region "#272822")
(set-face-background 'region "#66D9EF")
(set-face-foreground 'font-lock-constant-face "#66d9ef")
(set-background-color "#0b0f23")
(set-foreground-color "#f8f8f2")
(setq-default cursor-type 'box)
(set-cursor-color "red")
(setq default-line-spacing 0.2)
(require 'htmlize)
(require 'tramp)
(add-to-list 'tramp-default-user-alist '("ssh" "solaris" "sunway_bupt"))
(add-to-list 'tramp-default-user-alist '("ssh" "matlab" "sunway"))

(global-unset-key (kbd "<insert>"))
(unify-8859-on-decoding-mode)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq enable-recursive-minibuffers t)
;;(setq next-line-add-newlines t)
(when (and (locate-library "linum") (facep 'fringe))
  (setq linum-format (propertize "%5d " 'face 'fringe)))
(setq ediff-split-window-function 'split-window-horizontally)

(require 'etags-select)
(global-set-key "\M-?" 'etags-select-find-tag-at-point)
(global-set-key "\M-." 'etags-select-find-tag)
;;(require 'xcscope)
;;(add-hook 'sh-mode-hook 'abbrev-mode)

(setq sentence-end "\\([¡££¡£¿]\\|¡­¡­\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]
*")					;½ûÖ¹ÖÐÎÄ±êµã³öÏÖÔÚÐÐÊ×

(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.elisp/yasnippet/snippets/")

;; python
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
;; (defun load-ropemacs ()
;;   "Load pymacs and ropemacs"
;;   (interactive)
;;   (setenv "PYMACS_PYTHON" "python2.5")
;;   (require 'pymacs)
;;   (autoload 'pymacs-load "pymacs" nil t)
;;   (autoload 'pymacs-eval "pymacs" nil t)
;;   (autoload 'pymacs-apply "pymacs")
;;   (autoload 'pymacs-call "pymacs")
;;   (autoload 'pymacs-exec "pymacs" nil t)
;;   (pymacs-load "ropemacs" "rope-")
;;   (local-set-key [(meta ?/)] 'rope-code-assist)
;;   (setq rope-confirm-saving 'nil)
;;   )

;(add-hook 'python-mode-hook 'load-ropemacs)

(defun my-python-mode-hook()
  (interactive)
  (c-subword-mode)
  (setq c-subword-mode t)
  (c-toggle-auto-state -1)
  (c-toggle-hungry-state t)
  )
(add-hook 'python-mode-hook 'my-python-mode-hook)


(add-hook 'python-mode-hook 'my-python-hook)
; this gets called by outline to deteremine the level. Just use the length of the whitespace
(defun py-outline-level ()
  (let (buffer-invisibility-spec)
    (save-excursion
      (skip-chars-forward "\t ")
      (current-column))))
; this get called after python mode is enabled

(defun my-python-hook ()
  (setq outline-regexp "[ \t]*\\(def\\|class\\) ")
  (setq outline-level 'py-outline-level)
  (outline-minor-mode t)
  ;; (hide-body)
)

;; (require 'bookmark+)


(add-to-list 'load-path "~/.elisp/eim")
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

;; (require 'breadcrumb)
;; (global-set-key (kbd "S-SPC")         'bc-set)
;; (global-set-key [(meta j)]              'bc-previous)	    
;; (global-set-key [(shift meta j)]        'bc-next)	    
;; (global-set-key [(meta up)]             'bc-local-previous) 
;; (global-set-key [(meta down)]           'bc-local-next)	    
;; (global-set-key [(control c)(j)]        'bc-goto-current)   
;; (global-set-key [(control x)(meta j)]   'bc-list)	    

;; (global-set-key [(control f2)]          'bc-previous)
;; (global-set-key [(f2)]                  'bc-set)
;; (global-set-key [(shift f2)]            'bc-next)
;; (global-set-key [(meta f2)]             'bc-list)

(cua-mode t)

(require 'undo-tree)
(global-undo-tree-mode)


;; (load-file "~/.elisp/dotemacs/escreen.el")

;; (add-to-list 'load-path "~/.elisp/slime-2011-09-21/") 
;; (setq inferior-lisp-program "/usr/bin/sbcl")
;; (require 'slime)
;; (slime-setup)

;; (require 'ac-slime)
;; (add-hook 'slime-mode-hook 'set-up-slime-ac)

;; (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
;; (eval-after-load "auto-complete"
;;   '(add-to-list 'ac-modes 'slime-repl-mode))


(require 'org2blog-autoloads)
(setq org2blog/wp-blog-alist
      '(("wordpress"
	 :url "http://cafebabe.sinaapp.com/xmlrpc.php"
	 :username "sunway"
	 :default-title "Untitled Blog"
	 :tags-as-categories nil)))
(setq org2blog/wp-default-categories '("Uncategorized"))

(add-hook 'text-mode-hook 'turn-on-auto-fill)
;; (require 'git)
(require 'magit)

(require 'uniquify)
;; (autoload 'enable-paredit-mode "paredit"
;;   "Turn on pseudo-structural editing of Lisp code."
;;   t)

;; (add-hook 'slime-mode-hook 'enable-paredit-mode)
;; (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'text-mode-hook 'flyspell-mode)

(require 'unicad)

(add-to-list 'load-path "~/.elisp/anything-config/")
(require 'anything-config)

(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(require 'bm)
(global-set-key (kbd "<C-f2>") 'bm-next)
(global-set-key (kbd "<f2>") (lambda ()
			       (interactive)
			       (bm-toggle)
			       (bm-save)
			       ))
(global-set-key (kbd "<S-f2>") 'bm-previous)
(global-set-key (kbd "<s-f2>") 'bm-show-all)
(require 'color-moccur)

(require 'midnight)
(require 'beagle-dired)