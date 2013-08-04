(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "xelatex")
 '(TeX-command-list (quote (("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (plain-tex-mode texinfo-mode ams-tex-mode) :help "Run plain TeX") ("LaTeX" "xelatex%(mode) %t" TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX") ("Makeinfo" "makeinfo %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with Info output") ("Makeinfo HTML" "makeinfo --html %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with HTML output") ("AmSTeX" "%(PDF)amstex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (ams-tex-mode) :help "Run AMSTeX") ("ConTeXt" "texexec --once --texutil %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt once") ("ConTeXt Full" "texexec %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt until completion") ("BibTeX" "bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX") ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer") ("Print" "%p" TeX-run-command t t :help "Print the file") ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command) ("File" "%(o?)dvips %d -o %f " TeX-run-command t t :help "Generate PostScript file") ("Index" "makeindex %s" TeX-run-command nil t :help "Create index file") ("Check" "lacheck %s" TeX-run-compile nil (latex-mode) :help "Check LaTeX file for correctness") ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document") ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files") ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files") ("Other" "" TeX-run-command t t :help "Run an arbitrary command"))))
 '(TeX-file-extensions (quote ("tex" "sty" "cls" "ltx" "texi" "texinfo" "dtx" "bmer")))
 '(TeX-outline-extra (quote (("[:blank:]*\\\\begin{CJK}" 1) ("[:blank:]*\\\\end{CJK}" 1))))
 '(TeX-output-view-style (quote (("^dvi$" ("^landscape$" "^pstricks$\\|^pst-\\|^psfrag$") "%(o?)dvips -t landscape %d -o && gv %f") ("^dvi$" "^pstricks$\\|^pst-\\|^psfrag$" "%(o?)dvips %d -o && gv %f") ("^dvi$" ("^a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4$" "^landscape$") "%(o?)xdvi %dS -paper a4r -s 0 %d") ("^dvi$" "^a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4$" "%(o?)xdvi %dS -paper a4 %d") ("^dvi$" ("^a5\\(?:comb\\|paper\\)$" "^landscape$") "%(o?)xdvi %dS -paper a5r -s 0 %d") ("^dvi$" "^a5\\(?:comb\\|paper\\)$" "%(o?)xdvi %dS -paper a5 %d") ("^dvi$" "^b5paper$" "%(o?)xdvi %dS -paper b5 %d") ("^dvi$" "^letterpaper$" "%(o?)xdvi %dS -paper us %d") ("^dvi$" "^legalpaper$" "%(o?)xdvi %dS -paper legal %d") ("^dvi$" "^executivepaper$" "%(o?)xdvi %dS -paper 7.25x10.5in %d") ("^dvi$" "." "%(o?)xdvi %dS %d") ("^pdf$" "." "evince %o") ("^html?$" "." "firefox %o"))))
 '(ac-auto-show-menu 1.0)
 '(ac-delay 0.8)
 '(ac-menu-height 20)
 '(ac-modes (quote (lisp-mode slime-repl-mode emacs-lisp-mode lisp-interaction-mode c-mode cc-mode c++-mode java-mode clojure-mode scala-mode scheme-mode ocaml-mode tuareg-mode perl-mode cperl-mode python-mode ruby-mode ecmascript-mode javascript-mode js-mode js2-mode php-mode css-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode)))
 '(ac-use-fuzzy t)
 '(ahs-case-fold-search nil)
 '(anything-command-map-prefix-key "s-SPC")
 '(auto-coding-alist (quote (("\\.\\(arc\\|zip\\|lzh\\|lha\\|zoo\\|[jew]ar\\|xpi\\|rar\\|7z\\|ARC\\|ZIP\\|LZH\\|LHA\\|ZOO\\|[JEW]AR\\|XPI\\|RAR\\|7Z\\)\\'" . no-conversion-multibyte) ("\\.\\(exe\\|EXE\\)\\'" . no-conversion) ("\\.\\(sx[dmicw]\\|odt\\|tar\\|t[bg]z\\)\\'" . no-conversion) ("\\.\\(gz\\|Z\\|bz\\|bz2\\|xz\\|gpg\\)\\'" . no-conversion) ("\\.\\(jpe?g\\|png\\|gif\\|tiff?\\|p[bpgn]m\\)\\'" . no-conversion) ("\\.pdf\\'" . no-conversion) ("/#[^/]+#\\'" . emacs-mule) ("\\.tin\\'" . gbk))))
 '(auto-indent-next-pair-timer-geo-mean (quote ((default 0.0005 0))))
 '(auto-indent-next-pair-timer-interval (quote ((emacs-lisp-mode 1.5) (java-mode 1.5) (default 0.0005))))
 '(auto-insert-alist (quote ((("\\.\\([Hh]\\|hh\\|hpp\\)\\'" . "C / C++ header") (upcase (concat (file-name-nondirectory (file-name-sans-extension buffer-file-name)) "_" (file-name-extension buffer-file-name))) "#ifndef " str n "#define " str "

