(vim.keymap.set [:n] :<leader>t ":w | !zig test %<CR>"
                {:desc "[T]est current file" :buffer true})

(vim.keymap.set [:n] :<leader>b "!zig build<CR>"
                {:desc "[B]uild current project" :buffer true})
