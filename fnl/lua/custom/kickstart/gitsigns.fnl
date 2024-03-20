{;; Adds git related signs to the gutter, as well as utilities for managing changes
 1 :lewis6991/gitsigns.nvim
 :opts {:on_attach (fn [bufnr]
                     (local gs package.loaded.gitsigns)

                     (fn map [mode l r ?opts]
                       (let [opts (if ?opts ?opts {})]
                         (set opts.buffer bufnr)
                         (vim.keymap.set mode l r opts)))

                     ;; Navigation
                     (map [:n :v] "]c"
                          (fn []
                            (when vim.wo.diff
                              (lua "return \"]c\""))
                            (vim.schedule (fn []
                                            (gs.next_hunk)))
                            :<Ignore>)
                          {:desc "Jump to next hunk" :expr true})
                     (map [:n :v] "[c"
                          (fn []
                            (when vim.wo.diff
                              (lua "return \"[c\""))
                            (vim.schedule (fn []
                                            (gs.prev_hunk)))
                            :<Ignore>)
                          {:desc "Jump to previous hunk" :expr true})
                     ;; Actions
                     ;; visual mode
                     (map :v :<leader>hs
                          (fn []
                            (gs.stage_hunk [(vim.fn.line ".") (vim.fn.line :v)]))
                          {:desc "stage git hunk"})
                     (map :v :<leader>hr
                          (fn []
                            (gs.reset_hunk [(vim.fn.line ".") (vim.fn.line :v)]))
                          {:desc "reset git hunk"})
                     ;; normal mode
                     (map :n :<leader>hs gs.stage_hunk {:desc "git stage hunk"})
                     (map :n :<leader>hr gs.reset_hunk {:desc "git reset hunk"})
                     (map :n :<leader>hS gs.stage_buffer
                          {:desc "git Stage buffer"})
                     (map :n :<leader>hu gs.undo_stage_hunk
                          {:desc "undo stage hunk"})
                     (map :n :<leader>hR gs.reset_buffer
                          {:desc "git Reset buffer"})
                     (map :n :<leader>hp gs.preview_hunk
                          {:desc "preview git hunk"})
                     (map :n :<leader>hb
                          (fn []
                            (gs.blame_line {:full false}))
                          {:desc "git blame line"})
                     (map :n :<leader>hd gs.diffthis
                          {:desc "git diff against index"})
                     (map :n :<leader>hD (fn [] (gs.diffthis "~"))
                          {:desc "git diff against last commit"})
                     ;; Toggles
                     (map :n :<leader>tb gs.toggle_current_line_blame
                          {:desc "toggle git blame line"})
                     (map :n :<leader>td gs.toggle_deleted
                          {:desc "toggle git show deleted"})
                     ;; Text object
                     (map [:o :x] :ih ":<C-U>Gitsigns select_hunk<CR>"
                          {:desc "select git hunk"}))
        ;; See `:help gitsigns.txt`
        :signs {:add {:text "+"}
                :change {:text "~"}
                :changedelete {:text "~"}
                :delete {:text "_"}
                :topdelete {:text "‾"}}}}
