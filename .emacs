(add-to-list 'load-path "~/.elisp") 
(add-to-list 'load-path "~/.elisp/org-7.8.03/lisp/")
(add-to-list 'load-path "~/.elisp/emacs-w3m")
(add-to-list 'load-path "~/.elisp/auctex-11.86")
(add-to-list 'load-path "~/.elisp/org2blog")
(add-to-list 'load-path "~/.elisp/cc-mode")
(add-to-list 'load-path "~/.elisp/magit-1.1.1/")
(add-to-list 'load-path "~/.elisp/eim")
(add-to-list 'load-path "~/.elisp/slime")
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
(load-file "~/.elisp/dotemacs/abbrev.el")
(load-file "~/.elisp/dotemacs/w32.el")
;; (load-file "~/.elisp/dotemacs/dict.el")


(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs AceJump minor mode"
  t)


(require 'diff-mode-)
;;(require 'w3m)
;;(setq w3m-use-cookies t)
(add-hook 'write-file-hooks 'time-stamp)
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
			     ))
(modify-syntax-entry ?_ "_")

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

;; (cua-mode t)
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

(require 'magit)
(require 'magit-topgit)
(add-hook 'magit-mode-hook
	  'magit-topgit-mode)

(require 'mo-git-blame)
(global-set-key (kbd "C-x v b") 'mo-git-blame-current)
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

(require 'align-string)
(require 'htmlize)
(require 'boxquote)
(require 'clipper)

(global-set-key "\C-cci" 'clipper-insert)
(global-set-key "\C-ccc" 'clipper-create)
(global-set-key "\C-ccd" 'clipper-delete)
(defalias 'vc-diff 'vc-ediff)

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

(require 'quick-jump)
(global-set-key (kbd "C-,") 'quick-jump-go-back)
(global-set-key (kbd "C-.") 'quick-jump-push-marker)
(add-hook 
 'flyspell-mode-hook 
 '(lambda ()
    (define-key flyspell-mode-map (kbd "C-.") nil)
    (define-key flyspell-mode-map (kbd "C-,") nil))
 )

(require 'find-file-in-project)
(global-set-key (kbd "C-x f") 'find-file-in-project)

(setq inferior-lisp-program "sbcl") 
(require 'slime)
(slime-setup)
(add-to-list 'auto-mode-alist '("\\.lisp\\'" . slime-mode))
