; [[ Setting options ]]
; See `:help vim.o`
; NOTE: You can change these options as you wish!

; Set highlight on search
(set vim.o.hlsearch  false)

; Make line numbers default
(set vim.wo.number  true)
(set vim.wo.relativenumber  true)

; Enable mouse mode
(set vim.o.mouse  :a)

; Enable break indent
(set vim.o.breakindent  true)

; Save undo history
(set vim.o.undofile  true)

; Case-insensitive searching UNLESS \C or capital in search
(set vim.o.ignorecase  true)
(set vim.o.smartcase  true)

; Keep signcolumn on by default
(set vim.wo.signcolumn  :yes)

; Decrease update time
(set vim.o.updatetime  250)
(set vim.o.timeoutlen  300)

; Set completeopt to have a better completion experience
(set vim.o.completeopt  "menuone,noselect")

; NOTE: You should make sure your terminal supports this
(set vim.o.termguicolors  true)
