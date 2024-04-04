; Add tree-sitter-fysh
(let [parser-config ((. (require :nvim-treesitter.parsers) :get_parser_configs))
      fysh-config {:install_info {:url "https://github.com/Fysh-Fyve/tree-sitter-fysh"
                                  :files [:src/parser.c :src/scanner.c]}
                   :filetype :fysh}]
  (set parser-config.fysh fysh-config))

(λ on-attach [client ?bufnr]
  (let [on-attach (require :custom.on-attach)]
    ;; Disable semantic tokens
    (set client.server_capabilities.semanticTokensProvider nil)
    (on-attach client ?bufnr)))

(local client (vim.lsp.start_client {:name :fyshls
                                     :cmd [:fyshls]
                                     :on_attach on-attach}))

(if (not client) (vim.notify "error creating client")
    (vim.lsp.buf_attach_client 0 client))

(λ use_fysh []
  (let [parser-config ((. (require :nvim-treesitter.parsers)
                          :get_parser_configs))
        fysh-config {:install_info {:url :/home/chrlz/work/tree-sitter-fysh
                                    :files [:src/parser.c :src/scanner.c]}
                     :filetype :fysh}]
    (set parser-config.fysh fysh-config))
  (vim.cmd "TSInstall! fysh"))

(vim.api.nvim_buf_create_user_command 0 :LocalTS use_fysh
                                      {:desc "Install local tree-sitter"})

(set vim.opt_local.commentstring "><//>%s")
(let [ft (require :Comment.ft)] (ft.set :fysh ["><//>%s" "></*>%s<*/><"]))
