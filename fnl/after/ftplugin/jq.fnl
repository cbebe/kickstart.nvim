(set vim.opt_local.commentstring "#%s")
(let [ft (require :Comment.ft)] (ft.set :jq ["#%s"]))

(λ find-match [t x ?k]
  (match (next t ?k)
    (where idx (string.find (. t idx) x)) (. t idx)
    (k _) (find-match t x k)))

(fn split-after-first [inputstr sep]
  (let [(sep-start sep-end) (string.find inputstr sep)]
    (if sep-start
        (string.sub inputstr (+ sep-end 1))
        nil)))

(λ execute_jq []
  (let [lines (vim.api.nvim_buf_get_lines 0 0 -1 false)
        delim "@cmd"
        cmd-line (find-match lines delim)]
    (if cmd-line
        (let [cmd (split-after-first cmd-line delim)]
          (print "")
          (vim.api.nvim_command (.. "w !" cmd)))
        (print (.. "No command found! Add a comment starting with " delim)))))

(vim.keymap.set [:n] :<leader>x execute_jq {:desc "E[X]ecute JQ" :buffer true})
