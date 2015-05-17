#lang racket

(require "lex.rkt")


(define (get-jdata str)
  (let ([in (open-input-string str)])
    (read-data in)))



(provide parse
         get-jdata)

(define (parse jd)
  (match jd
    [(list _ (list 'number n))
     (string->number n)]
    [(list _ (list 'string (regexp "\"([^\"]*)\"" s)))
     (second s)]
    [(list _ (list 'array "[" e ... "]")) (parse-array e)]
    [(list _ (list 'object "{" kv ... "}")) (parse-object kv)]))

(define (parse-array e)
  (foldr (λ (e i) 
           (if (list? e)
               (let ([v (parse e)])
                 (cons v i))
               (append i '())))
         '() 
         e))

(define (parse-object kv)
  (let ([parse-kv
         (λ (kv-pair)
           (match kv-pair
             [`(kvpair ,k ":" ,v) 
              (let* ([l (string-length k)]
                     [sk (string->symbol 
                          (substring k 1 (sub1 l)))])
                (cons sk (parse v)))]))])
    (make-hasheq
     (foldr (λ (e i)
           (if (list? e)
               (let ([v (parse-kv e)])
                 (cons v i))
               (append i '())))
           '()
           kv))))
