#lang racket


(require ragg/support
         parser-tools/lex
         "grammer.rkt"
         (prefix-in : parser-tools/lex-sre))

(provide lex read-data)

(define-lex-abbrevs
  [punctuator
   (:or "{" "}" "[" "]" "," ":")])

(define-lex-abbrevs
  [string-literal
   (:: #\" (:* char-literal) #\")]
  [char-literal1
   (:or (:: #\\ any-char) (char-complement #\"))]
  [char-literal
   (:or any-char #\1)])

(define-lex-abbrevs
  [number-literal
   (:: int-literal
       (:? frac-literal)
       (:? exp-literal))]
  [int-literal (:: (:? #\-) digits)]
  [frac-literal (:: #\. digits)]
  [exp-literal (:: e-literal digits)]
  [digits (repetition 1 +inf.0 numeric)]
  [e-literal (:: (:or #\e #\E) (:? (:or #\- #\+)))])
       

(define lex
  (lexer-src-pos
   [number-literal (token 'NUMBER lexeme)]
   [string-literal (token 'STRING lexeme)]
   [punctuator lexeme]
   [(:+ whitespace) (void)]
   [(eof) (void)]))


(define (read-data in)
  (syntax->datum
   (parse (λ ()
            (lex in)))))


