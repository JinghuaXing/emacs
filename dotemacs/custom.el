(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(LaTeX-command "xelatex")
 '(TeX-command-list (quote (("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (plain-tex-mode texinfo-mode ams-tex-mode) :help "Run plain TeX") ("LaTeX" "xelatex%(mode) %t" TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX") ("Makeinfo" "makeinfo %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with Info output") ("Makeinfo HTML" "makeinfo --html %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with HTML output") ("AmSTeX" "%(PDF)amstex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (ams-tex-mode) :help "Run AMSTeX") ("ConTeXt" "texexec --once --texutil %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt once") ("ConTeXt Full" "texexec %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt until completion") ("BibTeX" "bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX") ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer") ("Print" "%p" TeX-run-command t t :help "Print the file") ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command) ("File" "%(o?)dvips %d -o %f " TeX-run-command t t :help "Generate PostScript file") ("Index" "makeindex %s" TeX-run-command nil t :help "Create index file") ("Check" "lacheck %s" TeX-run-compile nil (latex-mode) :help "Check LaTeX file for correctness") ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document") ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files") ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files") ("Other" "" TeX-run-command t t :help "Run an arbitrary command"))))
 '(TeX-outline-extra (quote (("[:blank:]*\\\\begin{CJK}" 1) ("[:blank:]*\\\\end{CJK}" 1))))
 '(TeX-output-view-style (quote (("^dvi$" ("^landscape$" "^pstricks$\\|^pst-\\|^psfrag$") "%(o?)dvips -t landscape %d -o && gv %f") ("^dvi$" "^pstricks$\\|^pst-\\|^psfrag$" "%(o?)dvips %d -o && gv %f") ("^dvi$" ("^a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4$" "^landscape$") "%(o?)xdvi %dS -paper a4r -s 0 %d") ("^dvi$" "^a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4$" "%(o?)xdvi %dS -paper a4 %d") ("^dvi$" ("^a5\\(?:comb\\|paper\\)$" "^landscape$") "%(o?)xdvi %dS -paper a5r -s 0 %d") ("^dvi$" "^a5\\(?:comb\\|paper\\)$" "%(o?)xdvi %dS -paper a5 %d") ("^dvi$" "^b5paper$" "%(o?)xdvi %dS -paper b5 %d") ("^dvi$" "^letterpaper$" "%(o?)xdvi %dS -paper us %d") ("^dvi$" "^legalpaper$" "%(o?)xdvi %dS -paper legal %d") ("^dvi$" "^executivepaper$" "%(o?)xdvi %dS -paper 7.25x10.5in %d") ("^dvi$" "." "%(o?)xdvi %dS %d") ("^pdf$" "." "evince %o") ("^html?$" "." "firefox %o"))))
 '(ac-delay 0.3)
 '(ac-menu-height 20)
 '(anything-command-map-prefix-key "s-SPC")
 '(bm-annotate-on-create t)
 '(bm-buffer-persistence t)
 '(bm-highlight-style (quote bm-highlight-only-fringe))
 '(bm-persistent-face (quote bm-face))
 '(bm-priority 2)
 '(bm-recenter t)
 '(browse-url-browser-function (quote browse-url-firefox))
 '(browse-url-generic-args (quote ("-newpage")))
 '(browse-url-generic-program "firefox")
 '(bs-configurations (quote (("all" nil nil nil nil nil) ("files" nil nil nil bs-visits-non-file bs-sort-buffer-interns-are-last))))
 '(bs-default-configuration "files")
 '(bs-default-sort-name "by mode")
 '(c-offsets-alist (quote ((case-label . 0))))
 '(canlock-password "e8b2356fc28fdc87defe0d5b18dda7a9d2f2e7db")
 '(column-number-mode t)
 '(company-backends (quote (company-nxml company-css company-files company-dabbrev)))
 '(company-begin-commands (quote (quote (self-insert-command))))
 '(company-idle-delay 0.2)
 '(company-minimum-prefix-length 2)
 '(company-show-numbers t)
 '(compilation-skip-threshold 2)
 '(cperl-electric-keywords t)
 '(cperl-highlight-variables-indiscriminately t)
 '(cperl-indent-level 4)
 '(cscope-display-cscope-buffer nil)
 '(cscope-display-times nil)
 '(cua-enable-cua-keys nil)
 '(desktop-load-locked-desktop t)
 '(dired-backup-overwrite t)
 '(dired-find-subdir nil)
 '(dired-garbage-files-regexp "\\.\\(?:aux\\|bak\\|dvi\\|log\\|orig\\|rej\\|toc\\|class\\)\\'")
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-default-load-average nil)
 '(display-time-mail-file (quote none))
 '(display-time-mode t)
 '(display-time-string-forms (quote ((if (and (not display-time-format) display-time-day-and-date) (format-time-string "%A %m/%d " now) "") (propertize (format-time-string (or display-time-format (if display-time-24hr-format "%H:%M" "%-I:%M%p")) now) (quote help-echo) (format-time-string "%a %b %e, %Y" now)) load (if mail (concat " " (propertize display-time-mail-string (quote display) (\` (when (and display-time-use-mail-icon (display-graphic-p)) (\,@ display-time-mail-icon) (\,@ (if (and display-time-mail-face (memq (plist-get (cdr display-time-mail-icon) :type) (quote (pbm xbm)))) (let ((bg (face-attribute display-time-mail-face :background))) (if (stringp bg) (list :background bg))))))) (quote face) display-time-mail-face (quote help-echo) "You have new mail; mouse-2: Read mail" (quote mouse-face) (quote mode-line-highlight) (quote local-map) (make-mode-line-mouse-map (quote mouse-2) read-mail-command))) ""))))
 '(ecb-ignore-display-buffer-function (quote compile-window))
 '(ecb-maximize-ecb-window-after-selection t)
 '(ecb-options-version "2.32")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-tip-of-the-day nil)
 '(ecb-tree-buffer-style (quote image))
 '(ecb-windows-width 0.3)
 '(find-grep-options "-q --exclude=*svn* -I -i")
 '(gdb-enable-debug t)
 '(icicle-command-abbrev-alist nil)
 '(icicle-reminder-prompt-flag 0)
 '(ido-auto-merge-work-directories-length -1)
 '(ido-enable-dot-prefix t)
 '(ido-enable-tramp-completion nil)
 '(ido-use-filename-at-point (quote guess))
 '(ispell-personal-dictionary "/home/sunway/.elisp/dict_my")
 '(ispell-query-replace-choices t)
 '(magit-completing-read-function (quote magit-ido-completing-read))
 '(mail-host-address nil)
 '(midnight-mode t nil (midnight))
 '(mm-inline-text-html-with-images t)
 '(mm-text-html-renderer (quote w3m-standalone))
 '(newsticker-url-list-defaults nil)
 '(nxml-slash-auto-complete-flag t)
 '(org-export-latex-emphasis-alist (quote (("*" "\\textbf{%s}" nil) ("/" "\\emph{%s}" nil) ("_" "\\underline{%s}" nil) ("+" "\\st{%s}" nil) ("=" "\\protectedtexttt" t) ("~" "\\verb" t))))
 '(org2blog/wp-show-post-in-browser nil)
 '(python-use-skeletons t)
 '(rcirc-authinfo (quote (("localhost" bitlbee "sunway" "biwfnh"))))
 '(rcirc-decode-coding-system (quote gbk))
 '(rcirc-encode-coding-system (quote gbk))
 '(rcirc-server-alist (quote (("localhost" :nick "sunway" :user-name "sunway" :channels ("&bitlbee")))))
 '(rcirc-startup-channels-alist nil)
 '(safe-local-variable-values (quote ((todo-categories "Todo" "Todo") (folded-file . t))))
 '(savehist-additional-variables (quote (kill-ring compile-command)))
 '(semantic-idle-summary-function (quote semantic-format-tag-summarize))
 '(senator-minor-mode-hook nil)
 '(show-paren-mode t)
 '(sql-electric-stuff (quote semicolon))
 '(sql-sqlite-program "/home/apuser/source/android-sdk/tools/sqlite3")
 '(sr-avfs-root "~/.avfs")
 '(sr-virtual-listing-switches "--time-style=long-iso  -aldpgG")
 '(tabbar-home-button (quote (("") "")))
 '(tabbar-scroll-left-button (quote (("") "")))
 '(tabbar-scroll-right-button (quote (("") "")))
 '(tramp-default-method "scp")
 '(tramp-remote-path (quote (tramp-default-remote-path "/usr/sbin" "/usr/local/bin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin" "/opt/SunStudio_11/SUNWspro/bin" "/usr/sfw/bin")))
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(vc-follow-symlinks nil))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#0b0f23" :foreground "#f8f8f2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 105 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(bm-face ((((class color) (background dark)) (:background "SkyBlue1" :foreground "Black"))))
 '(diff-added ((((background dark)) (:foreground "#FFFF9B9BFFFF")) (t (:foreground "DarkGreen"))))
 '(diff-changed ((((background dark)) (:foreground "Yellow")) (t (:foreground "MediumBlue"))))
 '(diff-context ((((background dark)) (:foreground "White")) (t (:foreground "Black"))))
 '(diff-file-header ((((background dark)) (:foreground "Cyan" :background "Black")) (t (:foreground "Red" :background "White"))))
 '(diff-header ((((background dark)) (:foreground "Cyan")) (t (:foreground "Red"))))
 '(diff-hunk-header ((((background dark)) (:foreground "Black" :background "#05057F7F8D8D")) (t (:foreground "White" :background "Salmon"))))
 '(diff-index ((((background dark)) (:foreground "Magenta")) (t (:foreground "Green"))))
 '(diff-nonexistent ((((background dark)) (:foreground "#FFFFFFFF7474")) (t (:foreground "DarkBlue"))))
 '(diff-removed ((((background dark)) (:foreground "#7474FFFF7474")) (t (:foreground "DarkMagenta"))))
 '(font-latex-sectioning-2-face ((t (:foreground "green" :height 1.5))))
 '(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-4-face :foreground "yellow" :height 1.3))))
 '(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-5-face :foreground "cyan" :height 1.1))))
 '(font-latex-verbatim-face ((((class color) (background dark)) (:foreground "burlywood" :family "monospace"))))
 '(sr-directory-face ((t (:foreground "DarkOrange" :weight bold))))
 '(tabbar-button-face ((t (:foreground "cyan"))))
 '(tabbar-default-face ((t (:background "black" :foreground "white" :height 1.1))))
 '(tabbar-selected-face ((t (:foreground "cyan" :background "black" :height 1.5))))
 '(tabbar-separator-face ((t (:foreground "black" :background "black"))))
 '(tabbar-unselected-face ((t (:foreground "grey60" :background "black" :height 1.1)))))


