; Add tree-sitter-fysh
(let [parser-config ((. (require :nvim-treesitter.parsers) :get_parser_configs))
      fysh-config {:install_info {:url "https://github.com/Fysh-Fyve/tree-sitter-fysh"
                                  :files [:src/parser.c :src/scanner.c]}
                   :filetype :fysh}]
  (set parser-config.fysh fysh-config))

(local client
       (vim.lsp.start_client {:name :fyshls
                              :cmd [:fyshls]
                              :on_attach (require :custom.on-attach)}))

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
