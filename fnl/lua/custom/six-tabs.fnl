(local current {:sw vim.opt_local.shiftwidth
                :ts vim.opt_local.tabstop
                :sts vim.opt_local.softtabstop
                :et vim.opt_local.expandtab})

(var is_six false)
(λ toggle_tabs []
  (if is_six
      (let []
        (set vim.opt_local.shiftwidth current.sw)
        (set vim.opt_local.tabstop current.ts)
        (set vim.opt_local.softtabstop current.sts)
        (set vim.opt_local.expandtab current.et))
      (let []
        (set current.sw vim.opt_local.shiftwidth)
        (set current.ts vim.opt_local.tabstop)
        (set current.sts vim.opt_local.softtabstop)
        (set current.et vim.opt_local.expandtab)
        (set vim.opt_local.shiftwidth 6)
        (set vim.opt_local.tabstop 6)
        (set vim.opt_local.softtabstop 6)
        (set vim.opt_local.expandtab false)))
  (set is_six (not is_six)))

(vim.api.nvim_create_user_command :ToggleTabs toggle_tabs
                                  {:desc "Toggles tabs to 6 spaces"})
