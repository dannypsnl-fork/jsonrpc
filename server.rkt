#lang racket

(provide server-port
         jsonrpc-start)

(require web-server/servlet-env
         web-server/http/request-structs
         web-server/http/json
         json)

(define server-port (make-parameter 4389))

(define (jsonrpc-start jsonrpc-handler)
  (λ (request)
    (define json-str (request-post-data/raw request))
    (match json-str
      [#f
       (response/jsexpr
        (hasheq 'jsonrpc "2.0"
                'id "0"
                'result '()))]
      [json-str
       (define json (bytes->jsexpr json-str))
       (jsonrpc-handler (hash-ref json 'id)
                        (hash-ref json 'method)
                        (hash-ref json 'params))])))

(module+ main
  (require "response.rkt")

  (define (user-handler id method params)
    (success-response params))

  (serve/servlet
   (jsonrpc-start user-handler)
   #:port (server-port)
   #:launch-browser? #f
   #:servlet-path "/"))
