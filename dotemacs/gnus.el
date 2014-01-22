(setq mail-user-agent  'gnus-user-agent)
(setq read-mail-command 'gnus)
(setq user-full-name "wei.sun")
(setq user-mail-address "wei.sun@spreadtrum.com")

(setq gnus-use-cache 'passive)
(setq gnus-large-newsgroup nil)
(setq gnus-check-new-newsgroups nil)

(setq gnus-select-method '(nnimap "spreadtrum"
				  (nnimap-address "sci-mail8.spreadtrum.com")   ; it could also be imap.googlemail.com if that's your server.
				  (nnimap-server-port 143)
				  (nnimap-stream network)))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-auth-credentials '(("sci-mail8.spreadtrum.com" 25
				   "wei.sun" "123456"))
      smtpmail-default-smtp-server "sci-mail8.spreadtrum.com"
      smtpmail-smtp-server "sci-mail8.spreadtrum.com"
      smtpmail-smtp-service 25
      )

(setq gnus-use-nocem t)
(add-hook 'mail-citation-hook 'sc-cite-original)
(setq gnus-confirm-mail-reply-to-news t
      message-kill-buffer-on-exit t
      message-elide-ellipsis "[...]\n"
      )

;;排序
(setq gnus-thread-sort-functions
      '(
	(not gnus-thread-sort-by-date)
	(not gnus-thread-sort-by-number)
	))

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
;;中文设置
(setq gnus-summary-show-article-charset-alist
      '((1 . cn-gb-2312) (2 . big5) (3 . gbk) (4 . utf-8)))
;; (setq
;;  gnus-default-charset 'cn-gb-2312       
;;  gnus-group-name-charset-group-alist '((".*" . cn-gb-2312))
;;  gnus-newsgroup-ignored-charsets
;;  '(unknown-8bit x-unknown iso-8859-1 ISO-8859-15 x-gbk GB18030 gbk DEFAULT_CHARSET))

(eval-after-load "mm-decode"
  '(progn
     (add-to-list 'mm-discouraged-alternatives "text/html")
     (add-to-list 'mm-discouraged-alternatives "text/richtext")))

(defun my-fortune-signature ()
  (concat
   (shell-command-to-string "fortune")
   "
wei.sun(孙伟)
分机: 589-653
手机: 18630859306
Email:wei.sun@spreadtrum.com
展讯通信(天津)
"
   )
  )
(setq gnus-posting-styles
      '((".*"
	 (name "wei.sun")
	 (organization "pld_tj")
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

;; (defadvice message-send (around my-confirm-message-send)
;;   (if (yes-or-no-p "send it? ")
;;       ad-do-it))

;; (ad-activate 'message-send)

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
      '("nnimap+spreadtrum:Sent"))

;; (setq nnmail-expiry-wait-function
;;       (lambda (group)
;; 	(cond ((string= group "todo")
;; 	       1)
;; 	      ((string= group "archives")
;; 	       1)
;; 	      (t
;; 	       1))))

(setq nnmail-expiry-target "nnimap+spreadtrum:Trash")

(add-hook 'gnus-summary-mode-hook 'my-setup-hl-line)
(add-hook 'gnus-group-mode-hook 'my-setup-hl-line)
(defun my-setup-hl-line ()
  (hl-line-mode 1)
  )
(gnus-add-configuration '(article (vertical 1.0 (summary .35 point) (article 1.0))))
(setq gnus-check-new-newsgroups nil
      gnus-read-active-file 'some
      gnus-nov-is-evil nil)

(setq gnus-use-adaptive-scoring '(line))
(setq gnus-default-adaptive-score-alist
      '((gnus-unread-mark)
	(gnus-ticked-mark (from 4))
	(gnus-dormant-mark (from 5))
	(gnus-del-mark (from -4) (subject -1))
	(gnus-read-mark (from 4) (subject 2))
	(gnus-expirable-mark (from -1) (subject -1))
	(gnus-killed-mark (from -1) (subject -3))
	(gnus-kill-file-mark)
	(gnus-ancient-mark)
	(gnus-low-score-mark)
	(gnus-catchup-mark (from -1) (subject -1))))
(add-hook 'gnus-started-hook '(lambda()
				(gnus-demon-add-handler 'gnus-demon-scan-news 3 1)
				))

(add-hook 'gnus-after-getting-new-news-hook 'sw/gnus-check-mail)

(defun sw/gnus-check-mail (&rest ignored)
  (interactive)
  (let ((all-unread 0))
    (mapc '(lambda (g)
	     (let* ((group (car g))
		    (unread (gnus-group-unread group)))
	       (when (and (numberp unread) (> unread 0) (string= group "Inbox"))
		 (incf all-unread unread)
		 )
	       ))
	  gnus-newsrc-alist)
    (setq my-gnus-new-mail all-unread)
    (unless (= all-unread 0)
      (sw/notify (format "%d new mail" all-unread)))
    )
  )


(setq default-mode-line-format (sw/insert-after default-mode-line-format 5 '(:eval
									     (if (> my-gnus-new-mail 0)
										 (propertize (format " [mail:%d]" my-gnus-new-mail) 'face 'bold)
									     ))))

(define-key gnus-group-mode-map (kbd "q") 'gnus-group-suspend)
(define-key gnus-summary-mode-map (kbd "S-SPC") 'gnus-summary-prev-page)
(define-key gnus-summary-mode-map (kbd "<delete>") 'gnus-summary-delete-article)

(copy-face 'font-lock-variable-name-face 'gnus-face-6)
(setq gnus-face-6 'gnus-face-6)
(copy-face 'font-lock-constant-face 'gnus-face-7)
(setq gnus-face-7 'gnus-face-7)
(copy-face 'gnus-face-7 'gnus-summary-normal-unread)
(copy-face 'font-lock-constant-face 'gnus-face-8)
(set-face-foreground 'gnus-face-8 "gray50")
(setq gnus-face-8 'gnus-face-8)
(copy-face 'font-lock-constant-face 'gnus-face-9)
(set-face-foreground 'gnus-face-9 "gray70")
(setq gnus-face-9 'gnus-face-9)
(setq gnus-summary-make-false-root 'dummy)
;; (setq gnus-summary-make-false-root-always nil)
(setq gnus-summary-dummy-line-format "    %8{│%}   %(%8{│%}                       %7{│%}%) %6{□%}  %S\n"
	gnus-summary-line-format "%8{%4k│%}%9{%U%R%z%}%8{│%}%*%(%-23,23f%)%7{│%} %6{%B%} %s\n"
	gnus-sum-thread-tree-indent " "
	gnus-sum-thread-tree-root "■ "
	gnus-sum-thread-tree-false-root "□ "
	gnus-sum-thread-tree-single-indent "▣ "
	gnus-sum-thread-tree-leaf-with-other "├─▶ "
	gnus-sum-thread-tree-vertical "│"
	gnus-sum-thread-tree-single-leaf "└─▶ ")
