(local t [:xiyaowong/telescope-emoji.nvim])
(λ config []
  ((. (require :telescope) :load_extension) :emoji))

(tset t :config config)

t
