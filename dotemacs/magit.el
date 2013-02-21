(add-to-list 'load-path "~/.elisp/magit/")
(require 'magit)
(require 'magit-topgit)
(require 'magit-wip)
(require 'rebase-mode)
(require 'magit-blame)
(require 'magit-bisect)
(require 'magit-push-remote)
(add-hook 'magit-mode-hook 'turn-on-magit-push-remote)
(add-hook 'magit-mode-hook
	  'magit-topgit-mode)

(global-set-key (kbd "C-x v b") 'magit-blame-mode)

(setq magit-save-some-buffers nil
      magit-process-popup-time 10
      magit-completing-read-function 'magit-ido-completing-read)

(defun magit-status-somedir ()
  (interactive)
  (let ((current-prefix-arg t))
    (magit-status default-directory)))

(global-set-key [(f12)] 'magit-status)

(eval-after-load 'magit
  '(progn
     ;; Don't let magit-status mess up window configurations
     ;; http://whattheemacsd.com/setup-magit.el-01.html
     (defadvice magit-status (around magit-fullscreen activate)
       (window-configuration-to-register :magit-fullscreen)
       ad-do-it
       (delete-other-windows))

     (defun magit-quit-session ()
       "Restores the previous window configuration and kills the magit buffer"
       (interactive)
       (kill-buffer)
       (when (get-register :magit-fullscreen)
         (jump-to-register :magit-fullscreen)))

     (define-key magit-status-mode-map (kbd "q") 'magit-quit-session)))

