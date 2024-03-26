;; [[ Configure nvim-cmp ]]
;; See `:help cmp`
(λ config []
  (let [cmp (require :cmp)
        luasnip (require :luasnip)
        mapping cmp.mapping]
    ((. (require :luasnip.loaders.from_vscode) :lazy_load))
    (luasnip.config.setup {})
    (let [keys {:<C-Space> (mapping.complete {})
                :<C-b> (mapping.scroll_docs (- 4))
                :<C-f> (mapping.scroll_docs 4)
                :<C-n> (mapping.select_next_item)
                :<C-p> (mapping.select_prev_item)
                :<CR> (mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                        :select true})
                :<S-Tab> (mapping (fn [fallback]
                                    (if (cmp.visible) (cmp.select_prev_item)
                                        (luasnip.locally_jumpable (- 1)) (luasnip.jump (- 1))
                                        (fallback)))
                                  [:i :s])
                :<Tab> (mapping (fn [fallback]
                                  (if (cmp.visible) (cmp.select_next_item)
                                      (luasnip.expand_or_locally_jumpable) (luasnip.expand_or_jump)
                                      (fallback)))
                                [:i :s])}]
      (cmp.setup {:completion {:completeopt "menu,menuone,noinsert"}
                  :mapping (mapping.preset.insert keys)
                  :snippet {:expand (fn [args] (luasnip.lsp_expand args.body))}
                  :sources [{:name :nvim_lsp}
                            {:name :luasnip}
                            {:name :path}
                            {:name :treesitter}]}))))

{;; Autocompletion
 1 :hrsh7th/nvim-cmp
 : config
 :event :VeryLazy
 :dependencies [;; Snippet Engine & its associated nvim-cmp source
                :L3MON4D3/LuaSnip
                :saadparwaiz1/cmp_luasnip
                ;; Adds LSP completion capabilities
                :hrsh7th/cmp-nvim-lsp
                :hrsh7th/cmp-path
                ;; Adds a number of user-friendly snippets
                :rafamadriz/friendly-snippets
                ;; Treesitter
                :ray-x/cmp-treesitter]}
