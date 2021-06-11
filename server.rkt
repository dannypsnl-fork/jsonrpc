#lang racket

(provide start)

(require web-server/servlet-env
         web-server/http/request-structs
         web-server/http/json
         json)

(define (start jsonrpc-handler)
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
       (displayln json)
       (response/jsexpr
        (hasheq 'jsonrpc "2.0"
                'id (hash-ref json 'id)
                'result (jsonrpc-handler (hash-ref json 'method)
                                         (hash-ref json 'params))))])))

(module+ main
  (define (user-handler method params)
    method)

  (serve/servlet
   (start user-handler)
   #:port 4389
   #:launch-browser? #f
   #:servlet-path "/jsonrpc"))
