; [[ Basic Keymaps ]]

; Keymaps for better default experience
; See `:help vim.keymap.set()`

(vim.keymap.set [:n :v] :<Space> :<Nop> {:silent true})

; Sync clipboard between OS and Neovim.
;  Remove this option if you want your OS clipboard to remain independent.
;  See `:help 'clipboard'`
; This is too slow!!
; (set vim.o.clipboard :unnamedplus)
(vim.keymap.set [:x] :Y "\"+y" {:silent true})
(vim.keymap.set [:n :v :x] :<leader>p "\"+p" {:silent true})
(vim.keymap.set [:n :v :x] :<leader>P "\"+P" {:silent true})

; Remap for dealing with word wrap
; (vim.keymap.set :n :k "v:count == 0 ? 'gk' : 'k'" {:expr true :silent true})
; (vim.keymap.set :n :j "v:count == 0 ? 'gj' : 'j'" {:expr true :silent true})

; Diagnostic keymaps
(vim.keymap.set :n "[d" vim.diagnostic.goto_prev
                {:desc "Go to previous diagnostic message"})

(vim.keymap.set :n "]d" vim.diagnostic.goto_next
                {:desc "Go to next diagnostic message"})

(vim.keymap.set :n :<leader>E vim.diagnostic.open_float
                {:desc "Open floating diagnostic message"})

(vim.keymap.set :n :<leader>q vim.diagnostic.setloclist
                {:desc "Open diagnostics list"})

; [[ Highlight on yank ]]
; See `:help vim.highlight.on_yank()`
(local highlight_group
       (vim.api.nvim_create_augroup :YankHighlight {:clear true}))

(vim.api.nvim_create_autocmd :TextYankPost
                             {:callback (λ [] (vim.highlight.on_yank))
                              :group highlight_group
                              :pattern "*"})
