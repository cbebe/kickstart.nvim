(local t [:ThePrimeagen/harpoon])
(tset t :branch :harpoon2)
(tset t :requires [:nvim-lua/plenary.nvim])

(λ config []
  (let [harpoon (require :harpoon)
        k (partial vim.keymap.set [:n])]
    (harpoon:setup {})
    (k :<C-f> (λ [] (harpoon.ui:toggle_quick_menu (harpoon:list)))
       {:desc "Open list of [F]iles"})
    (k :<C-s> (λ [] (: (harpoon:list) :append)) {:desc "[S]ave to list"})
    (k :<C-h> (λ [] (: (harpoon:list) :select 1)))
    (k :<C-j> (λ [] (: (harpoon:list) :select 2)))
    (k :<C-k> (λ [] (: (harpoon:list) :select 3)))
    (k :<C-l> (λ [] (: (harpoon:list) :select 4)))))

(tset t :config config)

t
