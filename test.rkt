#lang racket

(require json)
(require ragg/support
         parser-tools/lex
         "lex.rkt"
         "parser.rkt")




(define (test-parser str)
  (parse (get-jdata str)))


(test-parser "{\"a\":1,\"b\":2}")
(test-parser "1")
(test-parser "\"shit\"")
(test-parser "[1,2,3]")


;; problem with whitespaces
(define in1 (open-input-string "[1,2]"))
(define in2 (open-input-string "[1, 2]"))

(for ([i (range 1 8)])
  (displayln i)
  (displayln (lex in1))
  (displayln (lex in2)))


