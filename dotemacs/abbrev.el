(define-abbrev-table 'c-mode-abbrev-table ()
  "Abbrev table for c mode."
  :case-fixed t
  :regexp "\\<\\(\\w+\\)[ 	]*$"
  :enable-function (lambda ()
		     (not (nth 8 (syntax-ppss (point))))
		     )
  )

(define-abbrev-table 'c++-mode-abbrev-table ()
  "Abbrev table for c++ mode."
  :case-fixed t
  :regexp "\\<\\(\\w+\\)[ 	]*$"
  :enable-function (lambda ()
		     (not (nth 8 (syntax-ppss (point))))
		     )
  )

(define-abbrev-table 'java-mode-abbrev-table ()
  "Abbrev table for java mode."
  :case-fixed t
  :regexp "\\<\\(\\w+\\)[ 	]*$"
  :enable-function (lambda ()
		     (not (nth 8 (syntax-ppss (point))))
		     )
  )

(define-skeleton skeleton-log-func
  "generate int main(int argc, char * argc[]) automatic" nil
  >"Log.e (\"sunway\","_");")

(define-abbrev-table 'java-mode-abbrev-table '(
    ("log" "" skeleton-log-func 1)
    ))

(define-skeleton skeleton-c-mode-main-func
  "generate int main(int argc, char * argc[]) automatic" nil
  >"int\nmain (int argc, char * argv[]) {" \n _ \n \n
  "return 0;" \n
  -4"}")

(define-abbrev-table 'c-mode-abbrev-table '(
    ("main" "" skeleton-c-mode-main-func 1)
    ))
(define-abbrev-table 'c++-mode-abbrev-table '(
    ("main" "" skeleton-c-mode-main-func 1)
    ))

(define-skeleton skeleton-java-mode-main-func
  "generate int main(int argc, char * argc[]) automatic" nil
  >"public static void main(String [] args) {" \n _ \n \n
  -4"}")

(define-abbrev-table 'java-mode-abbrev-table '(
    ("main" "" skeleton-java-mode-main-func 1)
    ))
(define-skeleton skeleton-c-mode-fori
  "fori" "Boundary? "
  >"for (int i=0; i<"str"; ++i) {" \n \n
  -4 "} "
 )

(define-abbrev-table 'c-mode-abbrev-table '(
    ("fori" "" skeleton-c-mode-fori 1)
    )
  )
(define-abbrev-table 'c++-mode-abbrev-table '(
    ("fori" "" skeleton-c-mode-fori 1)
    ))
(define-abbrev-table 'java-mode-abbrev-table '(
    ("fori" "" skeleton-c-mode-fori 1)
    )
  )


(define-skeleton skeleton-c-mode-for
  "if" nil
  >"for ("_") {" \n \n
  -4 "} "
 )

(define-abbrev-table 'c-mode-abbrev-table '(
    ("for" "" skeleton-c-mode-for 1)
    )
  )
(define-abbrev-table 'c++-mode-abbrev-table '(
    ("for" "" skeleton-c-mode-for 1)
    ))
(define-abbrev-table 'java-mode-abbrev-table '(
    ("for" "" skeleton-c-mode-for 1)
    )
  )
(define-skeleton skeleton-c-mode-inc
  "inc" nil
  >"#include "_ \n \n
 )
(define-abbrev-table 'c-mode-abbrev-table '(
    ("inc" "" skeleton-c-mode-inc 1)
    )
  )
(define-abbrev-table 'c++-mode-abbrev-table '(
    ("inc" "" skeleton-c-mode-inc 1)
    )
  )

(define-skeleton skeleton-c-mode-if
  "if" nil
  >"if ("_") {" \n \n
  -4 "} "
 )
(define-abbrev-table 'c-mode-abbrev-table '(
    ("if" "" skeleton-c-mode-if 1)
    )
  )
(define-abbrev-table 'c++-mode-abbrev-table '(
    ("if" "" skeleton-c-mode-if 1)
    ))
(define-abbrev-table 'java-mode-abbrev-table '(
    ("if" "" skeleton-c-mode-if 1)
    )
  )
