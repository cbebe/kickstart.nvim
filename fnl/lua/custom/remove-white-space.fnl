(vim.cmd (.. "highlight ExtraWhitespace ctermbg=red guibg=red\n"
             "match ExtraWhitespace /\\s\\+$/"))

(let [grp (vim.api.nvim_create_augroup :RenderWhiteSpace {:clear true})
      au vim.api.nvim_create_autocmd]
  (au :BufWinEnter {:command "match ExtraWhitespace /\\s\\+$/" :group grp})
  (au :InsertEnter {:command "match ExtraWhitespace /\\s\\+\\%#\\@<!$/"
                    :group grp})
  (au :InsertLeave {:command "match ExtraWhitespace /\\s\\+$/" :group grp})
  (au :BufWinLeave {:command "call clearmatches()" :group grp}))

(vim.keymap.set [:n] :<leader>rs
                (fn []
                  (let [save_cursor (vim.fn.getpos ".")]
                    (vim.cmd (.. "let _s=@/\n" "%s/\\s\\+$//e\n" "let @/=_s\n"
                                 "nohl\n" "unlet _s\n"))
                    (vim.fn.setpos "." save_cursor)))
                {:desc "Remove all trailing whitespace"})
