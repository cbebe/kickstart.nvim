(local t [:nvim-treesitter/nvim-treesitter-context])
(set t.dependencies [:nvim-treesitter/nvim-treesitter])

(λ config []
  (let [context (require :treesitter-context)]
    (context.setup {})
    (vim.cmd "highlight TreesitterContextBottom gui=underline guisp=Grey")))

(set t.config config)

t
