(λ run_test []
  (let [file (vim.fn.expand "%:t:r")
        test_bench (if (= (file:sub -3) :_tb) file (.. file :_tb))]
    (vim.cmd.write)
    (vim.cmd (.. "!make " test_bench))))

(vim.keymap.set [:n] :<leader>t run_test {:desc "[T]est file" :buffer true})

(λ fmt []
  (vim.cmd.write)
  (vim.cmd "!emacs -batch % -f vhdl-beautify-buffer -f save-buffer"))

(vim.api.nvim_buf_create_user_command 0 :EFormat fmt
                                      {:desc "Format VHDL with Emacs"})

(let [parsers (require :nvim-treesitter.parsers)
      parser_configs (parsers.get_parser_configs)
      config {:install_info {:url "https://github.com/alemuller/tree-sitter-vhdl"
                             :files [:src/parser.c]
                             :branch :main}}]
  (set parser_configs.vhdl config))
