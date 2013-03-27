(add-to-list 'load-path "~/.elisp")
(add-to-list 'load-path "~/.elisp/org-7.9.1/lisp/")
(add-to-list 'load-path "~/.elisp/org-7.9.1/contrib/lisp/")
(add-to-list 'load-path "~/.elisp/org-7.9.1/contrib/lisp/")
(add-to-list 'load-path "~/.elisp/auctex-11.86")
(add-to-list 'load-path "~/.elisp/org2blog")
(add-to-list 'load-path "~/.elisp/expand-region/")

(add-to-list 'load-path "~/.elisp/cc-mode")
(add-to-list 'load-path "~/.elisp/ruby")
(add-to-list 'load-path "~/.elisp/traverselisp/")
(add-to-list 'load-path "~/.elisp/smartparens/")
(setq custom-file "~/.elisp/dotemacs/custom.el")

(load custom-file)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;;(load-file "~/.elisp/dotemacs/eshell.el")
;; (load-file "~/.elisp/dotemacs/abbrev.el")
(load-file "~/.elisp/dotemacs/w32.el")
(load-file "~/.elisp/dotemacs/buffer.el")
(load-file "~/.elisp/dotemacs/dired.el")
(load-file "~/.elisp/dotemacs/my.el")
(load-file "~/.elisp/dotemacs/c.el")
(load-file "~/.elisp/dotemacs/key.el")
(load-file "~/.elisp/dotemacs/escreen.el")
(load-file "~/.elisp/dotemacs/org.el")
(load-file "~/.elisp/dotemacs/ruby.el")
(load-file "~/.elisp/dotemacs/scala.el")
(load-file "~/.elisp/dotemacs/magit.el")
(load-file "~/.elisp/dotemacs/slime.el")
(load-file "~/.elisp/dotemacs/yasnippet.el")
(load-file "~/.elisp/dotemacs/eim.el")
(load-file "~/.elisp/dotemacs/python.el")
(load-file "~/.elisp/dotemacs/openwith.el")
(load-file "~/.elisp/dotemacs/mark.el")
(load-file "~/.elisp/dotemacs/sdcv.el")
(load-file "~/.elisp/dotemacs/color.el")
(load-file "~/.elisp/dot-mode.el")
(load-file "~/.elisp/dotemacs/w3m.el")
(load-file "~/.elisp/dotemacs/font.el")
(load-file "~/.elisp/dotemacs/tex.el")
(load-file "~/.elisp/dotemacs/ido.el")
(load-file "~/.elisp/dotemacs/file_cache.el")

;; (autoload
;;   'ace-jump-mode
;;   "ace-jump-mode"
;;   "Emacs AceJump minor mode"
;;   t)

(require 'diff-mode-)

(add-hook 'write-file-hooks 'time-stamp)

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
(setq fill-column 80)
(setq major-mode 'text-mode)
(show-paren-mode t)
;; (setq show-paren-style 'mixed)
(setq frame-title-format "%b - Emacs")
(setq user-mail-address "sunwayforever@gmail.com")
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

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

(require 'calendar)
(setq calendar-view-holidays-initially-flag t)
(setq calendar-mark-diary-entries-flag t)
(setq calendar-mark-holidays-flag t)
(setq calendar-week-start-day 1)

;; (setq calendar-latitude +39.92)
;; (setq calendar-longitude +116.46)
;; (setq calendar-location-name "Beijing")

(setq diary-file "~/.elisp/.diary")
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  (flet ((process-list ())) ad-do-it))

(autoload 'ibuffer "ibuffer" "List buffers." t)
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)

(require 'woman)
(setq woman-use-own-frame nil)
(put 'narrow-to-page 'disabled nil)
(delete-selection-mode nil)

;; (desktop-save-mode 1)
(require 'desktop)
(setq desktop-buffers-not-to-save "\\(^\\*\\|^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\)$")

(setq history-length 250)
(setq gdb-many-windows t)
(setq echo-keystrokes 0.1)
(setq show-trailing-whitespace t)

(modify-syntax-entry ?_ "_")

(setq default-line-spacing 0.2)

(require 'tramp)
(add-to-list 'tramp-default-user-alist '("ssh" "build_server" "weisun"))
(setq shell-prompt-pattern ":")

(global-unset-key (kbd "<insert>"))
(unify-8859-on-decoding-mode)

(require 'ediff)
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


(cua-mode t)
(require 'undo-tree)
(global-undo-tree-mode)

;; (require 'org2blog-autoloads)
;; (setq org2blog/wp-blog-alist
;;       '(("wordpress"
;; 	 :url "http://cafebabe.sinaapp.com/xmlrpc.php"
;; 	 :username "sunway"
;; 	 :default-title "Untitled Blog"
;; 	 :tags-as-categories nil)))
;; (setq org2blog/wp-default-categories '("Uncategorized"))

(add-hook 'text-mode-hook 'turn-on-auto-fill)

(require 'uniquify)

(add-hook 'text-mode-hook 'flyspell-mode)

(require 'unicad)

(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(require 'color-moccur)

(require 'midnight)

(require 'htmlize)
(require 'boxquote)

(add-hook 'nxml-mode-hook '(lambda () (auto-fill-mode -1)))

(require 'ace-jump-mode)
(setq ace-jump-mode-move-keys (loop for i from ?a to ?z collect i))

(require 'my-desktop)
(my-desktop-mode t)

(add-hook 'find-file-hook '(lambda()
			     (setq minor-mode-alist nil)
			     ))

(require 'saveplace)
(setq-default save-place t)
(transient-mark-mode t)

(require 'switch-window)

(setq backup-inhibited t)

(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)
(setq ahs-default-range (quote ahs-range-beginning-of-defun))
(require 'popup-ruler)
(defalias 'ruler 'popup-ruler)

(require 'browse-kill-ring)
(global-set-key (kbd "M-y") 'browse-kill-ring)

(autoload 'xmsi-mode "xmsi-math-symbols-input" "Load xmsi minor mode for inputting math (Unicode) symbols." t)
(xmsi-mode 1)
(autoload 'xub-mode "xub-mode" "Load xub-mode for browsing Unicode." t)
(defalias 'unicode-browser 'xub-mode)

(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

(require 'quack)

(global-unset-key (kbd "<C-wheel-up>"))
(global-unset-key (kbd "<C-wheel-down>"))

;; (prefer-coding-system 'gb18030)
(prefer-coding-system 'utf-8-unix)
(setq coding-system-for-read 'utf-8-unix)
(setq coding-system-for-write 'utf-8-unix)

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
			   (local-set-key (kbd "n")   'compilation-next-file)
			   (local-set-key (kbd "p")   'compilation-previous-file)
			   ))


(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(require 'smartparens)

(require 'smartparens-config)
(smartparens-global-mode)
;; (sp-use-smartparens-bindings)


;; (require 'auto-async-byte-compile)
;; (setq auto-async-byte-compile-exclude-files-regexp "/etc/")
;; (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

(require 'deft)
(setq deft-directory "~/.elisp/dotemacs/org")
(setq deft-extension "org")
(setq deft-text-mode 'org-mode)
(global-set-key (kbd "<f12>") 'deft)
