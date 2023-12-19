(local t [:windwp/nvim-autopairs])
(set t.dependencies [:hrsh7th/nvim-cmp])
(λ config []
  ((. (require :nvim-autopairs) :setup))
  (let [cmp_autopairs (require :nvim-autopairs.completion.cmp)
        cmp (require :cmp)]
    (cmp.event:on :confirm_done (cmp_autopairs.on_confirm_done))))

(set t.config config)

t
