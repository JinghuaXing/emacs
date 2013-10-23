;;; pretty-mode.el --- redisplay parts of the buffer as pretty symbols
;;; -*- coding: utf-8 -*-

;;; Commentary:
;; 
;; Minor mode for redisplaying parts of the buffer as pretty symbols
;; originally modified from Trent Buck's version at http://paste.lisp.org/display/42335,2/raw
;; Also includes code from `sml-mode'
;; See also http://www.emacswiki.org/cgi-bin/wiki/PrettyLambda
;; 
;; Released under the GPL. No implied warranties, etc. Use at your own risk.
;; Arthur Danskin <arthurdanskin@gmail.com>, March 2008
;;
;; Modifications made here only to mapped symbols by Grant Rettke <grettke@acm.org>, September 2012.
;; 
;; to install:
;; (require 'pretty-mode)
;; and 
;; (global-pretty-mode 1)
;; or
;; (add-hook 'my-pretty-language-hook 'turn-on-pretty-mode)

;;; Code:

(require 'cl)

(defvar pretty-syntax-types '(?_ ?w))

;; modified from `sml-mode'
(defun pretty-font-lock-compose-symbol (alist)
  "Compose a sequence of ascii chars into a symbol."
  (let* ((start (match-beginning 0))
         (end (match-end 0))
         (syntax (char-syntax (char-after start))))
    (if (or (if (memq syntax pretty-syntax-types)
               (or (memq (char-syntax (char-before start)) pretty-syntax-types)
                  (memq (char-syntax (char-after end)) pretty-syntax-types))
             (memq (char-syntax (char-before start)) '(?. ?\\)))
           (memq (get-text-property start 'face)
                 '(font-lock-doc-face font-lock-string-face
                                      font-lock-comment-face)))
        (remove-text-properties start end '(composition))
      (compose-region start end (cdr (assoc (match-string 0) alist)))
;;;       (add-text-properties start end `(display ,repl)))
      ))
  ;; Return nil because we're not adding any face property.
  nil)

(defvar pretty-interaction-mode-alist
  '((inferior-scheme-mode . scheme-mode)
    (lisp-interaction-mode . emacs-lisp-mode)
    (inferior-lisp-mode . lisp-mode)
    (inferior-ess-mode . ess-mode)
    (inf-haskell-mode . haskell-mode)
    (tuareg-interactive-mode . tuareg-mode)
    (inferior-python-mode . python-mode)
    (inferior-octave-mode . octave-mode)
    (inferior-ruby-mode . ruby-mode))
  "Alist mapping from inferior process interaction modes to their
  corresponding script editing modes.")


(defun pretty-font-lock-keywords (alist)
  "Return a `font-lock-keywords' style entry for replacing
regular expressions with symbols. ALIST has the form ((STRING .
REPLACE-CHAR) ...)."
  (when alist
    `((,(regexp-opt (mapcar 'car alist))
       (0 (pretty-font-lock-compose-symbol
           ',alist))))))

(defun pretty-keywords (&optional mode)
  "Return the font-lock keywords for MODE, or the current mode if
MODE is nil. Return nil if there are no keywords."
  (let* ((mode (or mode major-mode))
         (kwds (cdr-safe
                (or (assoc mode pretty-patterns)
                   (assoc (cdr-safe
                           (assoc mode pretty-interaction-mode-alist))
                          pretty-patterns)))))
    (pretty-font-lock-keywords kwds)))

(defgroup pretty nil "Minor mode for replacing text with symbols "
  :group 'faces)

(define-minor-mode pretty-mode
  "Toggle Pretty minor mode.
With arg, turn Pretty minor mode on if arg is positive, off otherwise.

Pretty mode builds on `font-lock-mode'. Instead of highlighting
keywords, it replaces them with symbols. For example, lambda is
displayed as 位 in lisp modes."
  :group 'pretty
                                        ;  :lighter " 位"
  (if pretty-mode
      (progn
        (font-lock-add-keywords nil (pretty-keywords) t)
        (when font-lock-mode
          (font-lock-fontify-buffer)))
    (font-lock-remove-keywords nil (pretty-keywords))
    (remove-text-properties (point-min) (point-max) '(composition nil))))

(defun turn-on-pretty-if-desired ()
  "Turn on `pretty-mode' if the current major mode supports it."
  (if (pretty-keywords)
      (pretty-mode 1)))

(define-globalized-minor-mode global-pretty-mode
  pretty-mode turn-on-pretty-if-desired
  :init-value t)

(defun turn-off-pretty-mode ()
  (interactive)
  (pretty-mode -1))


(defun turn-on-pretty-mode ()
  (interactive)
  (pretty-mode +1))

(defun pretty-compile-patterns (patterns)
  "Set pretty patterns in a convenient way.

PATTERNS should be of the form ((GLYPH (REGEXP MODE ...) ...)
...). GLYPH should be a character. MODE should be the name of a
major mode without the \"-mode\". Returns patterns in the form
expected by `pretty-patterns'"
  (let ((pretty-patterns))
    (loop for (glyph . pairs) in patterns do
          (loop for (regexp . major-modes) in pairs do
                (loop for mode in major-modes do
                      (let* ((mode (intern (concat (symbol-name mode)
                                                   "-mode")))
                             (assoc-pair (assoc mode pretty-patterns))
                             
                             (entry (cons regexp glyph)))
                        (if assoc-pair
                            (push entry (cdr assoc-pair))
                          (push (cons mode (list entry))
                                pretty-patterns))))))
    pretty-patterns))

(defvar pretty-patterns
  (let* ((lispy '(scheme emacs-lisp lisp clojure))
         (mley '(tuareg haskell sml))
         (c-like '(c c++ perl sh python java ess ruby))
         (all (append lispy mley c-like (list 'octave))))
    (pretty-compile-patterns
     `(
       ;; Arrows
       ;; Values taken directly from `The Unicode Standard, Version 5.2' documented
       ;; in `U2190.pdf', located at http://unicode.org/charts/PDF/U2190.pdf

       ;; 2190 鈫� LEFTWARDS ARROW
       (?\u2190 ("<-" ,@mley ess ,@lispy))

       ;; 2192 鈫� RIGHTWARDS ARROW
       (?\u2192 ("->" ,@mley ess c c++ perl ,@lispy))

       ;; 2190 鈫� RIGHTWARDS TWO HEADED ARROW
       (?\u21A0 ("->>" ,@lispy))

       ;; 2191 鈫� UPWARDS ARROW
       (?\u2191 ("\\^" tuareg))

       ;; 21D2 鈬� RIGHTWARDS DOUBLE ARROW
       (?\u21D2 ("=>" sml perl ruby ,@lispy))

       ;; Mathematical Operators

       ;; Values taken directly from `The Unicode Standard, Version 5.2' documented
       ;; in `U2200.pdf', located at http://unicode.org/charts/PDF/U2200.pdf

       ;; 2260 鈮� NOT EQUAL TO
       (?\u2260 ("!=" ,@c-like scheme octave)
                ("not=" clojure)
                ("<>" tuareg octave)
                ("~=" octave)
                ("/=" haskell))

       ;; 2264 鈮� LESS-THAN OR EQUAL TO
       (?\u2264 ("<=" ,@all))

       ;; 2265 鈮� GREATER-THAN OR EQUAL TO
       (?\u2265 (">=" ,@all))

       ;; 2205 鈭� EMPTY SET
       (?\u2205 ("nil" emacs-lisp ruby)
                ("null" scheme java)
                ("'()" scheme)
                ("empty" scheme)
                ("NULL" c c++)
                ;; ("None" python)
                ("()" ,@mley))

       ;; 221a 鈭� SQUARE ROOT
       (?\u221A ("sqrt" ,@all))

       ;; 2211 危 N-ARY SUMMATION
       (?\u2211 ("sum" python))

       ;; 2227 鈭� LOGICAL AND
       (?\u2227 ("and"     ,@lispy python)
                ("andalso" sml)
                ("&&"            c c++ perl haskell))

       ;; 2228 鈭� LOGICAL OR
       (?\u2228 ("or"      ,@lispy)
                ("orelse"  sml)
                ("||"            c c++ perl haskell))

       ;; Superscripts and Subscripts

       ;; Values taken directly from `The Unicode Standard, Version 5.2' documented
       ;; in `U0080.pdf', located at http://unicode.org/charts/PDF/U0080.pdf

       ;; 00B2 虏 SUPERSCRIPT TWO
       (?\u00B2 ("**2" python tuareg octave))

       ;; 00B3 鲁 SUPERSCRIPT THREE
       (?\u00B3 ("**3" python tuareg octave))

       ;; Values taken directly from `The Unicode Standard, Version 5.2' documented
       ;; in `U2070.pdf', located at http://unicode.org/charts/PDF/U2070.pdf

       ;; 207F 鈦� SUPERSCRIPT LATIN SMALL LETTER N
       (?\u207F ("**n" python tuareg octave))

       ;; 2080 鈧� SUBSCRIPT ZERO
       

       ;; 2084 鈧� SUBSCRIPT FOUR
       ;; (?\u2084 ("[4]" ,@c-like)
       ;;          ("(4)" octave)
       ;;          (".(4)" tuareg))

       ;; Greek alphabet

       ;; Values taken directly from `The Unicode Standard, Version 5.2' documented
       ;; in `U0370.pdf', located at http://unicode.org/charts/PDF/U0370.pdf

       ;; Alpha

       ;; 03B1 伪 GREEK SMALL LETTER ALPHA
       (?\u03B1 ("alpha" ,@all)
                ("'a" ,@mley))
       ;; 0391 螒 GREEK CAPITAL LETTER ALPHA
       (?\u0391 ("ALPHA" ,@all))

       ;; Beta

       ;; 03B2 尾 GREEK SMALL LETTER BETA
       (?\u03B2 ("beta" ,@all)
                ("'b" ,@mley))
       ;; 0392 螔 GREEK CAPITAL LETTER BETA
       (?\u0392 ("BETA" ,@all))

       ;; Gamma

       ;; 03B3 纬 GREEK SMALL LETTER GAMMA
       (?\u03B3 ("gamma" ,@all)
                ("'c" ,@mley))
       ;; 0393 螕 GREEK CAPITAL LETTER GAMMA
       (?\u0393 ("GAMMA" ,@all))

       ;; Delta

       ;; 03B4 未 GREEK SMALL LETTER DELTA
       (?\u03B4 ("delta" ,@all)
                ("'d" ,@mley))
       ;; 0394 螖 GREEK CAPITAL LETTER DELTA
       (?\u0394 ("DELTA" ,@all))

       ;; Epsilon

       ;; 03B5 蔚 GREEK SMALL LETTER EPSILON
       (?\u03B5 ("epsilon" ,@all)
                ("'e" ,@mley))
       ;; 0395 螘 GREEK CAPITAL LETTER EPSILON
       (?\u0395 ("EPSILON" ,@all))

       ;; Zeta

       ;; 03B6 味 GREEK SMALL LETTER ZETA
       (?\u03B6 ("zeta" ,@all))
       ;; 0396 螙 GREEK CAPITAL LETTER ZETA
       (?\u0396 ("ZETA" ,@all))

       ;; Eta

       ;; 03B7 畏 GREEK SMALL LETTER ETA
       (?\u03B7 ("eta" ,@all))
       ;; 0397 螚 GREEK CAPITAL LETTER ETA
       (?\u0397 ("ETA" ,@all))

       ;; Theta

       ;; 03B8 胃 GREEK SMALL LETTER THETA
       (?\u03B8 ("theta" ,@all))
       ;; 0398 螛 GREEK CAPITAL LETTER THETA
       (?\u0398 ("THETA" ,@all))

       ;; Iota

       ;; 03B9 喂 GREEK SMALL LETTER IOTA
       (?\u03B9 ("iota" ,@all))
       ;; 0399 螜 GREEK CAPITAL LETTER IOTA
       (?\u0399 ("IOTA" ,@all))

       ;; Kappa

       ;; 03BA 魏 GREEK SMALL LETTER KAPPA
       (?\u03BA ("kappa" ,@all))
       ;; 039A 螝 GREEK CAPITAL LETTER KAPPA
       (?\u039A ("KAPPA" ,@all))

       ;; Lambda

       ;; 03BB 位 GREEK SMALL LETTER LAMDA
       (?\u03BB ("lambda" ,@all)
                ("fn" sml clojure)
                ("fun" tuareg)
                ("\\\\" haskell))

       ;; 039B 螞 GREEK CAPITAL LETTER LAMDA
       (?\u039B ("LAMBDA" ,@all)
                ("FN" sml)
                ("FUN" tuareg))

       ;; Mu

       ;; 03BC 渭 GREEK SMALL LETTER MU
       (?\u03BC ("mu" ,@all))
       ;; 039C 螠 GREEK CAPITAL LETTER MU
       (?\u039C ("MU" ,@all))

       ;; Nu

       ;; 03BD 谓 GREEK SMALL LETTER NU
       (?\u03BD ("nu" ,@all))
       ;; 039D 螡 GREEK CAPITAL LETTER NU
       (?\u039D ("NU" ,@all))

       ;; Xi

       ;; 03BE 尉 GREEK SMALL LETTER XI
       (?\u03BE ("xi" ,@all))
       ;; 039E 螢 GREEK CAPITAL LETTER XI
       (?\u039E ("XI" ,@all))

       ;; Omicron

       ;; 03BF 慰 GREEK SMALL LETTER OMICRON
       (?\u03BF ("omicron" ,@all))
       ;; 039F 螣 GREEK CAPITAL LETTER OMICRON
       (?\u039F ("OMICRON" ,@all))

       ;; Pi

       ;; 03C0 蟺 GREEK SMALL LETTER PI
       (?\u03C0 ("pi" ,@all)
                ("M_PI" c c++))
       ;; 03A0 螤 GREEK CAPITAL LETTER PI
       (?\u03A0 ("PI" ,@all))

       ;; Rho

       ;; 03C1 蟻 GREEK SMALL LETTER RHO
       (?\u03C1 ("rho" ,@all))
       ;; 03A1 巍 GREEK CAPITAL LETTER RHO
       (?\u03A1 ("RHO" ,@all))

       ;; Sigma

       ;; 03C3 蟽 GREEK SMALL LETTER SIGMA
       (?\u03C3 ("sigma" ,@all))
       ;; 03A3 危 GREEK CAPITAL LETTER SIGMA
       (?\u03A3 ("SIGMA" ,@all))

       ;; Tau

       ;; 03C4 蟿 GREEK SMALL LETTER TAU
       (?\u03C4 ("tau" ,@all))
       ;; 03A4 韦 GREEK CAPITAL LETTER TAU
       (?\u03A4 ("TAU" ,@all))

       ;; Upsilon

       ;; 03C5 蠀 GREEK SMALL LETTER UPSILON
       (?\u03C5 ("upsilon" ,@all))
       ;; 03A5 违 GREEK CAPITAL LETTER UPSILON
       (?\u03A5 ("UPSILON" ,@all))

       ;; Phi

       ;; 03C6 蠁 GREEK SMALL LETTER PHI
       (?\u03C6 ("phi" ,@all))
       ;; 03A6 桅 GREEK CAPITAL LETTER PHI
       (?\u03A6 ("PHI" ,@all))

       ;; Chi

       ;; 03C7 蠂 GREEK SMALL LETTER CHI
       (?\u03C7 ("chi" ,@all))
       ;; 03A7 围 GREEK CAPITAL LETTER CHI
       (?\u03A7 ("CHI" ,@all))

       ;; Psi

       ;; 03C8 蠄 GREEK SMALL LETTER PSI
       (?\u03C8 ("psi" ,@all))
       ;; 03A8 唯 GREEK CAPITAL LETTER PSI
       (?\u03A8 ("PSI" ,@all))

       ;; Omega

       ;; 03C9 蠅 GREEK SMALL LETTER OMEGA
       (?\u03C9 ("omega" ,@all))
       ;; 03A9 惟 GREEK CAPITAL LETTER OMEGA
       (?\u03A9 ("OMEGA" ,@all))

       ;; Various Symbols

       ;; Value taken directly from `The Unicode Standard, Version 5.2' documented
       ;; in `U2000.pdf', located at http://unicode.org/charts/PDF/U2000.pdf
       ;; 2026 鈥� HORIZONTAL ELLIPSIS
       (?\u2026 ("..." scheme))

       ;; Value taken directly from `The Unicode Standard, Version 5.2' documented
       ;; in `U0080.pdf', located at http://unicode.org/charts/PDF/U0080.pdf
       ;; 00AC 卢 NOT SIGN
       (?\u00AC ("!"       c c++ perl sh)
                ("not"     ,@lispy haskell sml))

       )))
  "*List of pretty patterns.

Should be a list of the form ((MODE ((REGEXP . GLYPH) ...)) ...)")


(defun pretty-add-keywords (mode keywords)
  "Add pretty character KEYWORDS to MODE

MODE should be a symbol, the major mode command name, such as
`c-mode' or nil. If nil, pretty keywords are added to the current
buffer. KEYWORDS should be a list where each element has the
form (REGEXP . CHAR). REGEXP will be replaced with CHAR in the
relevant buffer(s)."
  (font-lock-add-keywords
   mode (mapcar (lambda (kw) `(,(car kw)
                          (0 (prog1 nil
                               (compose-region (match-beginning 0)
                                               (match-end 0)
                                               ,(cdr kw))))))
                keywords)))

(defun pretty-regexp (regexp glyph)
  "Replace REGEXP with GLYPH in buffer."
  (interactive "MRegexp to replace: 
MCharacter to replace with: ")
  (pretty-add-keywords nil `((,regexp . ,(string-to-char glyph))))
  (font-lock-fontify-buffer))




(provide 'pretty-mode)
