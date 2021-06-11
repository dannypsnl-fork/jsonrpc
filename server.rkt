#lang racket

(require web-server/servlet-env
         web-server/http/request-structs
         web-server/http/json)

(define (start request)
  (define json (request-post-data/raw request))
  (cond
    [(hash? json)
     (response/jsexpr
      (hasheq 'jsonrpc "2.0"
              'id (hash-ref json 'id)
              'result '()))]
    [else
     (response/jsexpr
      (hasheq 'jsonrpc "2.0"
              'id "0"
              'result '()))]))

(module+ main
  (serve/servlet
   start
   #:port 4389
   #:servlet-path "/jsonrpc"))
