(λ is_tb [file] (= (file:sub -3) :_tb))

(set _G.vhdl_pos (match _G.vhdl_pos nil {} p p))

(λ switch_file []
  (let [file (vim.fn.expand "%:t:r")
        go_to (if (is_tb file) [:core/ (file:sub 0 (- (length file) 3))]
                  [:test/ (.. file :_tb)])
        go_to_key (. go_to 2)
        go_to_file (.. (. go_to 1) (. go_to 2) :.vhd)
        save_cursor (vim.fn.getpos ".")
        next_cursor (match (. _G.vhdl_pos go_to_key)
                      nil save_cursor
                      nc nc)]
    (tset _G.vhdl_pos file save_cursor)
    (vim.cmd.edit go_to_file)
    (vim.fn.setpos "." next_cursor)))

(vim.keymap.set [:n] :<leader>i switch_file
                {:desc "Open [I]mplementation" :buffer true})

(λ run_test []
  (let [file (vim.fn.expand "%:t:r")
        test_bench (if (is_tb file) file (.. file :_tb))]
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
