(λ config []
  ((. (require :nvim-autopairs) :setup))
  (let [cmp-autopairs (require :nvim-autopairs.completion.cmp)
        cmp (require :cmp)]
    (cmp.event:on :confirm_done (cmp-autopairs.on_confirm_done))))

{1 :windwp/nvim-autopairs :dependencies [:hrsh7th/nvim-cmp] : config}