(define-skeleton skeleton-c-mode-ife
  "if" nil
  >"if ("_") {" \n \n
  -4 "} else {" \n \n
  -4 "}" \n \n
)
(define-abbrev-table 'c-mode-abbrev-table '(
    ("ife" "" skeleton-c-mode-ife 1)
    ))
(define-abbrev-table 'c++-mode-abbrev-table '(
    ("ife" "" skeleton-c-mode-ife 1)
    ))
(define-abbrev-table 'java-mode-abbrev-table '(
    ("ife" "" skeleton-c-mode-ife 1)
    ))
(define-skeleton skeleton-c-mode-else
  "if" nil
  >"else {" \n _ \n
  -4 "}" \n
)

(define-abbrev-table 'c-mode-abbrev-table '(
    ("else" "" skeleton-c-mode-else 1)
    ))
(define-abbrev-table 'c++-mode-abbrev-table '(
    ("else" "" skeleton-c-mode-else 1)
    ))
(define-abbrev-table 'java-mode-abbrev-table '(
    ("else" "" skeleton-c-mode-else 1)
    ))
(define-skeleton skeleton-c-mode-elif
  "if" nil
  >"else if ("_") {" \n \n
  -4 "} "
)

(define-abbrev-table 'c-mode-abbrev-table '(
    ("elif" "" skeleton-c-mode-elif 1)
    ))
(define-abbrev-table 'c++-mode-abbrev-table '(
    ("elif" "" skeleton-c-mode-elif 1)
    ))
(define-abbrev-table 'java-mode-abbrev-table '(
    ("elif" "" skeleton-c-mode-elif 1)
    ))
(define-skeleton skeleton-c-mode-while
  "for" nil
  >"while ("_") {" \n \n
  -4 "}" \n \n)

(define-abbrev-table 'c-mode-abbrev-table '(
    ("while" "" skeleton-c-mode-while 1)
    ))

(define-abbrev-table 'c++-mode-abbrev-table '(
    ("while" "" skeleton-c-mode-while 1)
    ))
(define-abbrev-table 'java-mode-abbrev-table '(
    ("while" "" skeleton-c-mode-while 1)
    ))
(define-skeleton skeleton-c-mode-do
  "do" nil
  >"do {" \n _ \n  \n -4 "} while ();" \n \n
  )

(define-abbrev-table 'c-mode-abbrev-table '(
    ("do" "" skeleton-c-mode-do 1)
    ))
(define-abbrev-table 'c++-mode-abbrev-table '(
    ("do" "" skeleton-c-mode-do 1)
    ))
(define-abbrev-table 'java-mode-abbrev-table '(
    ("do" "" skeleton-c-mode-do 1)
    ))
(define-skeleton skeleton-c-mode-switch
  "for" nil
  >"switch ("_") {" \n -4 \n -4 \n
  -4"default:" \n "break;" \n
  -4"}" \n \n)
(define-abbrev-table 'c-mode-abbrev-table '(
    ("switch" "" skeleton-c-mode-switch 1)
    ))
(define-abbrev-table 'c++-mode-abbrev-table '(
    ("switch" "" skeleton-c-mode-switch 1)
    ))
(define-abbrev-table 'java-mode-abbrev-table '(
    ("switch" "" skeleton-c-mode-switch 1)
    ))
(define-skeleton skeleton-c-mode-case
  "case" nil
  "case "_":" \n \n
  "break;" \n -4 \n)

(define-abbrev-table 'c-mode-abbrev-table '(
    ("case" "" skeleton-c-mode-case 1)
    ))
(define-abbrev-table 'c++-mode-abbrev-table '(
    ("case" "" skeleton-c-mode-case 1)
    ))
(define-abbrev-table 'java-mode-abbrev-table '(
    ("case" "" skeleton-c-mode-case 1)
    ))
