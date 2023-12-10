(local tbl ["windwp/nvim-ts-autotag"])
(tset tbl
      :config
      (fn []
        (let [autotag (require :nvim-ts-autotag)]
          (autotag.setup {}))))

tbl
