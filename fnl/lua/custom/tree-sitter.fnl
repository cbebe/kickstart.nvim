; [[ Configure Treesitter ]]
; See `:help nvim-treesitter`
; Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
(λ treesitter_setup []
  (let [setup (. (require :nvim-treesitter.configs) :setup)
        ensure_installed [:c
                          :cpp
                          :go
                          :lua
                          :python
                          :rust
                          :tsx
                          :javascript
                          :typescript
                          :vimdoc
                          :vim
                          :bash
                          :fennel]
        incremental_selection {:enable true
                               :keymaps {:init_selection :<c-i>
                                         :node_incremental :<c-i>
                                         :node_decremental :<c-s>}}
        keymaps {; You can use the capture groups defined in textobjects.scm
                 :aa "@parameter.outer"
                 :ia "@parameter.inner"
                 :af "@function.outer"
                 :if "@function.inner"
                 :ac "@class.outer"
                 :ic "@class.inner"}
        move {:enable true
              ; whether to set jumps in the jumplist
              :set_jumps true
              :goto_next_start {"]m" "@function.outer" "]]" "@class.outer"}
              :goto_next_end {"]M" "@function.outer" "][" "@class.outer"}
              :goto_previous_start {"[m" "@function.outer" "[[" "@class.outer"}
              :goto_previous_end {"[M" "@function.outer" "[]" "@class.outer"}}
        textobjects {:select {:enable true
                              ; Automatically jump forward to textobj, similar to targets.vim
                              :lookahead true
                              : keymaps}
                     : move}]
    (setup {; Add languages to be installed here that you want installed for treesitter
            : ensure_installed
            ; Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
            :auto_install false
            ; Install languages synchronously (only applied to `ensure_installed`)
            :sync_install false
            ; List of parsers to ignore installing
            :ignore_install []
            ; You can specify additional Treesitter modules here:
            ; For example:
            ; playground = {
            ;  enable = true
            ; },
            :modules []
            :highlight {:enable true}
            :indent {:enable true}
            : incremental_selection
            : textobjects})))

(vim.defer_fn treesitter_setup 0)
