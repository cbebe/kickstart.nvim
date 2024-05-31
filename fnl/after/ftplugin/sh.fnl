(vim.keymap.set [:n] :<leader>x (.. ":!" (vim.fn.expand "%:p") :<CR>)
                {:desc "E[x]ecute" :buffer true})
