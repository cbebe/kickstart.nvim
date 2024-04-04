(λ formatter [cmd]
  (λ format []
    (let [save-cursor (vim.fn.getpos ".")]
      (vim.cmd (.. "%!" cmd))
      (vim.fn.setpos "." save-cursor)))
  (vim.keymap.set [:n] :<leader>f format {:desc "[F]ormat buffer" :buffer true}))

formatter
