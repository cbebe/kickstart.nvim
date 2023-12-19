(vim.keymap.set [:n] :<leader>gc
                (fn []
                  (let [parent_dir (vim.fn.expand "%:p:h")]
                    (vim.fn.chdir parent_dir))
                  (let [git_cmd [:git :rev-parse :--show-toplevel]
                        git_root (: (vim.fn.system git_cmd) :match
                                    "^%s*(.-)%s*$")]
                    (vim.fn.chdir git_root)))
                {:desc "[G]it root [C]hange to current file"})
