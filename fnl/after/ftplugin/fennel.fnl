(λ get-lua-file [fnl_file]
  (let [s vim.fn.substitute]
    (s (s (s (s fnl_file :fnl "" "") "/" "" "") "\\" "" "") :.fnl :.lua "")))

(λ open-lua-file []
  (let [bot-win (vim.api.nvim_get_current_win)
        fnl-buf (vim.api.nvim_get_current_buf)]
    (vim.cmd :split)
    (let [top-win (vim.api.nvim_get_current_win)
          lua-file (get-lua-file (vim.fn.expand "%:."))]
      (vim.api.nvim_set_current_win bot-win)
      (vim.cmd.edit lua-file)
      (vim.api.nvim_win_set_buf top-win fnl-buf))))

(vim.keymap.set [:n] :<leader>o open-lua-file
                {:desc "[O]pen Lua file" :buffer true})

(λ format-fennel []
  (let [save-cursor (vim.fn.getpos ".")]
    (vim.cmd "%!fnlfmt -")
    (vim.fn.setpos "." save-cursor)))

(vim.keymap.set [:n] :<leader>f format-fennel
                {:desc "[F]ormat fennel file" :buffer true})

(λ process-fnl-file []
  (let [fnl-file (vim.fn.expand "%:.")]
    (vim.cmd.write)
    (vim.cmd (.. "!make fmt-" fnl-file " " (get-lua-file fnl-file)))))

(vim.api.nvim_buf_create_user_command 0 :FnlProcess process-fnl-file
                                      {:desc "Formats and compiles fennel file"})

((require :custom.width) 2 true)
