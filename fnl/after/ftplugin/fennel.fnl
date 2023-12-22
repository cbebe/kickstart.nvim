(λ get_lua_file [fnl_file]
  (let [s vim.fn.substitute
        no_fnl (s (s (s fnl_file :fnl "" "") "/" "" "") "\\" "" "")]
    (s no_fnl :.fnl :.lua "")))

(λ open_lua_file []
  (let [right_win (vim.api.nvim_get_current_win)
        fnl_buf (vim.api.nvim_get_current_buf)]
    (vim.cmd :split)
    (let [left_win (vim.api.nvim_get_current_win)
          fnl_file (vim.fn.expand "%")
          lua_file (get_lua_file fnl_file)]
      (vim.api.nvim_set_current_win right_win)
      (vim.cmd.edit lua_file)
      (vim.api.nvim_win_set_buf left_win fnl_buf))))

(vim.keymap.set [:n] :<leader>f open_lua_file
                {:desc "Open Lua [F]ile" :buffer true})

(λ process_fnl_file []
  (let [fnl_file (vim.fn.expand "%")]
    (vim.cmd.write)
    (vim.cmd (.. "!make fmt-" fnl_file " " (get_lua_file fnl_file)))))

(vim.api.nvim_buf_create_user_command 0 :FnlProcess process_fnl_file
                                      {:desc "Formats and compiles fennel file"})

(tset vim.opt_local :shiftwidth 2)
(tset vim.opt_local :tabstop 2)
(tset vim.opt_local :softtabstop 2)
(tset vim.opt_local :expandtab true)
