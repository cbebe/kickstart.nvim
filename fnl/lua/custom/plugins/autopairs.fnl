(local tbl ["windwp/nvim-autopairs"])
(tset tbl :dependencies ["hrsh7th/nvim-cmp"])
(tset
  tbl
  :config
  (fn []
    ((. (require :nvim-autopairs) :setup))
    (let [cmp_autopairs (require :nvim-autopairs.completion.cmp)
          cmp (require :cmp)]
      (cmp.event:on :confirm_done (cmp_autopairs.on_confirm_done)))))
tbl
