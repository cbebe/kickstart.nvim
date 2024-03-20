;; NOTE: This is where your plugins related to LSP can be installed.
;;  The configuration is done below. Search for lspconfig to find it below.
{;; LSP Configuration & Plugins
 1 :neovim/nvim-lspconfig
 :dependencies [;; Automatically install LSPs to stdpath for neovim
                {1 :williamboman/mason.nvim :config true}
                :williamboman/mason-lspconfig.nvim
                ;; Useful status updates for LSP
                ;; NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
                {1 :j-hui/fidget.nvim :opts {}}
                ;; Additional lua configuration, makes nvim stuff amazing!
                :folke/neodev.nvim]}
