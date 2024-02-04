(set vim.opt_local.shiftwidth 2)
(set vim.opt_local.tabstop 2)
(set vim.opt_local.softtabstop 2)
(set vim.opt_local.expandtab true)

(λ format_js []
  (let [save_cursor (vim.fn.getpos ".")]
    (vim.cmd "%!deno fmt --ext js -")
    (vim.fn.setpos "." save_cursor)))

(vim.keymap.set [:n] :<leader>f format_js
                {:desc "[F]ormat buffer" :buffer true})

(λ generate []
  (when (= (vim.fn.expand "%:t") :grammar.js)
    (vim.keymap.set [:n] :<leader>t
                    ":!tree-sitter generate && tree-sitter test<CR>"
                    {:desc "Test [T]ree-sitter parser" :buffer true})))

(let [grp (vim.api.nvim_create_augroup :GrammarJS {:clear true})
      au vim.api.nvim_create_autocmd]
  (au :BufEnter {:callback generate :group grp}))
