(require 'autoinsert)
(auto-insert-mode t)
(eval-after-load 'autoinsert
  '(define-auto-insert '("\\.cpp\\'" . "C skeleton")
     '(
       "Short description:"
       "#include <"
       (file-name-sans-extension
        (file-name-nondirectory (buffer-file-name)))
       ".hpp>" \n \n
       > _ \n
       )))

(eval-after-load 'autoinsert
  '(define-auto-insert
     '("\\.\\([Hh]\\|hh\\|hpp\\)\\'" . "C / C++ header")
     '((s-upcase (s-snake-case (file-name-nondirectory buffer-file-name)))
       "#ifndef " str n "#define " str "\n\n" _ "\n\n#endif  // " str)
     ))

(eval-after-load 'autoinsert
  '(define-auto-insert
     '(org-mode . "org skeleton")
     '("Short description: "
       "#+TITLE: " (s-titleized-words (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))) \n
       "#+AUTHOR: Wei Sun (孙伟)" \n
       "#+EMAIL: wei.sun@spreadtrum.com" \n
       "* " (s-titleized-words (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))) \n
       > _ \n
       )))


(eval-after-load 'autoinsert
  '(define-auto-insert
     '(tintin-mode . "tintin skeleton")
     '("Short description: "
       "#class " (file-name-sans-extension (file-name-nondirectory (buffer-file-name))) " open" \n
       > _ \n       
       "#class " (file-name-sans-extension (file-name-nondirectory (buffer-file-name))) " close" \n       
       )))

(eval-after-load 'autoinsert
  '(define-auto-insert
     '(python-mode . "python skeleton")
     '("Short description: "
       "#!/usr/bin/env python" \n
       > _ \n       
       )))

(eval-after-load 'autoinsert
  '(define-auto-insert
     '(perl-mode . "perl skeleton")
     '("Short description: "
       "#!/usr/bin/env perl" \n
       > _ \n       
       )))
(eval-after-load 'autoinsert
  '(define-auto-insert
     '(ruby-mode . "ruby skeleton")
     '("Short description: "
       "#!/usr/bin/env ruby" \n
       > _ \n       
       )))
