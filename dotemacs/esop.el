(defvar sop_automp_threshold 70 "threshold of buffer percentage to auto start mplayer")
(defvar sop_automp_p t "whether autostart mplayer")
(defvar sop_mp_threshold 50 "threshold of buffer percentage allowed to start mplayer and mencoder")

(setq sop_process_p nil)   ;;whether sop are running,for sop-wget
(setq sop_connected_p nil) ;;whether sp-sc is connected 
(setq sop_mp_p nil)	   ;;whether mplayer is auto playing
(setq sop_perc 0)	   ;;percentage of sp-sc buffer
(setq sop_mplayer_p "stopped")
(setq sop_recoding_p "stopped")
(setq channel_num_list nil)
(setq channel_name nil)

(defface channel-1-face
  '((((class color) (background dark))
     (:family "helvetica" :bold t :foreground "orange"))
    (((class color) (background light))
     (:family "helvetica" :bold t :foreground "blue")))
  "Face for immortal news items."
  :group 'esop-faces)

(defface esop-group-face
  '((((class color) (background dark))
     (:family "helvetica" :bold t :height 1.3 :foreground "misty rose"))
    (((class color) (background light))
     (:family "helvetica" :bold t :height 1.3 :foreground "black")))
  "Face for group  items."
  :group 'esop-faces)

