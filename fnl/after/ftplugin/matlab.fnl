(vim.keymap.set [:n] :<leader>f ":w | silent exec \"!mh_style --fix %\"<CR>"
                {:desc "[F]ormat MATLAB file with MISS_HIT" :buffer true})
