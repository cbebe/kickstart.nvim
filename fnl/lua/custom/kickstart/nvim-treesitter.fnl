{;; Highlight, edit, and navigate code
 1 :nvim-treesitter/nvim-treesitter
 :build ":TSUpdate"
 :dependencies [:nvim-treesitter/nvim-treesitter-textobjects
                {1 :nushell/tree-sitter-nu :build ":TSUpdate nu"}]}