(defun sop()
  "parse xml and gen the sopcast buffer with the channels"
  (interactive)
  (unless sop_process_p
    (start-process-shell-command "sop_process_wget" nil "wget http://channel.sopcast.com/gchlxml -O /tmp/sop.xml && cp /tmp/sop.xml /home/sunway/.sop.xml")
    )
  (switch-to-buffer (get-buffer-create "*sopcast*"))
  (add-hook 'kill-buffer-hook
	    (lambda()
	      (when (string= (buffer-name) "*sopcast*")
		(sop-exit)
		(when (get-process "sop_process_wget")
		  (delete-process (get-process "sop_process_wget"))
		  )
		(setq sop_process_p nil)
		)
	      )
  	    )
  (hl-line-mode t)
  (unless sop_process_p 
    (setq mode-line-format
	  (list "Stopped!"
		))
    (force-mode-line-update)
    )
  (when sop_process_p (toggle-read-only))
  (erase-buffer)
  (setq sop_process_p t)
  (let* (
	 node-list group_list sop_address
	 group channel_list
	 curr_channel node_name channel_name peer_num

	 )
    (setq node-list (xml-parse-file "/home/sunway/.sop.xml"))
    (setq group_list (xml-get-children (car node-list) 'group))
    (local-set-key (kbd "RET") 'sop-play)
    (local-set-key (kbd "x") 'sop-exit)
    (local-set-key (kbd "m") 'sop-mp)
    (local-set-key (kbd "Q") 'sop-quit)
    (local-set-key (kbd "s") 'sop-sort)
    (local-set-key (kbd "r") 'sop-record)
    (local-set-key (kbd "R") 'sop-record-stop)
    (local-set-key (kbd "q") (lambda () (interactive) (switch-to-buffer (other-buffer))))
    (local-set-key (kbd "g") 'sop)
    (local-set-key (kbd "TAB") 'sop-next-group)
    (local-set-key (kbd "<C-tab>") 'sop-previous-group)
    (local-set-key (kbd "n") 'forward-line)
    (local-set-key (kbd "p") 'previous-line)
    (local-set-key (kbd "a") 'sop-bookmark-add)
    (local-set-key (kbd "v") 'sop-bookmark-list)

    ;;remove groups with blank name from group_list
    (let (group_tmp group_name_tmp group_list_tmp)
      (while group_list
	(setq group_tmp (car group_list))
	(setq group_name_tmp (xml-get-attribute group_tmp 'en))
	(unless (string= group_name_tmp "")
	  (push group_tmp group_list_tmp)
	  )
	(setq group_list (cdr group_list))
	)
      (setq group_list (reverse group_list_tmp))
      )
    (while group_list
      (setq group (car group_list))      
      (setq group_name 	(xml-get-attribute group 'en))
      ;;       (when (string= group_name "")
      ;; 	(setq group_name  "空组名")
      ;; 	)
      (let (begin end)
	(insert (concat "* "group_name)) 
	(beginning-of-line)
	(setq begin (point))
	(end-of-line)
	(setq end (point))
	(put-text-property  begin end  'face  'esop-group-face) ;;group names have different face
	(insert "\n")
	)
      (setq channel_list (xml-get-children group 'channel))
      (push (length channel_list) channel_num_list)
      (while channel_list
	(setq curr_channel (car channel_list))
	(setq node_name (car (xml-get-children curr_channel 'name)))
	(setq channel_name (nth 2 node_name))
	(setq node_uri (car (xml-get-children curr_channel 'sop_address)))
	(setq node_uri_item (car (xml-get-children node_uri 'item)))
	(setq sop_address (nth 2 node_uri_item))
	;;get peer num
	(setq peer_num (nth 2 (car (xml-get-children curr_channel 'user_count))))
	(insert (concat "  " channel_name "      " peer_num))
	
	;;add uri and face to channel_name
	(let* (begin end)
	  (beginning-of-line)
	  (setq begin (point))
	  (end-of-line)
	  (setq end (point))
	  (add-text-properties begin end (list 'uri sop_address))
	  (add-text-properties begin end (list 'peer peer_num))
	  (add-text-properties begin end (list 'channel_name channel_name))
	  (when (>  (string-to-number peer_num) 13)
	    (put-text-property  begin end  'face  'channel-1-face)
	    )
	  )
	(insert "\n")
	(setq channel_list (cdr channel_list))
	)
      (setq group_list (cdr group_list))
      )
    (toggle-read-only )
    (beginning-of-buffer)
    )
  )
(defun sop-play()
  "sh sp-sc uri "
  (interactive)
  (beginning-of-line)
  (let* (sop_addr cmd)
    (setq sop_addr  (get-text-property (point) 'uri))
    (when (get-process "sop_process_spsc") ;;only one sp-sc is allowed to run
      (sop-exit))
    (setq cmd (concat "sp-sc "
		      (shell-quote-argument sop_addr)
		      " 3908 8908"))
					;    (setq cmd "ls")
    (start-process-shell-command "sop_process_spsc" nil cmd)
    (setq channel_name (get-text-property (point) 'channel_name))
    (set-process-filter (get-process "sop_process_spsc") 'sop-output-filter)
    (set-process-sentinel (get-process "sop_process_spsc") 'spsc-quit-sentinel)
    )
  )
(defun sop-exit()
  "kill sp-sc and stop mplayer"
  (interactive)
  (when (get-process "sop_process_spsc")
    (delete-process (get-process "sop_process_spsc"))
    )
  (when (get-process "sop_process_mp")
    (delete-process (get-process "sop_process_mp"))
    )
  (sop-record-stop)
  (setq sop_connected_p nil)
  (setq sop_mp_p nil)
  (setq sop_mplayer_p "stopped")
  (setq mode-line-format
	(list "Stopped"
	      ))
  (force-mode-line-update)
  (force-mode-line-update)
  (setq sop_perc 0)
  (message "sop process killed")
  )
(defun sop-quit()
  "sp-sc uri and start mplayer"
  (interactive)
  (sop-exit)
  (when (get-process "sop_process_wget")
    (delete-process (get-process "sop_process_wget"))
    )
  (setq sop_process_p nil)
  (kill-buffer-and-window)
  )


(defun sop-mp()
  "sp-sc uri and start mplayer"
  (interactive)
  (unless (get-process "sop_process_mp")
    (when (> (string-to-number sop_perc) sop_mp_threshold)
      (let* (cmd)
	(setq cmd "mplayer  http://localhost:8908/tv.asf")
	(start-process-shell-command "sop_process_mp" nil cmd)
	(setq sop_mp_p t)
	(setq sop_mplayer_p "playing")
	(set-process-sentinel (get-process "sop_process_mp") 'mp-quit-sentinel)
	(message cmd)
	)
      )
    )
  )

(defun sop-record(file)
  "record"
  ;;mencoder -quiet http://localhost:8908/tv.asf  -ovc copy -lavcopts vcodec=mpeg4:vpass=1 -oac copy -o 1.av

  (interactive "FRec to:")
  (unless (get-process "sop_process_rec")
    (when (> (string-to-number sop_perc) sop_mp_threshold)
      (let* (cmd)
	(unless (get-process "sop_process_rec")
	  (setq cmd (concat "mencoder -quiet http://localhost:8908/tv.asf  -ovc copy -lavcopts vcodec=mpeg4:vpass=1 -oac copy -o " file))

	  (start-process-shell-command "sop_process_rec" nil cmd)
	  (setq sop_recoding_p "recording")
	  (setq mode-line-format
		(list "Channel: "channel_name
		      " Buffer: "sop_perc
		      " Play:"sop_mplayer_p 
		      " Rec:"sop_recoding_p
		      ))
	  (force-mode-line-update)
	  )
	)
      )
    )
  )
(defun sop-record-stop()
  (interactive)
  (setq sop_recoding_p "stopped")
  (when (get-process "sop_process_rec")
    (delete-process (get-process "sop_process_rec"))
    (setq mode-line-format
	  (list "Channel: "channel_name
		" Buffer: "sop_perc
		" Play:"sop_mplayer_p 
		" Rec:"sop_recoding_p
		))
    (force-mode-line-update)
    (message "recording stopped")
    )
  )
(defun sop-sort()
  "sort every group by peer num"
  (interactive)
  (toggle-read-only )
  (setq channel_num_list (reverse channel_num_list))
  (setq channel_num_list_bak channel_num_list)
  (let (beg end)
    (save-excursion
      (beginning-of-buffer)
      (while channel_num_list
	(forward-line)
	(setq beg (point))
	(forward-line (car channel_num_list) )
	(setq end (point))
	(sort-regexp-numeric-fields t ".* +\\([0-9]+\\)$" "\\1" beg end)
	(setq channel_num_list (cdr channel_num_list))
	)
      )
    )
  (toggle-read-only)
  )

(defun sop-next-group ()
  "jump to next group"
  (interactive)
  (forward-char)
  (search-forward-regexp "^\\*.*" nil t nil) 
  (beginning-of-line)
  )
(defun sop-previous-group ()
  "jump to next group"
  (interactive)
  (backward-char)
  (search-backward-regexp "^\\*.*" nil t nil)
  (beginning-of-line)
  )
  
					;(start-process-shell-command "ls" nil "ls")
(defun sop-output-filter (proc string)
  "filter the percentage from sop output"
  (when   (string-match "nblockAvailable=\\([0-9]+\\)" string)
    (setq sop_perc (match-string 1 string))
    (when (and (and (>  (string-to-number sop_perc) sop_automp_threshold) (not sop_mp_p)) sop_automp_p)
      (sop-mp)
      )
    (setq sop_connected_p t)
    )
  (set-buffer "*sopcast*")
  (setq mode-line-format
	(list "Channel: "channel_name
	      " Buffer: "sop_perc
	      " Play:"sop_mplayer_p 
	      " Rec:"sop_recoding_p
	      ))
  ;;when mplayer is already playing, stop the filter to reduce CPU usage
  (when (string= sop_mplayer_p "playing") 
    (set-process-filter (get-process "sop_process_spsc") nil)
    )
  )
(defun mp-quit-sentinel(process event)
  "sentinel for mplayer quit"
  (setq sop_mplayer_p "stopped")
  ;;when mplayer quit, set the filter again
  (set-process-filter (get-process "sop_process_spsc") 'sop-output-filter)
  (message "mplayer quit")
  )
(defun spsc-quit-sentinel(process event)
  "sentinel for mplayer quit"
  (sop-exit)
  (message "sp-sc exit abnormally!")
  )

;;TODO:检测重复的channel
(defun sop-bookmark-add(name)
  "add current channel to bookmark"
  (interactive "sName:")
  (let (channel_name uri)
    (setq channel_name (get-text-property (point) 'channel_name))
    (setq uri (get-text-property (point) 'uri))
    (set-buffer (find-file-noselect "/home/sunway/.sop_bmk.xml" nil nil nil))
    (beginning-of-buffer)
    (if (search-forward uri nil t)
	(message "Channel already added!")
      (progn
	(end-of-buffer)
	(forward-line -3)
	(end-of-line)
	(newline)
	(insert "<channel><name en=\"test\">")
	(if (string= name "")
	    (insert channel_name)
	  (insert name)
	  )
	(insert "</name><user_count>0</user_count><sop_address><item>")
	(insert uri)
	(insert "</item></sop_address></channel>")
	(save-buffer)
	)
      )
    )
  (kill-buffer (current-buffer))
  )
(defun sop-bookmark-del()
  "del current channel from bookmark"
  (interactive)
  (let (item)
    (setq item (+ (line-number-at-pos) 1))
    (unless (= item 2)
      (switch-to-buffer (find-file-noselect "/home/sunway/.sop_bmk.xml" nil nil nil))
      (forward-line item)
      (kill-line)
      (kill-line)
      (save-buffer)
      (kill-buffer (current-buffer))
      (set-buffer "*sopcast_bmk*")
      (toggle-read-only)
      (sop-bookmark-list)
      )
    )
  )
(defun sop-bookmark-list()
  "list bookmark"
  (interactive)
  (switch-to-buffer (get-buffer-create "*sopcast_bmk*"))
  (erase-buffer)
  (hl-line-mode t)
  (let* (
	 node-list group_list sop_address
	 group channel_list
	 curr_channel node_name channel_name peer_num
	 )
    (setq node-list (xml-parse-file "/home/sunway/.sop_bmk.xml"))
    (setq group_list (xml-get-children (car node-list) 'group))
    (local-set-key (kbd "RET") (lambda () (interactive) (sop-play) (kill-buffer (current-buffer))))
    (local-set-key (kbd "q") (lambda () (interactive) (kill-buffer (current-buffer))))
    (local-set-key (kbd "v") (lambda () (interactive) (kill-buffer (current-buffer))))
    (local-set-key (kbd "n") 'forward-line)
    (local-set-key (kbd "p") 'previous-line)
    (local-set-key (kbd "d") 'sop-bookmark-del)

    ;;remove groups with blank name from group_list
    (let (group_tmp group_name_tmp group_list_tmp)
      (while group_list
	(setq group_tmp (car group_list))
	(setq group_name_tmp (xml-get-attribute group_tmp 'en))
	(unless (string= group_name_tmp "")
	  (push group_tmp group_list_tmp)
	  )
	(setq group_list (cdr group_list))
	)
      (setq group_list (reverse group_list_tmp))
      )
    (while group_list
      (setq group (car group_list))      
      (setq group_name 	(xml-get-attribute group 'en))
      ;;       (when (string= group_name "")
      ;; 	(setq group_name  "空组名")
      ;; 	)
      (let (begin end)
	(insert (concat "* "group_name)) 
	(beginning-of-line)
	(setq begin (point))
	(end-of-line)
	(setq end (point))
	(put-text-property  begin end  'face  'esop-group-face) ;;group names have different face
	)
      (setq channel_list (xml-get-children group 'channel))
      (or (= (length channel_list) 0) (insert "\n"))
      (push (length channel_list) channel_num_list)
      (while channel_list
	(setq curr_channel (car channel_list))
	(setq node_name (car (xml-get-children curr_channel 'name)))
	(setq channel_name (nth 2 node_name))
	(setq node_uri (car (xml-get-children curr_channel 'sop_address)))
	(setq node_uri_item (car (xml-get-children node_uri 'item)))
	(setq sop_address (nth 2 node_uri_item))
	;;get peer num
	(setq peer_num (nth 2 (car (xml-get-children curr_channel 'user_count))))
	(insert (concat "  " channel_name "      " peer_num))
	
	;;add uri and face to channel_name
	(let* (begin end)
	  (beginning-of-line)
	  (setq begin (point))
	  (end-of-line)
	  (setq end (point))
	  (add-text-properties begin end (list 'uri sop_address))
	  (add-text-properties begin end (list 'peer peer_num))
	  (add-text-properties begin end (list 'channel_name channel_name))
	  (when (>  (string-to-number peer_num) 13)
	    (put-text-property  begin end  'face  'channel-1-face)
	    )
	  )
	(or (< (length channel_list) 2)	(insert "\n"))
	(setq channel_list (cdr channel_list))
	)
      (setq group_list (cdr group_list))
      )
    (toggle-read-only)
    )
  )


(defun sort-regexp-numeric-fields (reverse record-regexp key-regexp beg end)
  "sort numerical regexpx"
  (interactive "P\nsRegexp specifying records to sort: \n\
sRegexp specifying key within record: \nr")
  (cond ((or (equal key-regexp "") (equal key-regexp "\\&"))
	 (setq key-regexp 0))
	((string-match "\\`\\\\[1-9]\\'" key-regexp)
	 (setq key-regexp (- (aref key-regexp 1) ?0))))
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (let (sort-regexp-record-end
	    (sort-regexp-fields-regexp record-regexp))
	(re-search-forward sort-regexp-fields-regexp nil t)
	(setq sort-regexp-record-end (point))
	(goto-char (match-beginning 0))
	(sort-subr reverse
		   'sort-regexp-fields-next-record
		   (function (lambda ()
			       (goto-char sort-regexp-record-end)))
		   (function (lambda ()
			       (let ((n 0))
				 (cond ((numberp key-regexp)
					(setq n key-regexp))
				       ((re-search-forward
					 key-regexp sort-regexp-record-end t)
					(setq n 0))
				       (t (throw 'key nil)))
				 (condition-case ()
				     (string-to-number (match-string n))
				   ;; if there was no such register
				   (error (throw 'key nil))))))
		   nil '<)))))