;; (define-skeleton skeleton-c-mode-struct
;;   "case" nil
;;   >"struct "_" {" \n \n \n
;;   -4 "};" \n \n)
;; (define-abbrev-table 'c-mode-abbrev-table '(
;;     ("struct" "" skeleton-c-mode-struct 1)
;;     ))
;; (define-abbrev-table 'c++-mode-abbrev-table '(
;;     ("struct" "" skeleton-c-mode-struct 1)
;;     ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-skeleton skeleton-c++-mode-try
  "try" nil
  > "try {" \n _ \n
  -4 "} catch (Exception e) {" \n \n
  -4 "} " \n)
(define-abbrev-table 'c++-mode-abbrev-table '(
    ("try" "" skeleton-c++-mode-try 1)
    ))
(define-abbrev-table 'java-mode-abbrev-table '(
    ("try" "" skeleton-c++-mode-try 1)
    ))

(define-skeleton skeleton-c++-mode-catch
  "try" nil
  > "catch ("_") {" \n \n \n
  -4 "} " \n \n)
(define-abbrev-table 'c++-mode-abbrev-table '(
    ("catch" "" skeleton-c++-mode-catch 1)
    ))
(define-abbrev-table 'java-mode-abbrev-table '(
    ("catch" "" skeleton-c++-mode-catch 1)
    ))

;; (define-skeleton skeleton-c++-mode-class
;;   "class" nil
;;   > "class "_" {" \n \n \n
;;   -4 "public:" \n \n \n
;;   -4 "};" \n \n)
;; (define-abbrev-table 'c++-mode-abbrev-table '(
;;     ("class" "" skeleton-c++-mode-class 1)
;;     ))
;; (define-abbrev-table 'java-mode-abbrev-table '(
;;     ("class" "" skeleton-c++-mode-class 1)
;;     ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-abbrev-table 'sh-mode-abbrev-table ()
  "Abbrev table for c mode."
  :case-fixed t
  :regexp "\\<\\(\\w+\\)[ 	]*$"
  :enable-function (lambda ()
		     (not (nth 8 (syntax-ppss (point))))
		     )
  )


(define-skeleton skeleton-sh-mode-if
  "if" nil
  >"if [[ "_" ]]; then" \n
  >""\n
  -4"fi"
 )

(define-abbrev-table 'sh-mode-abbrev-table '(
    ("if" "" skeleton-sh-mode-if 1)
    )
  )

(define-skeleton skeleton-sh-mode-for
  "for" nil
  >"for i in "_"; do" \n
  >""\n
  -4"done"
 )

(define-abbrev-table 'sh-mode-abbrev-table '(
    ("for" "" skeleton-sh-mode-for 1)
    )
  )

(define-skeleton skeleton-sh-mode-while
  "while" nil
  >"while [[ "_" ]]; do" \n
  >""\n
  -4"done"
 )

(define-abbrev-table 'sh-mode-abbrev-table '(
    ("while" "" skeleton-sh-mode-while 1)
    )
  )

(define-skeleton skeleton-sh-mode-until
  "until" nil
  >"until [[ "_" ]]; do" \n
  >""\n
  -4"done"
 )

(define-abbrev-table 'sh-mode-abbrev-table '(
    ("until" "" skeleton-sh-mode-until 1)
    )
  )

(define-skeleton skeleton-sh-mode-case
  "case" nil
  >"case \"$i\" in"\n
  > _ \n
  >"*) ;;" \n
  -4"esac"
 )

(define-abbrev-table 'sh-mode-abbrev-table '(
    ("case" "" skeleton-sh-mode-case 1)
    )
  )

(define-skeleton skeleton-sh-mode-func
  "func" nil
  >"function " _ " {"\n
  >"" \n
  -4"}"
 )

(define-abbrev-table 'sh-mode-abbrev-table '(
    ("function" "" skeleton-sh-mode-func 1)
    )
  )

(define-skeleton skeleton-java-mode-cursor
  "cursor" "Boundary? "
  >"try {\n"
  >"if (cursor.moveToFirst()) {"\n
  >"do {"\n _ \n
  -4"} while (cursor.moveToNext());"\n
  -4"}"\n
  -4"} finally {"\n
  >"cursor.close();"\n
  -4"}"
 )


(define-abbrev-table 'java-mode-abbrev-table '(
    ("csor" "" skeleton-java-mode-cursor 1)
    )
  )

(define-abbrev-table 'global-abbrev-table '(
    ("filer" "filter" nil 0)
    ("filed" "field" nil 0)
    ("thead" "thread" nil 0)
    ("unciode" "unicode" nil 0)
    )
  )
