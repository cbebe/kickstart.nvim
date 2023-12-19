(vim.keymap.set [:n] :<leader>t ":w | !./util/test.py %<CR>"
                {:desc "[T]est Kattis" :buffer true})

(vim.keymap.set [:n] :<leader>x ":w | !python %<CR>"
                {:desc "E[X]ecute script" :buffer true})
