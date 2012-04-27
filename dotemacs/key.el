;;(global-set-key (kbd "C-x b") 'ido-switch-buffer)
;; (require 'breadcrumb)
;; (global-set-key (kbd "S-SPC")         'bc-set)            ;; Shift-SPACE for set bookmark
;; (global-set-key [(meta j)]              'bc-previous)       ;; M-j for jump to previous
;; (global-set-key [(shift meta j)]        'bc-next)           ;; Shift-M-j for jump to next
;; (global-set-key [(meta up)]             'bc-local-previous) ;; M-up-arrow for local previous
;; (global-set-key [(meta down)]           'bc-local-next)     ;; M-down-arrow for local next
;; (global-set-key [(control c)(j)]        'bc-goto-current)   ;; C-c j for jump to current bookmark
;; (global-set-key [(control x)(meta j)]   'bc-list)           ;; C-x M-j for the bookmark menu list

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-g") 'goto-line)

;; (global-set-key (kbd "s-l") '(lambda ()
;; 			       (interactive)
;; 			       (if (get-buffer "*Beagle*")
;; 				   (switch-to-buffer "*Beagle*")
;; 				 )))
;;(global-set-key (kbd "s-.") 'beagle-dired)

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-l") 'recenter)
(global-set-key [(?\M-/)] 'hippie-expand)
(global-set-key (kbd "C-M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-d") 'dired)
(global-set-key (kbd "C-x C-k") 'ido-kill-buffer)
;;(global-set-key [(meta .)] 'lev/find-tag)
;; (global-set-key (kbd "<f11>") 'calendar)
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)
;;(define-key global-map (kbd "C-x C-x") 'toggle-eshell)

(global-set-key (kbd "M-z") 'wy-go-to-char)
;;(global-set-key (kbd "C-SPC") 'toggle-input-method)
;;(global-set-key (kbd "C-\\") 'set-mark-command)

(add-hook 'sql-interactive-mode-hook
	  '(lambda ()
	     (define-key sql-interactive-mode-map (kbd "<up>") 'comint-previous-input)
	     (define-key sql-interactive-mode-map (kbd "<down>") 'comint-next-input)
	     ))

;;; WINDOW SPLITING 
;; (global-set-key (kbd "M-2") 'split-window-vertically)
;; (global-set-key (kbd "M-3") 'split-window-horizontally)
;; (global-set-key (kbd "M-1") 'delete-other-windows)
;; (global-set-key (kbd "M-0") 'delete-window)
;; (global-set-key (kbd "M-o") 'other-window)

;; (global-set-key (kbd "M-n") (lambda () (interactive) (scroll-up 1)))
;; (global-set-key (kbd "M-p") (lambda () (interactive) (scroll-down 1)))
;; (require 'bm)
;; (global-set-key (kbd "<C-M-return>") 'bm-toggle)
;; (global-set-key (kbd "<C-return>")   'bm-next)
;; (global-set-key (kbd "<M-return>") 'bm-previous)

(global-set-key (kbd "M-s k") 'keep-lines)
(global-set-key (kbd "M-s f") 'flush-lines)

(global-set-key (kbd "C-x v t") 'magit-status)
(defalias 'mt 'magit-status)
;;(global-set-key (kbd "<s-return>") 'magit-status)
(defalias 'occur 'moccur)
