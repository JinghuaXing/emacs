(add-to-list 'load-path "~/.elisp/w3m")
(require 'w3m)

(add-to-list 'load-path "~/.elisp/wanderlust/flim")
(add-to-list 'load-path "~/.elisp/wanderlust/apel/")
(add-to-list 'load-path "~/.elisp/wanderlust/semi/")
(add-to-list 'load-path "~/.elisp/wanderlust/wl/wl")
(add-to-list 'load-path "~/.elisp/wanderlust/wl/elmo")
(add-to-list 'load-path "~/.elisp/wanderlust/wl/utils/")

(autoload 'wl "wl" "Wanderlust" t)
;; (setq wl-init-file "~/.elisp/wanderlust/wl.el")
(setq wl-folders-file "~/.elisp/wanderlust/folders")

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

(require 'w3m)
(require 'mime-w3m)

(setq elmo-imap4-default-server "imap.gmail.com"
      elmo-imap4-default-user "sunwayforever@gmail.com"
      elmo-imap4-default-authenticate-type 'clear
      elmo-imap4-default-port '993
      elmo-imap4-default-stream-type 'ssl

      ;;for non ascii-characters in folder-names
      elmo-imap4-use-modified-utf7 t)

;; SMTP
(setq wl-smtp-connection-type 'starttls
      wl-smtp-posting-port 587
      wl-smtp-authenticate-type "plain"
      wl-smtp-posting-user "sunwayforever"
      wl-smtp-posting-server "smtp.gmail.com"
      wl-local-domain "gmail.com"
      wl-message-id-domain "smtp.gmail.com")

(setq wl-from "sunwei <sunwayforever@gmail.com>"

      ;;all system folders (draft, trash, spam, etc) are placed in the
      ;;[Gmail]-folder, except inbox. "%" means it's an IMAP-folder
      wl-default-folder "%inbox"
      wl-draft-folder   "%[Gmail]/草稿"
      wl-trash-folder   "%[Gmail]/已删除邮件"
      wl-fcc            "%[Gmail]/已发邮件"

      ;; mark sent messages as read (sent messages get sent back to you and
      ;; placed in the folder specified by wl-fcc)
      wl-fcc-force-as-read    t

      ;;for when auto-compleating foldernames
      wl-default-spec "%")

(setq elmo-passwd-alist '(("IMAP:sunwayforever@gmail.com/clear@imap.gmail.com:993" . "bm9wYXNzd29yZA==")))
;; (setq wl-folder-desktop-name "Gmail")

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
