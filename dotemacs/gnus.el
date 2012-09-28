(setq mail-user-agent  'gnus-user-agent)
(setq read-mail-command 'gnus)
(setq user-full-name "sunway")
(setq user-mail-address "sunwayforever@gmail.com")
(setq nnmail-expiry-wait 3)
(setq gnus-use-cache 'passive)
(setq gnus-large-newsgroup nil)
(setq gnus-check-new-newsgroups nil)
(setq gnus-select-method '(nnfolder ""))
(setq mail-sources
      '(
	(file :path "/var/mail/fetchmail")
	))
(setq nnmail-split-methods
      '(("mail.emacs" ".*help-gnu-emacs@gnu.org")
	("mail.mspace" "\\(.*jiangzhi.*\\)\\|\\(.*jiaoli.*\\)\\|\\(.*bergwolf.*\\)\\|\\(.*bjddsu.*\\)\\|\\(.*wwbupt.*\\)\\|\\(.*wangruisi.*\\)")
	("mail.bupt" ".*bupt03405@googlegroups.com")
	("mail.ion" ".*ion-general@lists.berlios.de")
	("mail.misc" "")))
(setq gnus-use-nocem t)
(add-hook 'mail-citation-hook 'sc-cite-original)
(setq gnus-confirm-mail-reply-to-news t
      message-kill-buffer-on-exit t
      message-elide-ellipsis "[...]\n"
      )

;;≈≈–Ú
(setq gnus-thread-sort-functions
      '(
	(not gnus-thread-sort-by-date)
	(not gnus-thread-sort-by-number)
	))

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
;;÷–Œƒ…Ë÷√
(setq gnus-summary-show-article-charset-alist
      '((1 . cn-gb-2312) (2 . big5) (3 . gbk) (4 . utf-8)))
(setq
 gnus-default-charset 'cn-gb-2312       
 gnus-group-name-charset-group-alist '((".*" . cn-gb-2312))
 gnus-newsgroup-ignored-charsets
 '(unknown-8bit x-unknown iso-8859-1 ISO-8859-15 x-gbk GB18030 gbk DEFAULT_CHARSET))

(eval-after-load "mm-decode"
  '(progn
     (add-to-list 'mm-discouraged-alternatives "text/html")
     (add-to-list 'mm-discouraged-alternatives "text/richtext")))

(defun my-fortune-signature ()
  (shell-command-to-string "sig.pl"))
(setq gnus-posting-styles
      '((".*"
	 (name "sunway")
	 (organization "BUPT")
	 (signature my-fortune-signature)
	 )
	))
(add-hook 'gnus-select-group-hook 'gnus-group-set-timestamp)
(setq gnus-group-line-format
      "%M\%S\%p\%P\%5y: %(%-40,40g%) %ud\n")
(defun gnus-user-format-function-d (headers)
  (let ((time (gnus-group-timestamp gnus-tmp-group)))
    (if time
	(format-time-string "%b %d  %H:%M" time)
      "")))
(defadvice message-send (around my-confirm-message-send)
  (if (yes-or-no-p "send it? ")
      ad-do-it))
(ad-activate 'message-send)
(setq gnus-extract-address-components
      'mail-extract-address-components)
(setq gnus-summary-line-format
      "%U%R%z%(%[%-20,20f %]%) %B%s\n")
(setq gnus-uu-user-view-rules
      (list
       '("\\\\.\\(doc\\|xsl\\)$" "soffice %s")
       )
      )
(setq gnus-visible-headers "^From:\\|^Subject:\\|^To:\\|^Date:")
(setq gnus-message-archive-group
      '("sent"))

(require 'bbdb)
(bbdb-initialize 'gnus 'message)
(setq bbdb-user-mail-names
      (regexp-opt '("sunwayforever@gmail.com"
                    )))
(setq bbdb-complete-name-allow-cycling t)
(setq bbdb-use-pop-up nil)

(add-hook 'gnus-summary-mode-hook 'my-setup-hl-line)
(add-hook 'gnus-group-mode-hook 'my-setup-hl-line)
(defun my-setup-hl-line ()
  (hl-line-mode 1)
  )
(gnus-add-configuration '(article (vertical 1.0 (summary .35 point) (article 1.0))))
(setq gnus-check-new-newsgroups nil
      gnus-read-active-file 'some
      gnus-nov-is-evil nil)