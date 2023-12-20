(vim.keymap.set [:n] :<leader>t ":w | !./util/test.py %<CR>"
                {:desc "[T]est Kattis" :buffer true})

(vim.keymap.set [:n] :<leader>x ":w | !python %<CR>"
                {:desc "E[X]ecute script" :buffer true})

(λ run_as_module []
   (let [py_file (vim.fn.expand :%)
         no_py (vim.fn.substitute py_file ".py" "" "")
         no_back (vim.fn.substitute no_py "/" "." "g")
         no_front (vim.fn.substitute no_back "\\" "." "g")
         cmd (.. "python -m " no_front)
         output (vim.fn.system cmd)]
     (vim.api.nvim_echo [[output]] false {})))

(vim.keymap.set [:n] :<leader>m run_as_module
                {:desc "Execute as [M]odule" :buffer true})
