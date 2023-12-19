(local t [:nvim-treesitter/playground])
(tset t :dependencies [:nvim-treesitter/nvim-treesitter])

(λ config []
  (let [configs (require :nvim-treesitter.configs)
        keybindings {:toggle_query_editor :o
                     :toggle_hl_groups :i
                     :toggle_injected_languages :t
                     :toggle_anonymous_nodes :a
                     :toggle_language_display :I
                     :focus_language :f
                     :unfocus_language :F
                     :update :R
                     :goto_node :<cr>
                     :show_help "?"}
        playground {:enable true
                    :disable {}
                    ; Debounced time for highlighting nodes in the playground from source code
                    :updatetime 25
                    ; Whether the query persists across vim sessions
                    :persist_queries false
                    : keybindings}]
    (configs.setup {: playground})))

(tset t :config config)

t
