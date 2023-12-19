(set vim.wo.colorcolumn "80,100")

(λ load_catppuccin []
  (let [catppuccin (require :catppuccin)]
    (catppuccin.setup {:flavour :mocha :transparent_background true}))
  (vim.cmd.colorscheme :catppuccin) ; Disable startup screen
  (vim.opt.shortmess:append {:I true}))

; (vim.cmd.colorscheme :onedark)
(load_catppuccin)

{}
