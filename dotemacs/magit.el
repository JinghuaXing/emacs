(add-to-list 'load-path "~/.elisp/magit-1.2.0")
;; (add-to-list 'load-path "~/.elisp/magit")
(add-to-list 'load-path "~/.elisp/git-modes/")
(require 'git-rebase-mode)
(require 'git-commit-mode)
(require 'magit)
(require 'magit-svn)
(require 'magit-topgit)
(require 'magit-wip)
(require 'magit-blame)

;; (add-hook 'magit-mode-hook 'turn-on-magit-svn)
;; (add-hook 'magit-mode-hook
;; 	  'magit-topgit-mode)


(defun diff-hl-update-each-buffer ()
  (interactive)
  (mapc (lambda (buffer)
          (condition-case nil
              (with-current-buffer buffer
                (diff-hl-update))
            (buffer-read-only nil)))
        (buffer-list)))
(defadvice magit-update-vc-modeline (after my-magit-update-vc-modeline activate)
  (progn (diff-hl-update-each-buffer)))

(magit-wip-mode 1)
(global-magit-wip-save-mode 1)


(setq magit-repo-dirs '("~/.elisp"))
