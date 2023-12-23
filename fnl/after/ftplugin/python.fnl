(vim.keymap.set [:n] :<leader>t ":w | !./util/test.py %<CR>"
                {:desc "[T]est Kattis" :buffer true})

(vim.keymap.set [:n] :<leader>x ":w | !python %<CR>"
                {:desc "E[X]ecute script" :buffer true})

(λ run_as_module []
  (let [s vim.fn.substitute
        mod (s (s (s (vim.fn.expand "%") :.py "" "") "/" "." :g) "\\" "." :g)
        output (vim.fn.system (.. "python -m " mod))]
    (vim.api.nvim_echo [[output]] false {})))

(vim.keymap.set [:n] :<leader>m run_as_module
                {:desc "Execute as [M]odule" :buffer true})
