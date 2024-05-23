(set vim.opt_local.commentstring "//%s")
(let [ft (require :Comment.ft)] (ft.set :templ ["//%s" "/*%s*/"]))
