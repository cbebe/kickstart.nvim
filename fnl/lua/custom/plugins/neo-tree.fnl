(local t [:nvim-neo-tree/neo-tree.nvim])
(set t.branch :v3.x)
(set t.dependencies [:nvim-lua/plenary.nvim
                     ; :nvim-tree/nvim-web-devicons
                     :MunifTanjim/nui.nvim])

(set t.config
     (λ []
       (vim.keymap.set [:n] :<leader>e ":Neotree toggle<CR>"
                       {:desc "Toggle Neotree [E]xplorer" :silent true})))

t
