(vim.keymap.set [:n] :<leader>f ":w | !deno fmt %<CR>"
                {:desc "[F]ormat buffer" :buffer true})
