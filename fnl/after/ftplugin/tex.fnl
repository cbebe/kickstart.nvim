(λ indent-latex []
  (let [save-cursor (vim.fn.getpos ".")]
    (vim.cmd "%!latexindent")
    (vim.fn.setpos "." save-cursor)))

(vim.keymap.set [:n] :<leader>f indent-latex
                {:desc "[F]ormat buffer" :buffer true})
