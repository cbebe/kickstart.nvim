(local tbl ["xiyaowong/telescope-emoji.nvim"])
(tset tbl
      :config
      (fn []
        (let [telescope (require :telescope)]
          (telescope.load_extension :emoji))))

tbl
