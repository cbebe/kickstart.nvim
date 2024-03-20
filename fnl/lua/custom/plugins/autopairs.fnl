(λ config []
  ((. (require :nvim-autopairs) :setup))
  (let [cmp_autopairs (require :nvim-autopairs.completion.cmp)
        cmp (require :cmp)]
    (cmp.event:on :confirm_done (cmp_autopairs.on_confirm_done))))

{1 :windwp/nvim-autopairs :dependencies [:hrsh7th/nvim-cmp] : config}
