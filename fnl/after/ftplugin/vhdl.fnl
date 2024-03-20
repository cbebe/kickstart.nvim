(λ is-tb [file] (= (file:sub -3) :_tb))

(set _G.vhdl_pos (match _G.vhdl_pos nil {} p p))

(λ switch-file []
  (let [file (vim.fn.expand "%:t:r")
        go-to (if (is-tb file) [:rtl/core/ (file:sub 0 (- (length file) 3))]
                  [:rtl/test/ (.. file :_tb)])
        go-to-key (. go-to 2)
        go-to-file (.. (. go-to 1) (. go-to 2) :.vhd)
        save-cursor (vim.fn.getpos ".")
        next-cursor (match (. _G.vhdl_pos go-to-key)
                      nil save-cursor
                      nc nc)]
    (tset _G.vhdl_pos file save-cursor)
    (vim.cmd.edit go-to-file)
    (vim.fn.setpos "." next-cursor)))

(vim.keymap.set [:n] :<leader>dd switch-file
                {:desc "Open [I]mplementation" :buffer true})

(λ run-test []
  (let [file (vim.fn.expand "%:t:r")
        test-bench (if (is-tb file) file (.. file :_tb))]
    (vim.cmd.write)
    (vim.cmd (.. "!make " test-bench))))

(vim.keymap.set [:n] :<leader>t run-test {:desc "[T]est file" :buffer true})

(λ fmt []
  (vim.cmd.write)
  (vim.cmd "!emacs -batch % -f vhdl-beautify-buffer -f save-buffer"))

(vim.api.nvim_buf_create_user_command 0 :EFormat fmt
                                      {:desc "Format VHDL with Emacs"})

(let [parsers (require :nvim-treesitter.parsers)
      parser-configs (parsers.get_parser_configs)
      config {:install_info {:url "https://github.com/alemuller/tree-sitter-vhdl"
                             :files [:src/parser.c]
                             :branch :main}}]
  (set parser-configs.vhdl config))

(vim.keymap.set [:n] :<leader>I
                "ouse std.textio.all;<CR>variable l : line;<Esc>"
                {:desc "Pr[I]nt" :buffer true})

(vim.keymap.set [:n] :<leader>i
                "biwrite(l, <esc>A);<esc>yypkf,wistring'(\"<esc>ea: \")<esc>jowriteline(output, l);<esc>"
                {:desc "[I]nspect variable" :buffer true})
