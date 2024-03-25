(set vim.opt_local.shiftwidth 2)
(set vim.opt_local.tabstop 2)
(set vim.opt_local.softtabstop 2)
(set vim.opt_local.expandtab true)

(λ format-ts []
  (let [save-cursor (vim.fn.getpos ".")]
    (vim.cmd "%!deno fmt --ext ts -")
    (vim.fn.setpos "." save-cursor)))

(vim.keymap.set [:n] :<leader>f format-ts
                {:desc "[F]ormat buffer" :buffer true})
