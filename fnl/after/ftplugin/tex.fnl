(λ indent_latex []
  (let [save_cursor (vim.fn.getpos ".")]
    (vim.cmd "%!latexindent")
    (vim.fn.setpos "." save_cursor)))

(vim.keymap.set [:n] :<leader>f indent_latex
                {:desc "[F]ormat buffer" :buffer true})
