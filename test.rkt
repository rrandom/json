#lang racket

(require json)
(require ragg/support
         parser-tools/lex
         "lex.rkt")


(read-data (open-input-string "{\"a\":1}"))

;; problem with whitespace
(define in1 (open-input-string "[1,2]"))
(define in2 (open-input-string "[1, 2]"))

(for ([i '(1 2 3 4 5 6 7)])
  (displayln i)
  (displayln (lex in1))
  (displayln (lex in2)))