" _ "

#endif") (("\\.\\([Cc]\\|cc\\|cpp\\)\\'" . "C / C++ program") nil "#include \"" (let ((stem (file-name-sans-extension buffer-file-name))) (cond ((file-exists-p (concat stem ".h")) (file-name-nondirectory (concat stem ".h"))) ((file-exists-p (concat stem ".hh")) (file-name-nondirectory (concat stem ".hh"))))) & 34 | -10) (("[Mm]akefile\\'" . "Makefile") . "makefile.inc") (html-mode lambda nil (sgml-tag "html")) (plain-tex-mode . "tex-insert.tex") (latex-mode . "tex-insert.tex") (("/bin/.*[^/]\\'" . "Shell-Script mode magic number") lambda nil (if (eq major-mode (default-value (quote major-mode))) (sh-mode))) (ada-mode . ada-header) (("\\.[1-9]\\'" . "Man page skeleton") "Short description: " ".\\\" Copyright (C), " (format-time-string "%Y") "  " (getenv "ORGANIZATION") | (progn user-full-name) "
.\\\" You may distribute this file under the terms of the GNU Free
.\\\" Documentation License.
.TH " (file-name-base) " " (file-name-extension (buffer-file-name)) " " (format-time-string "%Y-%m-%d ") "
.SH NAME
" (file-name-base) " \\- " str "
.SH SYNOPSIS
.B " (file-name-base) "
" _ "
.SH DESCRIPTION
.SH OPTIONS
.SH FILES
.SH \"SEE ALSO\"
.SH BUGS
.SH AUTHOR
" (user-full-name) (quote (if (search-backward "&" (line-beginning-position) t) (replace-match (capitalize (user-login-name)) t t))) (quote (end-of-line 1)) " <" (progn user-mail-address) ">
") (("\\.el\\'" . "Emacs Lisp header") "Short description: " ";;; " (file-name-nondirectory (buffer-file-name)) " --- " str "

;; Copyright (C) " (format-time-string "%Y") "  " (getenv "ORGANIZATION") | (progn user-full-name) "

;; Author: " (user-full-name) (quote (if (search-backward "&" (line-beginning-position) t) (replace-match (capitalize (user-login-name)) t t))) (quote (end-of-line 1)) " <" (progn user-mail-address) ">
;; Keywords: " (quote (require (quote finder))) (quote (setq v1 (mapcar (lambda (x) (list (symbol-name (car x)))) finder-known-keywords) v2 (mapconcat (lambda (x) (format "%12s:  %s" (car x) (cdr x))) finder-known-keywords "
"))) ((let ((minibuffer-help-form v2)) (completing-read "Keyword, C-h: " v1 nil t)) str ", ") & -2 "

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; " _ "

;;; Code:



