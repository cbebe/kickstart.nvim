; Add tree-sitter-fysh
(let [parser-config ((. (require :nvim-treesitter.parsers) :get_parser_configs))
      fysh-config {:install_info {:url "https://github.com/Fysh-Fyve/tree-sitter-fysh"
                                  :files [:src/parser.c]}
                   :filetype :fysh}]
  (set parser-config.fysh fysh-config))
