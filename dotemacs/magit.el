;; (add-to-list 'load-path "~/.elisp/magit-1.2.0")
(add-to-list 'load-path "~/.elisp/magit")
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

(magit-wip-mode 1)
(global-magit-wip-save-mode 1)

(setq magit-repo-dirs '("~/.elisp"))
