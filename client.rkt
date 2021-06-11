#lang racket/base

(provide jsonrpc-send!)

(require json
         net/url)

; send a jsexpr to a jsonrpc server, receive a jsexpr as response
;
; (jsonrpc-send! "http://127.0.0.1:8123/jsonrpc"
;                (hasheq 'method "JSONRPC.Introspect" 'jsonrpc "2.0" 'id "0"))
(define (jsonrpc-send! url payload)
  (read-json
   (post-pure-port (string->url url)
                   (string->bytes/utf-8 (jsexpr->string payload))
                   '("Content-Type: application/json"))))

(module+ main
  (jsonrpc-send!
   "http://localhost:4389/jsonrpc"
   (hasheq 'jsonrpc "2.0"
           'id "0"
           'method "initialize"
           'params (hasheq 'processId 0
                           'rootUri "file://Users/linzizhuan/dannypsnl/jsonrpc"
                           'capabilities (hasheq 'hoverProvider #t
                                                 'definitionProvider #t
                                                 'documentSymbolProvider #t
                                                 'documentLinkProvider #t
                                                 'documentFormattingProvider #t
                                                 'documentRangeFormattingProvider #t))))

  (jsonrpc-send!
   "http://localhost:4389/jsonrpc"
   (hasheq 'jsonrpc "2.0"
           'id "1"
           'method "textDocument/definition"
           'params (hasheq 'textDocument
                           (hasheq 'uri "file://Users/linzizhuan/dannypsnl/jsonrpc/test.go")
                           'position
                           (hasheq 'line 1
                                   'character 0)))))
