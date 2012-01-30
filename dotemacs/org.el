(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key (kbd "C-c o l") 'org-store-link)
(global-set-key (kbd "C-c o a") 'org-agenda)
(setq org-hide-leading-stars t)
(setq org-agenda-include-diary nil)
(setq org-log-done 'time)
;;(setq org-todo-keywords '((type "学习" "生活" "游戏" "|" "完成")))
(require 'remember)
(org-remember-insinuate)
(setq org-directory "~/.elisp/dotemacs/org/")
(define-key global-map "\C-cor" 'org-remember)
(setq org-agenda-files (quote ("~/.elisp/dotemacs/org/")))
;; (setq org-remember-templates
;;       '(("Todo" ?t "* TODO %?\n  %i\n  %a \n  SCHEDULED: %^t" "~/org/main.org" "Tasks")
;;         ))
(setq org-todo-keywords
      '((sequence "TODO(t)" "DOING(g)" "DONE(d)" "|"  "PUBLISHED(p)")
	))
(setq org-use-fast-todo-selection t)
(setq org-refile-use-outline-path t)
(setq org-refile-targets
      '((nil . (:maxlevel . 2))
       ))
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
;; (setq org-agenda-todo-ignore-scheduled t)
;; (setq org-agenda-todo-ignore-deadlines t)
;; (setq org-agenda-todo-ignore-with-date t)
(setq org-deadline-warning-days 3)
;; (define-key org-mode-map (kbd "C-c a") 'org-toggle-archive-tag)
(define-key org-mode-map (kbd "C-c t") 'org-todo)
;; (define-key org-mode-map (kbd "C-c C-n") 'outline-forward-same-level)
;; (define-key org-mode-map (kbd "C-c C-p") 'outline-backward-same-level)
(add-hook 'org-mode-hook (lambda ()
			   (interactive)
			   (flyspell-mode)
			   (org2blog/wp-mode)
			  ))

(setq org-agenda-sorting-strategy '((agenda time-up priority-down category-keep)
 (todo todo-state-down priority-down category-keep)
 (tags priority-down category-keep)
 (search category-keep)))
(require 'org-latex)
(setq org-ditaa-jar-path "~/.elisp/ditaa0_9.jar")
(setq org-src-fontify-natively t)

(setq org-latex-to-pdf-process 
  '("xelatex -interaction nonstopmode %f"
     "xelatex -interaction nonstopmode %f"))


(add-to-list 'org-export-latex-default-packages-alist
	     '("slantfont, boldfont, CJKtextspaces, CJKmathspaces" "xeCJK" nil)
	     t
	     )
(add-to-list 'org-export-latex-default-packages-alist
	     "\\setCJKmainfont{SimSun}"
	     t
	     )
