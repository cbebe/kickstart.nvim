(λ is-test [file] (= (file:sub 0 5) :test_))

(set _G.cc_pos (match _G.cc_pos nil {} p p))

(λ switch-file []
  (let [file (vim.fn.expand "%:t:r")
        go-to (if (is-test file) [:src/ (file:sub 6)] [:test/ (.. :test_ file)])
        go-to-key (. go-to 2)
        go-to-file (.. (. go-to 1) (. go-to 2) :.cc)
        save-cursor (vim.fn.getpos ".")
        next-cursor (match (. _G.cc_pos go-to-key)
                      nil save-cursor
                      nc nc)]
    (tset _G.cc_pos file save-cursor)
    (vim.cmd.edit go-to-file)
    (vim.fn.setpos "." next-cursor)))

(vim.keymap.set [:n] :<leader>dd switch-file
                {:desc "Open [I]mplementation" :buffer true})

(vim.keymap.set [:n] :<leader>f ":!make test<CR>"
                {:desc "Run [T]ests" :buffer true})
