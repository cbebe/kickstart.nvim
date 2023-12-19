(local t [:windwp/nvim-ts-autotag])

(set t.config (λ []
                ((. (require :nvim-ts-autotag) :setup))))

t
