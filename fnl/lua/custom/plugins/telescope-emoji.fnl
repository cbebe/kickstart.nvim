(local t [:xiyaowong/telescope-emoji.nvim])

(λ config []
  ((. (require :telescope) :load_extension) :emoji))

(set t.config config)

t
