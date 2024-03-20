(λ config []
  (let [context (require :treesitter-context)]
    (context.setup {})
    (vim.cmd "highlight TreesitterContextBottom gui=underline guisp=Grey")))

{1 :nvim-treesitter/nvim-treesitter-context
 :dependencies [:nvim-treesitter/nvim-treesitter]
 : config}
