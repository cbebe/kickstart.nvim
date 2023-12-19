; rewrite with Neovim API? it's a bit slow right now
(vim.api.nvim_create_user_command :BufOnly ":%bd|e#" {})
