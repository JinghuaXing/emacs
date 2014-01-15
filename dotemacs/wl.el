(setq wl-summary-width 150)

(add-to-list 'load-path "~/.elisp/wanderlust/flim")
(add-to-list 'load-path "~/.elisp/wanderlust/apel/")
(add-to-list 'load-path "~/.elisp/wanderlust/semi/")
(add-to-list 'load-path "~/.elisp/wanderlust/wl/wl")
(add-to-list 'load-path "~/.elisp/wanderlust/wl/elmo")
(add-to-list 'load-path "~/.elisp/wanderlust/wl/utils/")

(autoload 'wl "wl" "Wanderlust" t)

(setq wl-folders-file "~/.elisp/wanderlust/folders")
(if (executable-find "w3m")
    (progn
      (add-to-list 'load-path "~/.elisp/w3m")
      (require 'w3m)
      (require 'mime-w3m)
      )
  )

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

;; (setq wl-message-ignored-field-list '("^.*:"))
(setq wl-message-ignored-field-list '(
				      "^Content-Transfer-Encoding:"
				      "^Sensitivity:"
				      "^MIME-Version:"
				      "^X-.*:"
				      "^In-Reply-To:"
				      "^Message-ID:"
				      "^Content-Type:"
				      "^Importance:"
				      "^References:"
				      "^Cc:"
				      "^Received:"
				      "^User-Agent:"
				      ))

;; ..but these five
(setq wl-message-visible-field-list
      '("^To:"
	;; "^Cc:"
	"^From:"
	"^Subject:"
	"^Date:"))

(setq wl-message-sort-field-list
      '("^From:"
	"^Subject:"
	"^Date:"
	"^To:"
	;; "^Cc:"
	))

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

(add-hook 'wl-mail-setup-hook 'auto-fill-mode)
;; score
;; (setq wl-summary-expunge-below -500)
(setq wl-summary-important-above 500)

(setq wl-forward-subject-prefix "Fwd: ") 

(setq wl-new-mails 0)

(setq default-mode-line-format (sw/insert-after default-mode-line-format 5 '(:eval
									     (if (> wl-new-mails 0)
										 (propertize (format " [wl:%d] " wl-new-mails) 'face 'bold)
									       )
									     )))
(add-hook 'wl-biff-notify-hook '(lambda ()
				  (sw/notify "new mail")
				  ))

(add-hook 'wl-init-hook 'wl-biff-start)

(setq wl-summary-move-direction-toggle nil)

;; (require 'elmo-search)
;; (elmo-search-register-engine
;;     'mu 'local-file
;;     :prog "/usr/local/bin/mu" ;; or wherever you've installed it
;;     :args '("find" pattern "--fields" "l") :charset 'utf-8)

;; (setq elmo-search-default-engine 'mu)
