((require :custom.width) 2 true)

((require :custom.formatter) "deno fmt --ext js -")

;; TS grammar auto-generate
(λ generate []
  (when (= (vim.fn.expand "%:t") :grammar.js)
    (vim.keymap.set [:n] :<leader>t
                    ":!tree-sitter generate && tree-sitter test<CR>"
                    {:desc "Test [T]ree-sitter parser" :buffer true})))

(let [grp (vim.api.nvim_create_augroup :GrammarJS {:clear true})
      au vim.api.nvim_create_autocmd]
  (au :BufEnter {:callback generate :group grp}))
