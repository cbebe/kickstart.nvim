{1 :nvim-neo-tree/neo-tree.nvim
 :branch :v3.x
 :cmd [:Neotree "Neotree toggle"]
 :keys [:<leader>e]
 :dependencies [:nvim-lua/plenary.nvim
                ; :nvim-tree/nvim-web-devicons
                :MunifTanjim/nui.nvim]
 :config (λ []
           (vim.keymap.set [:n] :<leader>e ":Neotree toggle<CR>"
                           {:desc "Toggle Neotree [E]xplorer" :silent true}))}
