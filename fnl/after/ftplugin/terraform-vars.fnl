(set vim.opt_local.commentstring "#%s")
(let [ft (require :Comment.ft)] (ft.set :jq ["#%s"]))
