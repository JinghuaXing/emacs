(require 'org-install)
(require 'org-agenda)
(require 'org-export-generic)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-hide-leading-stars t)
(setq org-agenda-include-diary nil)
(setq org-log-done 'time)
(global-set-key (kbd "<f12>") '(lambda()  (interactive) (find-file "~/.elisp/dotemacs/org")))

(defalias 'agenda  'org-agenda)
(require 'remember)
(org-remember-insinuate)
(defalias 'todo 'org-remember)

(setq org-directory "~/.elisp/dotemacs/org/")

(setq org-agenda-files (quote ("~/.elisp/dotemacs/org/gtd")))

(setq org-remember-templates
      '(("Task" ?t "* TODO %?\n  \n  SCHEDULED: %t" "~/.elisp/dotemacs/org/gtd/task.org" "Tasks")
	("Coding" ?c "* TODO %?        :coding:\n  \n  " "~/.elisp/dotemacs/org/gtd/coding.org" "Coding")
	("Borrow" ?b "* TODO %?        :life:\n  \n  " "~/.elisp/dotemacs/org/gtd/borrow.org" "Borrow")
	("Reading" ?r "* TODO %?       :reading:\n  \n  " "~/.elisp/dotemacs/org/gtd/reading.org" "Reading")
	("Enjoy" ?e "* TODO %?\n  \n  " "~/.elisp/dotemacs/org/gtd/enjoy.org" "Enjoy")
	("Project" ?p "* TODO %?        :project:\n  \n  " "~/.elisp/dotemacs/org/gtd/project.org" "Project")
	("Diary" ?d "* DONE %?           :diary:\n  \n  %t" "~/.elisp/dotemacs/org/gtd/diary.org" "Diary")
        ))

(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s)" "WATING(w)"  "|" "DONE(d)" "CANCELLED(c)" "DEFERRED(f)" )
	))
(setq org-use-fast-todo-selection t)
(setq org-refile-use-outline-path t)
(setq org-refile-targets
      '((org-agenda-files . (:maxlevel . 1))
	))
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-todo-ignore-scheduled t)
(setq org-agenda-todo-ignore-deadlines t)
(setq org-agenda-todo-ignore-with-date t)
(setq org-deadline-warning-days 3)
;; (define-key org-mode-map (kbd "C-c a") 'org-toggle-archive-tag)
(define-key org-mode-map (kbd "C-c t") 'org-todo)
;; (define-key org-mode-map (kbd "C-c C-n") 'outline-forward-same-level)
;; (define-key org-mode-map (kbd "C-c C-p") 'outline-backward-same-level)

(define-key org-agenda-mode-map (kbd "C-c C-c") 'org-agenda-set-tags)
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
	     '("" "xeCJK" nil)
	     t
	     )
(add-to-list 'org-export-latex-default-packages-alist
	     "\\setCJKmainfont{SimSun}"
	     t
	     )
;;(setq org-tag-alist '(("java" . ?v) ("android" . ?d) ("joke" . ?j)))
(setq org-completion-use-ido t)

(add-hook 'org-agenda-mode-hook
	  (lambda ()
	    (define-key org-agenda-mode-map " " 'org-agenda-cycle-show)))
