(local tbl ["xiyaowong/telescope-emoji.nvim"])
(tset tbl :config (fn [] ((. (require :telescope) :load_extension) :emoji)))
tbl
