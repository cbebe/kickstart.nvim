(λ add_plugin [opts]
  (let [file (.. :fnl/lua/custom/plugins/ (. opts :args) :.fnl)]
    (vim.cmd.edit file)))

(vim.api.nvim_create_user_command :AddPlugin add_plugin {:nargs 1})
