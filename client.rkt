#lang racket/base

(provide jsonrpc-send!)

(require json
         net/url)

; send a jsexpr to a jsonrpc server, receive a jsexpr as response
;
; (jsonrpc-send! "http://127.0.0.1:8123/jsonrpc"
;                (hasheq 'method "JSONRPC.Introspect" 'jsonrpc "2.0" 'id "0"))
(define (jsonrpc-send! url payload)
  (string->jsexpr
   (read-line
    (post-pure-port (string->url url)
                    (string->bytes/utf-8 (jsexpr->string payload))
                    '("Content-Type: application/json")))))
