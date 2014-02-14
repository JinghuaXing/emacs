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
;; (setq gnus-select-method '(nnimap "QMail"
;; 				  (nnimap-address "imap.qq.com")   ; it could also be imap.googlemail.com if that's your server.
;; 				  (nnimap-server-port 143)
;; 				  (nnimap-stream network)))

;; (setq gnus-secondary-select-methods '((nntp "news.gmane.org")))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-auth-credentials '(("sci-mail8.spreadtrum.com" 25
				   "wei.sun" "123456"))
      smtpmail-default-smtp-server "sci-mail8.spreadtrum.com"
      smtpmail-smtp-server "sci-mail8.spreadtrum.com"
      smtpmail-smtp-service 25
      )

(setq gnus-use-nocem t)
;; (add-hook 'mail-citation-hook 'sc-cite-original)
(setq gnus-confirm-mail-reply-to-news t
      message-kill-buffer-on-exit t
      message-elide-ellipsis "[...]\n"
      )

;;排序
(setq gnus-thread-sort-functions
      '(
	gnus-thread-sort-by-most-recent-date
	;; gnus-thread-sort-by-number
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
分机: 589-683
手机: 18630859306
Email:wei.sun@spreadtrum.com
展讯通信(天津)
"
   )
  )
(setq gnus-posting-styles
      '((".*"
	 (address "wei.sun@spreadtrum.com")
	 (name "孙伟")
	 ;; (organization "pld_tj")
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

(setq gnus-uu-user-view-rules
      (list
       '("\\\\.\\(doc\\|xsl\\)$" "soffice %s")
       )
      )
;; (setq message-default-mail-headers "Cc: \n")

(setq gnus-visible-headers "^From:\\|^Subject:\\|^To:\\|^Date:")
(setq gnus-message-archive-group
      '("nnimap+spreadtrum:Sent" "nnimap+spreadtrum:Inbox"))

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
	(gnus-ticked-mark (from 5) (subject 10))
	(gnus-dormant-mark (from 5) (subject 10))
	(gnus-replied-mark (from 2) (subject 4))
	(gnus-forwarded-mark (from 2) (subject 4))
	(gnus-read-mark (from 1) (subject 2))
	
	(gnus-del-mark)
	(gnus-expirable-mark (from -2) (subject -4))
	(gnus-killed-mark (from -1) (subject -2))
	(gnus-kill-file-mark (from -1) (subject -2))
	(gnus-ancient-mark)
	(gnus-low-score-mark)
	(gnus-catchup-mark (from -1) (subject -1))))
(add-hook 'gnus-started-hook '(lambda()
				(gnus-demon-add-handler 'gnus-demon-scan-news 300 1)
				))

(add-hook 'gnus-after-getting-new-news-hook 'sw/gnus-check-mail-1)

(setq my-gnus-new-mail -1)

(defun sw/gnus-check-mail-1 (&rest ignored)
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
      (progn
	(save-window-excursion
	  (save-excursion
	    (when (gnus-alive-p)
	      (set-buffer gnus-group-buffer)
	      (gnus-topic-read-group)
	      (gnus-group-save-newsrc t)
	      ;; (gnus-summary-save-newsrc)
	      )))
	(sw/gnus-check-mail-2)
	))))

(defun sw/gnus-check-mail-2 (&rest ignored)
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
									     (cond ((> my-gnus-new-mail 0)
										    (propertize (format " [M:%d]" my-gnus-new-mail) 'face 'bold))
										   ((< my-gnus-new-mail 0)
										    (propertize " [M:nil]" 'face 'bold))
										   )
									     )))

(define-key gnus-group-mode-map (kbd "q") 'gnus-group-suspend)
(define-key gnus-summary-mode-map (kbd "f") '(lambda()
					       (interactive)
					       (gnus-summary-mail-forward 3)
					       ))
