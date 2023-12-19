(vim.cmd (.. "highlight ExtraWhitespace ctermbg=red guibg=red\n"
             "match ExtraWhitespace /\\s\\+$/"))

(let [grp (vim.api.nvim_create_augroup :RenderWhiteSpace {:clear true})
      au vim.api.nvim_create_autocmd]
  (au :BufWinEnter {:command "match ExtraWhitespace /\\s\\+$/" :group grp})
  (au :InsertEnter {:command "match ExtraWhitespace /\\s\\+\\%#\\@<!$/"
                    :group grp})
  (au :InsertLeave {:command "match ExtraWhitespace /\\s\\+$/" :group grp})
  (au :BufWinLeave {:command "call clearmatches()" :group grp}))

(λ rm_ws []
  (let [save_cursor (vim.fn.getpos ".")]
    (vim.cmd "let _s=@/\n%s/\\s\\+$//e\nlet @/=_s\nnohl\nunlet _s")
    (vim.fn.setpos "." save_cursor)))

(vim.keymap.set [:n] :<leader>rs rm_ws {:desc "Remove all trailing whitespace"})
