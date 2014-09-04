(require 'deft)
(setq deft-directory "~/.elisp/dotemacs/org/note")
(define-key deft-mode-map (kbd "C-x k") 'quit-window)
(require 'org-install)
(require 'org-agenda)
;; (require 'org-export-generic)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-hide-leading-stars t)
(setq org-agenda-include-diary nil)
(setq org-log-done 'note)

(defalias 'agenda  'org-agenda)
(require 'remember)
;; (org-remember-insinuate)
(defalias 'todo 'org-remember)

(setq org-directory "~/.elisp/dotemacs/org/note/cafebabe")

(setq org-agenda-files (quote ("~/.elisp/dotemacs/org/gtd") ))

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "|" "CANCELLED(c@/!)"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              )))

(setq org-use-fast-todo-selection t)
(setq org-refile-use-outline-path t)
(setq org-refile-targets
      '((org-agenda-files . (:maxlevel . 2))
	("~/.elisp/dotemacs/org/android.org" :maxlevel . 3)
	))
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-todo-ignore-scheduled t)
(setq org-agenda-todo-ignore-deadlines t)
 (setq org-agenda-todo-ignore-with-date t)
(setq org-deadline-warning-days 3)
;; (define-key org-mode-map (kbd "C-c a") 'org-toggle-archive-tag)
(define-key org-mode-map (kbd "C-c p") 'org-property-action)
(define-key org-mode-map (kbd "<s-return>") 'org-beamer-select-environment)
(define-key org-mode-map (kbd "C-c t") 'org-todo)
(define-key org-mode-map (kbd "C-c C-x C-a") 'org-toggle-archive-tag)
;; (define-key org-mode-map (kbd "C-c C-n") 'outline-forward-same-level)
;; (define-key org-mode-map (kbd "C-c C-p") 'outline-backward-same-level)

(define-key org-agenda-mode-map (kbd "C-c C-c") 'org-agenda-set-tags)
(define-key org-agenda-mode-map (kbd "C-c /") 'org-agenda-filter-by-tag)
(define-key org-agenda-mode-map (kbd "/") 'org-agenda-filter-by-tag)
(setq org-agenda-sorting-strategy '((agenda time-up priority-down category-keep)
				    (todo todo-state-down priority-down category-keep)
				    (tags priority-down category-keep)
				    (search category-keep)))
(require 'ox-latex)
(require 'ox-beamer)
(require 'ox-md)
(setq org-ditaa-jar-path "~/.elisp/ditaa0_9.jar")
(setq org-plantuml-jar-path "~/.elisp/plantuml.jar")
(setq org-src-fontify-natively t)

;; (setq org-latex-to-pdf-process 
;;       '("xelatex -interaction nonstopmode %f"
;; 	"xelatex -interaction nonstopmode %f"))


(add-to-list 'org-latex-default-packages-alist
	     '("" "xeCJK" nil)
	     t
	     )
(add-to-list 'org-latex-default-packages-alist
	     "\\setCJKmainfont{SimSun}
\\setmainfont{FreeSerif}"
	     t
	     )

;;(setq org-tag-alist '(("java" . ?v) ("android" . ?d) ("joke" . ?j)))
(setq org-completion-use-ido t)

(add-hook 'org-agenda-mode-hook
	  (lambda ()
	    (define-key org-agenda-mode-map " " 'org-agenda-cycle-show)))

;; (setq org-babel-default-header-args '((:session . "none")
;; 				      (:results . "output replace")
;; 				      (:exports . "code")
;; 				      (:cache . "no")
;; 				      (:noweb . "no")
;; 				      (:hlines . "no")
;; 				      (:tangle . "no")
;; 				      (:padnewline . "yes")))

(require 'org-crypt)
(org-crypt-use-before-save-magic)
(add-hook 'org-mode-hook
   (lambda ()
     (org-decrypt-entries)))
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; (setq org-crypt-key "wei.sun")
;; (setq org-crypt-key nil)
;; (setq auto-save-default nil)

;; (org-babel-do-load-languages
;;  (quote org-babel-load-languages)
;;  (quote (
;; 	 (emacs-lisp . t)
;;          (dot . t)
;;          (ditaa . t)
;;          (R . t)
;;          (python . t)
;;          (ruby . t)
;;          (gnuplot . t)
;;          (clojure . t)
;;          (sh . t)
;;          (ledger . t)
;;          (org . t)
;;          (plantuml . t)
;;          (latex . t))))

(add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))
(add-to-list 'org-src-lang-modes (quote ("dot" . dot)))

(setq org-capture-templates
      (quote (("w" "work" entry (file "~/.elisp/dotemacs/org/gtd/work.org")
               "* TODO %?  :work:\n%T\n\n")
	      ("l" "life" entry (file "~/.elisp/dotemacs/org/gtd/life.org")
               "* TODO %? :life:\n%U\n\n")
              ("j" "joke" entry (file "~/.elisp/dotemacs/org/joke.org")
               "* %? :joke:\n%U\n\n")
	      ("n" "note" entry (file "~/.elisp/dotemacs/org/note.org")
               "* %? :note:\n%U\n\n")
	      ("a" "appt" entry (file "~/.elisp/dotemacs/org/gtd/appt.org")
	       "* %?\nDEADLINE: %T\n\n")
	      ("m" "appt" entry (file "~/.elisp/dotemacs/org/gtd/appt.org")
	       "* %a%?\nDEADLINE: %T\n\n")
              ("h" "life habit" entry (file "~/.elisp/dotemacs/org/gtd/life.org")
               "* TODO %? :life:habit:\n%U\n\nSCHEDULED: <%<%Y-%m-%d %a .+1d/2d>> \n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: TODO\n:END:\n"))))

(setq org-agenda-start-with-log-mode t)

;; Set to the location of your Org files on your local system
(setq org-directory "~/.elisp/dotemacs/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/.elisp/dotemacs/org/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")

(require 'ox-html)
(require 'ox-publish)
(setq org-publish-project-alist
      '(
	("cafebabe"
	 :base-directory "~/.elisp/dotemacs/org/note/cafebabe"
	 :base-extension "org"
	 :publishing-directory "~/.github.pages/cafebabe"
	 :recursive t
	 :publishing-function org-html-publish-to-html
	 :headline-levels 4             ; Just the default for this project.
	 :auto-preamble t
	 :auto-sitemap t
	 :sitemap-sort-folders nil    
	 )
	))

(add-hook 'after-init-hook 'org-agenda-list)

(setq org-agenda-include-diary t)

(setq org-html-style-default "<link rel=\"stylesheet\" type=\"text/css\" href=\"/stylesheets/main.css\" media=\"screen\" />")

(require 'org-gnus)

(add-hook 'org-src-mode-hook '(lambda() (auto-fill-mode -1)))

(require 'appt)
(defun my-appt-display (min-to-app new-time msg)
  (shell-command (concat "notify-send -u critical" " '" msg "'")))
(setq appt-time-msg-list nil
      appt-display-mode-line nil
      appt-display-format 'window
      appt-disp-window-function (function my-appt-display)
      appt-message-warning-time 15
      appt-display-interval 5)
(org-agenda-to-appt)

(defadvice  org-agenda-redo (after org-agenda-redo-add-appts)
  "Pressing `r' on the agenda will also add appointments."
  (progn 
    (setq appt-time-msg-list nil)
    (org-agenda-to-appt)))

(add-hook 'org-capture-after-finalize-hook '(lambda()
					      (org-agenda-to-appt)
					      ))
(ad-activate 'org-agenda-redo)
(run-at-time "24:01" 3600 'org-agenda-to-appt)
(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt)
(appt-activate 1)
