((require :custom.width) 4 false)
(vim.keymap.set [:n] :<leader>x ":!go run %<CR>"
                {:desc "E[X]ecute file" :buffer true})

; Stolen from Prime
(vim.keymap.set [:n] :<leader>l "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
                {:desc "if err != ni[l]" :buffer true})

(vim.keymap.set [:n] :<leader>t ":w | !go test ./...<CR>"
                {:desc "[T]est all" :buffer true})
