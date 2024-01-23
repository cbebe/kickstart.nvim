(set vim.opt_local.shiftwidth 4)
(set vim.opt_local.tabstop 4)
(set vim.opt_local.softtabstop 4)
(set vim.opt_local.expandtab false)
(vim.keymap.set [:n] :<leader>x ":!go run %<CR>"
                {:desc "E[X]ecute file" :buffer true})

; Stolen from Prime
(vim.keymap.set [:n] :<leader>l "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
                {:desc "if err != ni[l]" :buffer true})