(define-key gnus-summary-mode-map (kbd "S-SPC") 'gnus-summary-prev-page)
(define-key gnus-summary-mode-map (kbd "<delete>") 'gnus-summary-delete-article)
(define-key gnus-summary-mode-map (kbd "o") 'gnus-summary-move-article)
(define-key gnus-summary-mode-map (kbd "//") 'gnus-summary-pop-limit)
(define-key gnus-summary-mode-map (kbd "C-o") nil)
(define-key gnus-summary-mode-map (kbd "r") '(lambda ()
					       (interactive)
					       (if current-prefix-arg
						   (gnus-summary-reply)
						   (gnus-summary-wide-reply))))
(define-key message-mode-map (kbd "C-c C-s") 'message-goto-subject)
(define-key message-mode-map (kbd "C-c C-t") 'message-goto-to)
(define-key message-mode-map (kbd "C-c C-i") 'mml-attach-file)
(define-key message-mode-map (kbd "C-c !") 'message-insert-or-toggle-importance)

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
(setq gnus-summary-make-false-root 'adopt)
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


(add-to-list 'load-path "~/.elisp/bbdb")
(require 'bbdb)
(bbdb-initialize 'gnus 'message)
;;(bbdb-insinuate-gnus)

(setq bbdb-user-mail-names
      (regexp-opt '("wei.sun@spreadtrum.com"
		    )))
(setq bbdb-complete-name-allow-cycling t)
(setq bbdb-mua-pop-up nil)

(setq bbdb/news-auto-create-p 'bbdb-ignore-some-messages-hook)
(setq bbdb-ignore-some-messages-alist
      '(("From" . "Review")))

(defalias 'm 'sw/elscreen-gnus)

(defun sw/elscreen-gnus ()
  (interactive)
  (let ((buffer (get-buffer "*Group*")))
    (if buffer
	(elscreen-find-and-goto-by-buffer (get-buffer "*Group*") 'create)
      (progn
	(elscreen-create)
	(gnus)
	)
      )
    )
  )

(add-hook 'gnus-suspend-gnus-hook 'elscreen-kill)
(add-hook 'gnus-suspend-gnus-hook '(lambda()
				     (gnus-group-save-newsrc t)
				     ))

(setq mm-text-html-renderer 'w3m)

(require 'async)
(require 'smtpmail)

(defun async-smtpmail-send-it ()
  (let ()
    (async-start
     `(lambda ()
        (require 'smtpmail)
        (with-temp-buffer
          (insert ,(buffer-substring-no-properties (point-min) (point-max)))
          ;; Pass in the variable environment for smtpmail
          ,(async-inject-variables "\\`\\(smtpmail\\|\\(user-\\)?mail\\)-")
          (smtpmail-send-it))
	)
     `(lambda (&optional ignore)
        (sw/notify "Delivering message...done")))))

;;(setq message-send-mail-function 'smtpmail-send-it)
(setq send-mail-function 'async-smtpmail-send-it
      message-send-mail-function 'async-smtpmail-send-it)

(defun gnus-user-format-function-A (header)
  "Display @ for message with attachment in summary line.
You need to add `Content-Type' to `nnmail-extra-headers' and
`gnus-extra-headers', see Info node `(gnus)To From Newsgroups'."
  (let ((case-fold-search t)
        (ctype (or (cdr (assq 'Content-Type (mail-header-extra header)))
                   "text/plain"))
        (indicator " "))
    (when (string-match "^multipart/mixed" ctype)
      (setq indicator "@"))
    indicator))

(setq gnus-user-date-format-alist
      '(((gnus-seconds-today) . "%H:%M")
        ((+ 86400 (gnus-seconds-today)) . "Yest, %H:%M")
        (604800 . "%a %H:%M") ;;that's one week
        ((gnus-seconds-month) . "%a %d")
        ((gnus-seconds-year) . "%b %d")
        ((* 30 (gnus-seconds-year)) . "%b %d '%y")
        (t . "")))

(setq nnmail-extra-headers
      '(To Cc Newsgroups Content-Type Thread-Topic Thread-Index))

(add-to-list 'gnus-extra-headers 'Content-Type)
(add-to-list 'gnus-extra-headers 'To)

(setq gnus-face-9  'font-lock-warning-face
      gnus-face-10 'shadow
      gnus-face-11 'vbe:proportional
      gnus-summary-line-format
      (concat
       "%10{%U%R%z%}" " " "%1{%11,11&user-date;%}"
       "%10{│%}"
       "%9{%u&A; %}" "%(%-15,15uB %)"
       "%*"
       " " "%10{%B%}"
       "%s\n"))

(defvar my-message-attachment-regexp "\\(attach\\|附件\\)")
  ;; the function that checks the message
(defun my-message-check-attachment nil
  "Check if there is an attachment in the message if I claim it."
  (save-excursion
    (message-goto-body)
    (when (search-forward-regexp my-message-attachment-regexp nil t nil)
      (message-goto-body)
      (unless (or (search-forward "<#part" nil t nil)
		 (message-y-or-n-p
		  "No attachment. Send the message ?" nil nil))
  	(error "No message sent")))))
(add-hook 'message-send-hook 'my-message-check-attachment)

(setq gnus-gcc-mark-as-read t)

(setq gnus-auto-select-first nil)
(setq gnus-auto-select-subject 'best)
(setq message-wash-forwarded-subjects t)
(setq message-make-forward-subject-function (quote message-forward-subject-fwd))
(add-hook 'message-sent-hook 'gnus-score-followup-thread)

(setq message-citation-line-function 'message-insert-formatted-citation-line)
(setq message-citation-line-format "On %a, %b %d %Y, %f wrote:\n")

(eval-after-load 'nnir
  '(defun nnir-run-imap (query srv &optional groups)
    "Run a search against an IMAP back-end server.
This uses a custom query language parser; see `nnir-imap-make-query' for
details on the language and supported extensions."
    (save-excursion
      (let ((qstring (cdr (assq 'query query)))
	    (server (cadr (gnus-server-to-method srv)))
	    (defs (caddr (gnus-server-to-method srv)))
	    (criteria (or (cdr (assq 'criteria query))
			 (cdr (assoc nnir-imap-default-search-key
				     nnir-imap-search-arguments))))
	    (gnus-inhibit-demon t)
	    (groups (or groups (nnir-get-active srv))))
	(message "Opening server %s" server)
	(apply
	 'vconcat
	 (catch 'found
	   (mapcar
	    (lambda (group)
	      (let (artlist)
		(condition-case ()
		    (when (nnimap-possibly-change-group
			   (gnus-group-short-name group) server)
		      (with-current-buffer (nnimap-buffer)
			(message "Searching %s..." group)
			(let ((arts 0)
			      (result (nnimap-command "UID SEARCH CHARSET UTF-8 %s"
						      (if (string= criteria "")
							  qstring
							(nnir-imap-make-query
							 criteria qstring)))))
			  (mapc
			   (lambda (artnum)
			     (let ((artn (string-to-number artnum)))
			       (when (> artn 0)
				 (push (vector group artn 100)
				       artlist)
				 (when (assq 'shortcut query)
				   (throw 'found (list artlist)))
				 (setq arts (1+ arts)))))
			   (and (car result) (cdr (assoc "SEARCH" (cdr result)))))
			  (message "Searching %s... %d matches" group arts)))
		      (message "Searching %s...done" group))
		  (quit nil))
		(nreverse artlist)))
	    groups))))))
  )
