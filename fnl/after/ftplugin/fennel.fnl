(vim.keymap.set [:n] :<leader>f
                (fn []
                  (let [right_win (vim.api.nvim_get_current_win)
                        fnl_buf (vim.api.nvim_get_current_buf)]
                    (vim.cmd :split)
                    (let [left_win (vim.api.nvim_get_current_win)
                          fnl_file (vim.fn.expand "%")
                          lua_file (vim.fn.substitute (vim.fn.substitute fnl_file
                                                                         :fnl/
                                                                         "" "")
                                                      :.fnl :.lua "")]
                      (vim.api.nvim_set_current_win right_win)
                      (vim.cmd.edit lua_file)
                      (vim.api.nvim_win_set_buf left_win fnl_buf)
                      (vim.api.nvim_set_current_win left_win))))
                {:desc "Open Lua [F]ile"})

(fn process_fnl_file []
  (let [fnl_file (vim.fn.expand "%")]
    (vim.cmd.write)
    (vim.cmd (.. "!make fmt-" fnl_file " " (get_lua_file fnl_file)))))

(vim.api.nvim_buf_create_user_command 0 :FnlProcess process_fnl_file
                                      {:desc "Formats and compiles fennel file"})

(tset vim.opt_local :shiftwidth 2)
(tset vim.opt_local :tabstop 2)
(tset vim.opt_local :softtabstop 2)
(tset vim.opt_local :expandtab true)
