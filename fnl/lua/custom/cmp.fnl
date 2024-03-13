; [[ Configure nvim-cmp ]]
; See `:help cmp`
(local cmp (require :cmp))
(local luasnip (require :luasnip))
((. (require :luasnip.loaders.from_vscode) :lazy_load))
(luasnip.config.setup {})
(λ next_cmp [fallback]
  (if (cmp.visible) (cmp.select_next_item)
      (luasnip.expand_or_locally_jumpable) (luasnip.expand_or_jump)
      (fallback)))

(λ prev_cmp [fallback]
  (if (cmp.visible) (cmp.select_prev_item)
      (luasnip.locally_jumpable -1) (luasnip.jump -1)
      (fallback)))

(let [mapping {:<C-n> (cmp.mapping.select_next_item)
               :<C-p> (cmp.mapping.select_prev_item)
               :<C-b> (cmp.mapping.scroll_docs -4)
               :<C-f> (cmp.mapping.scroll_docs 4)
               :<C-Space> (cmp.mapping.complete {})
               :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                           :select true})
               :<Tab> (cmp.mapping next_cmp [:i :s])
               :<S-Tab> (cmp.mapping prev_cmp [:i :s])}]
  (cmp.setup {:snippet {:expand (λ [args]
                                  (luasnip.expand args.body))}
              :completion {:completeopt :menumenuonenoinsert}
              :mapping (cmp.mapping.preset.insert mapping)
              :sources [{:name :nvim_lsp}
                        {:name :luasnip}
                        {:name :path}
                        {:name :treesitter}]}))
