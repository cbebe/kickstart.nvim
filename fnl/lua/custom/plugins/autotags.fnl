(local tbl [:windwp/nvim-ts-autotag])
(tset tbl :config (fn []
                    ((. (require :nvim-ts-autotag) :setup))))
tbl
