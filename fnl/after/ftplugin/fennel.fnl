(λ get_lua_file [fnl_file]
  (let [s vim.fn.substitute]
    (s (s (s (s fnl_file :fnl "" "") "/" "" "") "\\" "" "") :.fnl :.lua "")))

(λ open_lua_file []
  (let [bot_win (vim.api.nvim_get_current_win)
        fnl_buf (vim.api.nvim_get_current_buf)]
    (vim.cmd :split)
    (let [top_win (vim.api.nvim_get_current_win)
          lua_file (get_lua_file (vim.fn.expand "%:."))]
      (vim.api.nvim_set_current_win bot_win)
      (vim.cmd.edit lua_file)
      (vim.api.nvim_win_set_buf top_win fnl_buf))))

(vim.keymap.set [:n] :<leader>o open_lua_file
                {:desc "[O]pen Lua file" :buffer true})

(λ format_fennel []
  (let [save_cursor (vim.fn.getpos ".")]
    (vim.cmd "%!fnlfmt -")
    (vim.fn.setpos "." save_cursor)))

(vim.keymap.set [:n] :<leader>f format_fennel
                {:desc "[F]ormat fennel file" :buffer true})

(λ process_fnl_file []
  (let [fnl_file (vim.fn.expand "%:.")]
    (vim.cmd.write)
    (vim.cmd (.. "!make fmt-" fnl_file " " (get_lua_file fnl_file)))))

(vim.api.nvim_buf_create_user_command 0 :FnlProcess process_fnl_file
                                      {:desc "Formats and compiles fennel file"})

(set vim.opt_local.shiftwidth 2)
(set vim.opt_local.tabstop 2)
(set vim.opt_local.softtabstop 2)
(set vim.opt_local.expandtab true)
