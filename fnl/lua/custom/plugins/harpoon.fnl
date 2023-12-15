(local tbl [:ThePrimeagen/harpoon])
(tset tbl :branch :harpoon2)
(tset tbl :requires [:nvim-lua/plenary.nvim])
(tset
  tbl
  :config
  (fn []
    (let [harpoon (require :harpoon)]
      (harpoon:setup)
      (vim.keymap.set
        [:n]
        "<C-f>"
        (fn [] (harpoon.ui:toggle_quick_menu (harpoon:list)))
        {:desc "Open list of [F]iles"})
      (vim.keymap.set [:n] "<C-s>" (fn [] (: (harpoon:list) :append)) {:desc "[S]ave to list"})
      (vim.keymap.set [:n] "<C-h>" (fn [] (: (harpoon:list) :select 1)))
      (vim.keymap.set [:n] "<C-j>" (fn [] (: (harpoon:list) :select 2)))
      (vim.keymap.set [:n] "<C-k>" (fn [] (: (harpoon:list) :select 3)))
      (vim.keymap.set [:n] "<C-l>" (fn [] (: (harpoon:list) :select 4))))))
tbl
