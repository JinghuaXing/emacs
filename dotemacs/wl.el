(setq wl-summary-width 150)

(if (executable-find "w3m")
    (progn
      (add-to-list 'load-path "~/.elisp/w3m")
      (require 'w3m)
      )
  )

(add-to-list 'load-path "~/.elisp/wanderlust/flim")
(add-to-list 'load-path "~/.elisp/wanderlust/apel/")
(add-to-list 'load-path "~/.elisp/wanderlust/semi/")
(add-to-list 'load-path "~/.elisp/wanderlust/wl/wl")
(add-to-list 'load-path "~/.elisp/wanderlust/wl/elmo")
(add-to-list 'load-path "~/.elisp/wanderlust/wl/utils/")

(autoload 'wl "wl" "Wanderlust" t)

(setq wl-folders-file "~/.elisp/wanderlust/folders")
(require 'mime-w3m)

(autoload 'wl-user-agent-compose "wl-draft" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

(setq wl-biff-check-folder-list '("%inbox"))

(setq elmo-imap4-default-server "sci-mail8.spreadtrum.com"
      elmo-imap4-default-user "wei.sun@spreadtrum.com"
      elmo-imap4-default-authenticate-type 'clear
      elmo-imap4-default-port '143
      elmo-imap4-default-stream-type nil

      ;;for non ascii-characters in folder-names
      elmo-imap4-use-modified-utf7 t)

;; SMTP
(setq wl-smtp-connection-type nil
      wl-smtp-posting-port 25
      wl-smtp-authenticate-type "login"
      ;; wl-smtp-authenticate-type "plain"
      wl-smtp-posting-user "wei.sun"
      wl-smtp-posting-server "sci-mail8.spreadtrum.com"
      wl-local-domain "spreadtrum.com"
      wl-message-id-domain "smtp.spreadtrum.com"
      )

(setq wl-from "wei.sun <wei.sun@spreadtrum.com>"

      ;;all system folders (draft, trash, spam, etc) are placed in the
      ;;[Gmail]-folder, except inbox. "%" means it's an IMAP-folder
      wl-default-folder "%inbox"
      wl-draft-folder   "+Drafts"
      wl-trash-folder   "%Trash"
      wl-fcc            "%Sent"

      ;; mark sent messages as read (sent messages get sent back to you and
      ;; placed in the folder specified by wl-fcc)
      wl-fcc-force-as-read    t

      ;;for when auto-compleating foldernames
      wl-default-spec "%")
(setq elmo-passwd-alist '(("IMAP:wei.sun@spreadtrum.com/clear@sci-mail8.spreadtrum.com:143" . "MTIzNDU2")))
(setq wl-folder-desktop-name "Spreadtrum")

(setq wl-message-ignored-field-list '("^.*:"))

;; ..but these five
(setq wl-message-visible-field-list
      '("^To:"
	"^Cc:"
	"^From:"
	"^Subject:"
	"^Date:"))

(setq wl-message-sort-field-list
      '("^From:"
	"^Subject:"
	"^Date:"
	"^To:"
	"^Cc:"))

(setq wl-news-news-alist nil)

(eval-after-load "wl-folder.el"
  '(progn
    (define-key wl-folder-mode-map "q"    'wl-folder-suspend)
    (define-key wl-folder-mode-map "z"    'wl-exit)
    )
  )

(setq mime-edit-split-message nil)

(eval-after-load "wl-e21.el"
  '(define-key wl-draft-mode-map (kbd "C-c TAB") 'mime-edit-insert-file)
  )

(defun insert-signature()
  (insert-string "

------
wei.sun(孙伟)
分机: 589-653
手机: 18630859306
Email:wei.sun@spreadtrum.com
展讯通信(天津)"
		 )
  )
(add-hook 'wl-mail-setup-hook
	  '(lambda ()
	     (save-excursion
	       (end-of-buffer)
	       (wl-draft-insert-signature))))

;; score
(setq wl-summary-expunge-below -1000)
(setq wl-summary-important-above 1000)

(setq wl-forward-subject-prefix "Fwd: ") 
