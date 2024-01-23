(λ format_markdown []
  (let [save_cursor (vim.fn.getpos ".")]
    (vim.cmd "%!deno fmt --ext md -")
    (vim.fn.setpos "." save_cursor)))

(vim.keymap.set [:n] :<leader>f format_markdown
                {:desc "[F]ormat buffer" :buffer true})