(provide '" (file-name-base) ")
;;; " (file-name-nondirectory (buffer-file-name)) " ends here
") (("\\.texi\\(nfo\\)?\\'" . "Texinfo file skeleton") "Title: " "\\input texinfo   @c -*-texinfo-*-
@c %**start of header
@setfilename " (file-name-base) ".info
" "@settitle " str "
@c %**end of header
@copying
" (setq short-description (read-string "Short description: ")) ".

" "Copyright @copyright{} " (format-time-string "%Y") "  " (getenv "ORGANIZATION") | (progn user-full-name) "

@quotation
Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
A copy of the license is included in the section entitled ``GNU
Free Documentation License''.

A copy of the license is also available from the Free Software
Foundation Web site at @url{http://www.gnu.org/licenses/fdl.html}.

@end quotation

The document was typeset with
@uref{http://www.texinfo.org/, GNU Texinfo}.

@end copying

@titlepage
@title " str "
@subtitle " short-description "
@author " (getenv "ORGANIZATION") | (progn user-full-name) " <" (progn user-mail-address) ">
@page
@vskip 0pt plus 1filll
@insertcopying
@end titlepage

@c Output the table of the contents at the beginning.
@contents

@ifnottex
@node Top
@top " str "

@insertcopying
@end ifnottex

@c Generate the nodes for this menu with `C-c C-u C-m'.
@menu
@end menu

@c Update all node entries with `C-c C-u C-n'.
@c Insert new nodes with `C-c C-c n'.
@node Chapter One
@chapter Chapter One

" _ "

@node Copying This Manual
@appendix Copying This Manual

@menu
* GNU Free Documentation License::  License for copying this manual.
@end menu

@c Get fdl.texi from http://www.gnu.org/licenses/fdl.html
@include fdl.texi

@node Index
@unnumbered Index

@printindex cp

@bye

@c " (file-name-nondirectory (buffer-file-name)) " ends here
"))))
 '(auto-insert-directory "~/.elisp/autoinsert")
 '(auto-insert-query t)
 '(back-button-index-timeout 0)
 '(bm-buffer-persistence t)
 '(bm-cycle-all-buffers t)
 '(bm-highlight-style (quote bm-highlight-only-fringe))
 '(bm-persistent-face (quote bm-face))
 '(bm-priority 2)
 '(bm-recenter t)
 '(bookmark-default-file "~/.elisp/emacs.bmk")
 '(browse-kill-ring-display-duplicates nil)
 '(browse-kill-ring-no-duplicates t)
 '(browse-url-browser-function (quote browse-url-w3))
 '(browse-url-generic-args (quote ("-newpage")))
 '(browse-url-generic-program "google-chrome")
 '(bs-configurations (quote (("all" nil nil nil nil nil) ("files" nil nil nil bs-visits-non-file bs-sort-buffer-interns-are-last))))
 '(bs-default-configuration "files")
 '(bs-default-sort-name "by mode")
 '(c-offsets-alist (quote ((case-label . 0))))
 '(canlock-password "e8b2356fc28fdc87defe0d5b18dda7a9d2f2e7db")
 '(cedet-android-current-version "15")
 '(cedet-android-sdk-root "~/source/android-sdk")
 '(clean-buffer-list-kill-regexps (quote ("\\*.*\\*")))
 '(column-number-mode t)
 '(company-backends (quote (company-nxml company-css company-files company-dabbrev)))
 '(company-begin-commands (quote (quote (self-insert-command))))
 '(company-idle-delay 0.2)
 '(company-minimum-prefix-length 2)
 '(company-show-numbers t)
 '(compilation-scroll-output (quote first-error))
 '(compilation-skip-threshold 2)
 '(cperl-electric-keywords t)
 '(cperl-highlight-variables-indiscriminately t)
 '(cperl-indent-level 4)
 '(cscope-display-cscope-buffer nil)
 '(cscope-display-times nil)
 '(cua-enable-cua-keys nil)
 '(custom-safe-themes (quote ("1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "e9680c4d70f1d81afadd35647e818913da5ad34917f2c663d12e737cdecd2a77" default)))
 '(deft-auto-save-interval 60.0)
 '(deft-extension "org")
 '(deft-strip-title-regexp "^.*? ")
 '(deft-text-mode (quote org-mode))
 '(desktop-lazy-idle-delay 2)
 '(desktop-load-locked-desktop t)
 '(diff-hl-draw-borders t)
 '(dired-backup-overwrite t)
 '(dired-find-subdir nil)
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-default-load-average nil)
 '(display-time-mail-file (quote none))
 '(display-time-mode t)
 '(display-time-string-forms (quote ((if (and (not display-time-format) display-time-day-and-date) (format-time-string "%A %m/%d " now) "") (propertize (format-time-string (or display-time-format (if display-time-24hr-format "%H:%M" "%-I:%M%p")) now) (quote help-echo) (format-time-string "%a %b %e, %Y" now)) load (if mail (concat " " (propertize display-time-mail-string (quote display) (\` (when (and display-time-use-mail-icon (display-graphic-p)) (\,@ display-time-mail-icon) (\,@ (if (and display-time-mail-face (memq (plist-get (cdr display-time-mail-icon) :type) (quote (pbm xbm)))) (let ((bg (face-attribute display-time-mail-face :background))) (if (stringp bg) (list :background bg))))))) (quote face) display-time-mail-face (quote help-echo) "You have new mail; mouse-2: Read mail" (quote mouse-face) (quote mode-line-highlight) (quote local-map) (make-mode-line-mouse-map (quote mouse-2) read-mail-command))) ""))))
 '(douban-music-default-channel 4)
 '(ecb-compile-window-height nil)
 '(ecb-ignore-display-buffer-function (quote compile-window))
 '(ecb-layout-name "my-methods")
 '(ecb-layout-window-sizes (quote (("left9" (ecb-methods-buffer-name 0.35714285714285715 . 0.9772727272727273)))))
 '(ecb-maximize-ecb-window-after-selection t)
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-tip-of-the-day nil)
 '(ecb-windows-width 0.3)
 '(eclim-executable "/opt/eclipse/eclim")
 '(eclim-problems-show-pos t)
 '(eclimd-wait-for-process nil)
 '(elscreen-display-screen-number nil)
 '(elscreen-display-tab t)
 '(elscreen-prefix-key "")
 '(elscreen-tab-display-control nil)
 '(elscreen-tab-display-kill-screen nil)
 '(eshell-aliases-file "~/.elisp/alias")
 '(evil-emacs-state-modes (quote (archive-mode bbdb-mode bookmark-bmenu-mode bookmark-edit-annotation-mode browse-kill-ring-mode bzr-annotate-mode calc-mode cfw:calendar-mode completion-list-mode Custom-mode debugger-mode delicious-search-mode desktop-menu-blist-mode desktop-menu-mode doc-view-mode dvc-bookmarks-mode dvc-diff-mode dvc-info-buffer-mode dvc-log-buffer-mode dvc-revlist-mode dvc-revlog-mode dvc-status-mode dvc-tips-mode ediff-mode ediff-meta-mode efs-mode Electric-buffer-menu-mode emms-browser-mode emms-mark-mode emms-metaplaylist-mode emms-playlist-mode fj-mode gc-issues-mode gdb-breakpoints-mode gdb-disassembly-mode gdb-frames-mode gdb-locals-mode gdb-memory-mode gdb-registers-mode gdb-threads-mode gist-list-mode gnus-article-mode gnus-browse-mode gnus-group-mode gnus-server-mode gnus-summary-mode google-maps-static-mode ibuffer-mode jde-javadoc-checker-report-mode magit-commit-mode magit-diff-mode magit-key-mode magit-log-mode magit-mode magit-reflog-mode magit-show-branches-mode magit-stash-mode magit-status-mode magit-wazzup-mode mh-folder-mode monky-mode notmuch-hello-mode notmuch-search-mode notmuch-show-mode occur-mode org-agenda-mode package-menu-mode proced-mode rcirc-mode rebase-mode recentf-dialog-mode reftex-select-bib-mode reftex-toc-mode sldb-mode slime-inspector-mode slime-thread-control-mode slime-xref-mode sr-buttons-mode sr-mode sr-tree-mode sr-virtual-mode tar-mode tetris-mode tla-annotate-mode tla-archive-list-mode tla-bconfig-mode tla-bookmarks-mode tla-branch-list-mode tla-browse-mode tla-category-list-mode tla-changelog-mode tla-follow-symlinks-mode tla-inventory-file-mode tla-inventory-mode tla-lint-mode tla-logs-mode tla-revision-list-mode tla-revlog-mode tla-tree-lint-mode tla-version-list-mode twittering-mode urlview-mode vc-annotate-mode vc-dir-mode vc-git-log-view-mode vc-svn-log-view-mode vm-mode vm-summary-mode w3m-mode wab-compilation-mode xgit-annotate-mode xgit-changelog-mode xgit-diff-mode xgit-revlog-mode xhg-annotate-mode xhg-log-mode xhg-mode xhg-mq-mode xhg-mq-sub-mode xhg-status-extra-mode)))
 '(file-cache-filter-regexps (quote ("~$" "\\.o$" "\\.exe$" "\\.a$" "\\.elc$" ",v$" "\\.output$" "\\.$" "#$" "\\.class$" "\\.git")))
 '(find-grep-options "-q  -I -i")
 '(gdb-enable-debug t)
 '(global-semantic-stickyfunc-mode t)
 '(helm-candidate-number-limit 20)
 '(helm-ff-auto-update-initial-value nil)
 '(helm-for-files-preferred-list (quote (helm-source-buffers-list helm-source-buffer-not-found helm-source-bookmarks helm-source-file-cache helm-source-files-in-current-dir)))
 '(helm-quick-update t)
 '(ibuffer-formats (quote ((mark modified read-only " " (name 60 60 :left :elide) " " (size 9 -1 :right) " " (mode 16 16 :left :elide) " " filename-and-process) (mark " " (name 16 -1) " " filename))))
 '(ibuffer-saved-filter-groups nil)
 '(ibuffer-saved-filters nil)
 '(ibus-cursor-color "red")
 '(icicle-command-abbrev-alist nil)
 '(icicle-reminder-prompt-flag 0)
 '(ido-enable-last-directory-history nil)
 '(ido-enable-tramp-completion nil)
 '(ido-use-filename-at-point (quote guess))
 '(ido-use-url-at-point t)
 '(ispell-personal-dictionary "/home/sunway/.elisp/dict_my")
 '(ispell-query-replace-choices t)
 '(large-file-warning-threshold 60000000)
 '(magit-completing-read-function (quote magit-ido-completing-read))
 '(magit-set-upstream-on-push t)
 '(mail-host-address nil)
 '(message-log-max 1000)
 '(midnight-mode t nil (midnight))
 '(mm-inline-text-html-with-images t)
 '(mm-text-html-renderer (quote w3m-standalone))
 '(mo-git-blame-blame-window-width 60)
 '(mo-git-blame-use-ido (quote always))
 '(newsticker-url-list-defaults nil)
 '(nxml-slash-auto-complete-flag t)
 '(org-agenda-custom-commands (quote (("a" "Agenda and all work TODO's" ((agenda "" ((org-agenda-ndays 7))) (alltodo))) ("l" "Agenda and all life TODO's" ((agenda "" ((org-agenda-ndays 7) (org-agenda-files (quote ("~/.elisp/dotemacs/org/gtd/life.org"))))) (tags-todo "+life-habit"))) ("w" "Agenda and all work TODO's" ((agenda "" ((org-agenda-ndays 7) (org-agenda-files (quote ("~/.elisp/dotemacs/org/gtd/work.org"))))) (tags-todo "+work"))))))
 '(org-agenda-persistent-filter t)
 '(org-babel-load-languages (quote ((emacs-lisp . t) (dot . t) (ditaa . t) (R . t) (python . t) (ruby . t) (gnuplot . t) (clojure . t) (sh . t) (ledger . t) (org . t) (plantuml . t) (latex . t))))
 '(org-capture-bookmark nil)
 '(org-confirm-babel-evaluate nil)
 '(org-export-headline-levels 2)
 '(org-export-html-style "    <link rel=\"stylesheet\" type=\"text/css\" href=\"/stylesheets/main.css\" media=\"screen\" />")
 '(org-export-latex-emphasis-alist (quote (("*" "\\textbf{%s}" nil) ("/" "\\emph{%s}" nil) ("_" "\\underline{%s}" nil) ("+" "\\st{%s}" nil) ("=" "\\protectedtexttt" t) ("~" "\\verb" t))))
 '(org-export-with-toc 2)
 '(org-icalendar-include-todo t)
 '(org-icalendar-use-deadline (quote (event-if-not-todo event-if-todo todo-due)))
 '(org-icalendar-use-scheduled (quote (event-if-not-todo event-if-todo todo-start)))
 '(org-latex-pdf-process (quote ("xelatex -interaction nonstopmode %f" "xelatex -interaction nonstopmode %f" "xelatex -interaction nonstopmode %f")))
 '(org-latex-to-pdf-process (quote ("xelatex -interaction nonstopmode %f" "xelatex -interaction nonstopmode %f")))
 '(org-publish-list-skipped-files t)
 '(org-publish-sitemap-sort-files (quote anti-chronologically))
 '(org-publish-use-timestamps-flag t)
 '(org-refile-targets (quote ((org-agenda-files :maxlevel . 2))))
 '(org-startup-folded nil)
 '(org-startup-indented t)
 '(org-use-speed-commands t)
 '(org2blog/wp-show-post-in-browser nil)
 '(python-use-skeletons t)
 '(quack-default-program "racket")
 '(quack-fontify-style (quote emacs))
 '(quack-global-menu-p nil)
 '(quack-run-scheme-always-prompts-p nil)
 '(quack-smart-open-paren-p t)
 '(rails-ws:default-server-type "webrick")
 '(rcirc-always-use-server-buffer-flag t)
 '(rcirc-encode-coding-system (quote utf-8))
 '(rcirc-log-flag t)
 '(rcirc-server-alist (quote (("irc_pld" :nick "sunway" :user-name "sunway" :channels ("#pld")))))
 '(rcirc-startup-channels-alist nil)
 '(rcirc-track-minor-mode t)
 '(read-file-name-completion-ignore-case t)
 '(safe-local-variable-values (quote ((default-justification . left) (lexical-binding . t) (require-final-newline . t) (mangle-whitespace . t) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby") (todo-categories "Todo" "Todo") (folded-file . t))))
 '(savehist-additional-variables (quote (kill-ring compile-command)))
 '(scheme-program-name "racket")
 '(semantic-idle-summary-function (quote semantic-format-tag-summarize))
 '(senator-minor-mode-hook nil)
 '(show-paren-mode t)
 '(show-paren-style (quote mixed))
 '(slime-auto-connect (quote always))
 '(slime-kill-without-query-p t)
 '(slime-repl-history-remove-duplicates t)
 '(slime-startup-animation nil)
 '(sp-autoescape-string-quote nil)
 '(sql-electric-stuff (quote semicolon))
 '(sql-product (quote sqlite))
 '(sql-sqlite-program "sqlite3")
 '(sr-avfs-root "~/.avfs")
 '(sr-listing-switches "-la")
 '(sr-loop-use-popups nil)
 '(sr-modeline-use-utf8-marks nil)
 '(sr-show-file-attributes nil)
 '(sr-use-commander-keys nil)
 '(sr-virtual-listing-switches " -aldpgG")
 '(switch-window-increase 15)
 '(tabbar-home-button (quote (("") "")))
 '(tabbar-scroll-left-button (quote (("") "")))
 '(tabbar-scroll-right-button (quote (("") "")))
 '(tramp-default-host "")
 '(tramp-default-method "scp")
 '(tramp-remote-path (quote (tramp-default-remote-path "/usr/sbin" "/usr/local/bin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin" "/opt/SunStudio_11/SUNWspro/bin" "/usr/sfw/bin")))
 '(tramp-syntax (quote ftp))
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify))
 '(uniquify-separator "@")
 '(uniquify-strip-common-suffix t)
 '(vc-follow-symlinks nil)
 '(w3m-default-display-inline-images nil)
 '(w3m-toggle-inline-images-permanently nil)
 '(wg-morph-hsteps 50)
 '(wg-morph-on nil)
 '(wg-morph-vsteps 30)
 '(wg-no-confirm t)
 '(wg-query-for-save-on-emacs-exit nil)
 '(wg-query-for-save-on-workgroups-mode-exit nil)
 '(wg-use-faces nil)
 '(winner-ring-size 5)
 '(xgtags-goto-tag (quote never))
 '(xgtags-show-paths (quote expanded)))

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
 '(diff-hl-change ((t (:background "cornflower blue" :foreground "blue"))))
 '(diff-hl-delete ((t (:background "LightPink1" :foreground "red"))))
 '(diff-hl-insert ((t (:background "pale green" :foreground "green"))))
 '(diff-hunk-header ((((background dark)) (:foreground "Black" :background "#05057F7F8D8D")) (t (:foreground "White" :background "Salmon"))))
 '(diff-index ((((background dark)) (:foreground "Magenta")) (t (:foreground "Green"))))
 '(diff-nonexistent ((((background dark)) (:foreground "#FFFFFFFF7474")) (t (:foreground "DarkBlue"))))
 '(diff-refine-added ((t (:inherit diff-refine-change))))
 '(diff-removed ((((background dark)) (:foreground "#7474FFFF7474")) (t (:foreground "DarkMagenta"))))
 '(ecb-default-highlight-face ((t (:background "olivedrab" :foreground "white"))))
 '(ecb-tag-header-face ((t (:background "olivedrab" :foreground "white"))))
 '(ediff-fine-diff-B ((t (:background "dark violet"))))
 '(elscreen-tab-background-face ((t (:background "DeepSkyBlue4"))))
 '(elscreen-tab-control-face ((t (:underline "Gray50"))))
 '(elscreen-tab-current-screen-face ((t (:background "orange red"))))
 '(elscreen-tab-other-screen-face ((t (:background "Gray85"))))
 '(font-latex-sectioning-2-face ((t (:foreground "green" :height 1.5))))
 '(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-4-face :foreground "yellow" :height 1.3))))
 '(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-5-face :foreground "cyan" :height 1.1))))
 '(font-latex-verbatim-face ((((class color) (background dark)) (:foreground "burlywood" :family "monospace"))))
 '(helm-selection ((t (:background "OrangeRed3" :foreground "white"))))
 '(hs-fringe-face ((t (:foreground "yellow"))))
 '(magit-header ((t (:inherit highlight))))
 '(sr-active-path-face ((t nil)) t)
 '(sr-directory-face ((t (:foreground "DarkOrange"))) t)
 '(sr-editing-path-face ((t (:foreground "yellow" :weight bold :height 120))) t)
 '(sr-highlight-path-face ((t (:foreground "#ace6ac" :weight bold :height 120))) t)
 '(sr-html-face ((t (:foreground "Green"))) t)
 '(sr-passive-path-face ((t (:foreground "lightgray" :weight bold :height 120))) t)
 '(sr-xml-face ((t (:foreground "seagreen2"))) t)
 '(tabbar-button-face ((t (:foreground "cyan"))) t)
 '(tabbar-default-face ((t (:background "black" :foreground "white" :height 1.1))) t)
 '(tabbar-selected-face ((t (:foreground "cyan" :background "black" :height 1.5))) t)
 '(tabbar-separator-face ((t (:foreground "black" :background "black"))) t)
 '(tabbar-unselected-face ((t (:foreground "grey60" :background "black" :height 1.1))) t)
 '(which-func ((((class color) (background dark)) nil))))
