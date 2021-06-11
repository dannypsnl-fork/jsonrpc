#lang racket

(require "client.rkt")

; go install github.com/sourcegraph/go-langserver@latest
; command: go-langserver -mode tcp

(jsonrpc-send!
 "http://127.0.0.1:4389/jsonrpc"
 (hasheq 'jsonrpc "2.0"
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
 "http://127.0.0.1:4389/jsonrpc"
 (hasheq 'jsonrpc "2.0"
         'method "textDocument/definition"
         'params (hasheq 'textDocument
                         (hasheq 'uri "file://Users/linzizhuan/dannypsnl/jsonrpc/test.go")
                         'position
                         (hasheq 'line 1
                                 'character 0))))
