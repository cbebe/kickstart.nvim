(λ is_test [file] (= (file:sub 0 5) :test_))

(set _G.cc_pos (match _G.cc_pos nil {} p p))

(λ switch_file []
  (let [file (vim.fn.expand "%:t:r")
        go_to (if (is_test file) [:src/ (file:sub 6)]
                  [:test/ (.. :test_ file)])
        go_to_key (. go_to 2)
        go_to_file (.. (. go_to 1) (. go_to 2) :.cc)
        save_cursor (vim.fn.getpos ".")
        next_cursor (match (. _G.cc_pos go_to_key)
                      nil save_cursor
                      nc nc)]
    (tset _G.cc_pos file save_cursor)
    (vim.cmd.edit go_to_file)
    (vim.fn.setpos "." next_cursor)))

(vim.keymap.set [:n] :<leader>dd switch_file
                {:desc "Open [I]mplementation" :buffer true})

(vim.keymap.set [:n] :<leader>f
                ":!make test<CR>"
                {:desc "Run [T]ests" :buffer true})
