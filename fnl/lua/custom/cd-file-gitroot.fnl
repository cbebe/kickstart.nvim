(λ git_root [dir]
  (let [cmd (.. "git -C " (vim.fn.escape dir " ") " rev-parse --show-toplevel")]
    (. (vim.fn.systemlist cmd) 1)))

(λ cd_git_root []
  (let [current_file (vim.api.nvim_buf_get_name 0)
        current_dir (if (= "" current_file) (vim.fn.getcwd)
                        (vim.fn.fnamemodify current_file ":h"))
        gr (git_root current_dir)
        [msg dest_dir] (if (= vim.v.shell_error 0) ["" gr]
                           ["not a git directory. " current_dir])]
    (print (.. msg "changing directory to " dest_dir))
    (vim.fn.chdir dest_dir)))

(vim.keymap.set [:n] :<leader>gc cd_git_root
                {:desc "[G]it root [C]hange to current file"})
