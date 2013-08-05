(add-to-list 'load-path "~/.elisp/mew")

(require 'mew)
;;(require 'mew-w3m)

(if (boundp 'read-mail-command)
    (setq read-mail-command 'mew))
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))

(setq mew-config-alist
      '(
	(default
	  (mailbox-type          pop)
	  (pop-server            "pop.qq.com")
	  (name                  "sunway")
	  (user                  "sunwayforever")
	  (pop-user              "sunwayforever")
	  (mail-domain           "qq.com")
	  (pop-auth              pass)
	  (smtp-auth-list         '("LOGIN"))
	  (smtp-user             "sunwayforever")
	  (smtp-server           "smtp.qq.com")
	  )
        ))

(setq mew-pop-size 0)
(setq toolbar-mail-reader 'Mail)
(set-default 'mew-decode-quoted 't)
(setq mew-use-text/html t)
(setq mew-prog-pgp "gpg")
(setq mew-use-cached-passwd t)

(when (boundp 'utf-translate-cjk)
  (setq utf-translate-cjk t)
  (custom-set-variables
   '(utf-translate-cjk t)))
(if (fboundp 'utf-translate-cjk-mode)
    (utf-translate-cjk-mode 1))
