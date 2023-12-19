(vim.api.nvim_create_user_command
  :AddPlugin
  (fn [opts]
    (vim.cmd.edit
      (vim.fn.resolve
        (.. "fnl/lua/custom/plugins/" (. opts :args) ".fnl"))))
  {:nargs 1})
