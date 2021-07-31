#lang racket/base

(provide success-response
         error-response)

(define (success-response id result)
  (hasheq 'jsonrpc "2.0"
          'id id
          'result result))

(define (error-response id code message [data not-given])
  (define err (hasheq 'code code
                      'message message))
  (define err* (if (eq? data not-given)
                   err
                   (hash-set err 'data data)))
  (hasheq 'jsonrpc "2.0"
          'id id
          'error err*))

(define not-given (gensym 'not-given))