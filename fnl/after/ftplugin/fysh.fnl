; Add tree-sitter-fysh
(let [parser-config ((. (require :nvim-treesitter.parsers) :get_parser_configs))
      fysh-config {:install_info {:url "https://github.com/Fysh-Fyve/tree-sitter-fysh"
                                  :files [:src/parser.c]}
                   :filetype :fysh}]
  (set parser-config.fysh fysh-config))

(local client
       (vim.lsp.start_client {:name :fyshls
                              :cmd [:fyshls]
                              :on_attach (require :custom.on-attach)}))

(if (not client) (vim.notify "error creating client")
    (vim.lsp.buf_attach_client 0 client))
