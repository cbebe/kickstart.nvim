(λ format-markdown []
  (let [save-cursor (vim.fn.getpos ".")]
    (vim.cmd "%!deno fmt --ext md -")
    (vim.fn.setpos "." save-cursor)))

(vim.keymap.set [:n] :<leader>f format-markdown
                {:desc "[F]ormat buffer" :buffer true})
