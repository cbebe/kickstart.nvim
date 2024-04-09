(λ on-attach [client ?bufnr]
  (let [on-attach (require :custom.on-attach)]
    ;; Disable semantic tokens
    (set client.server_capabilities.semanticTokensProvider nil)
    (on-attach client ?bufnr)))

(let [client (vim.lsp.start_client {:name :fyshls
                                    :cmd [:fyshls]
                                    :on_attach on-attach})]
  (if (not client) (vim.notify "error creating client")
      (vim.lsp.buf_attach_client 0 client)))

(λ install-ts-fysh [url]
  (let [parser-config ((. (require :nvim-treesitter.parsers)
                          :get_parser_configs))
        fysh-config {:install_info {: url
                                    :files [:src/parser.c :src/scanner.c]}
                     :filetype :fysh}]
    (set parser-config.fysh fysh-config)))

; Add tree-sitter-fysh
(install-ts-fysh "https://github.com/Fysh-Fyve/tree-sitter-fysh")

(λ use-fysh []
  ;; Install local Fysh grammar (for development)
  (install-ts-fysh :/home/chrlz/work/tree-sitter-fysh)
  (vim.cmd "TSInstall! fysh"))

(vim.api.nvim_buf_create_user_command 0 :LocalTS use-fysh
                                      {:desc "Install local tree-sitter"})

(set vim.opt_local.commentstring "><//>%s")
(let [ft (require :Comment.ft)] (ft.set :fysh ["><//>%s" "></*>%s<*/><"]))
