#lang racket

(require "client.rkt")

; go install github.com/sourcegraph/go-langserver@latest
; command: go-langserver -mode tcp

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
