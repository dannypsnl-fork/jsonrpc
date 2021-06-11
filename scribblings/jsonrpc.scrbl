#lang scribble/manual

@require[@for-label[jsonrpc
                    racket/base]]

@title{jsonrpc}
@author{Lîm Tsú-thuàn}

@defmodule[jsonrpc]

@section{client}

@(racketblock
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
                                                 'documentRangeFormattingProvider #t)))))

@section{server}

@(racketblock
  (define (user-handler method params)
    method)

  (serve/servlet
   (jsonrpc-start user-handler)
   #:port 4389
   #:launch-browser? #f
   #:servlet-path "/jsonrpc"))
