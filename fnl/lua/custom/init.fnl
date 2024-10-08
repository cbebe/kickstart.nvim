(require :custom.setup)

; [[[ Remove whitespace
(vim.cmd "highlight ExtraWhitespace ctermbg=red guibg=red\n")

(let [grp (vim.api.nvim_create_augroup :RenderWhiteSpace {:clear true})
      au vim.api.nvim_create_autocmd]
  (λ match-whitespace [cmd]
    (let [buftype (vim.api.nvim_buf_get_option (vim.api.nvim_get_current_buf)
                                               :buftype)]
      (if (= buftype "")
          (if (= cmd :InsertEnter)
              (vim.cmd "match ExtraWhitespace /\\s\\+\\%#\\@<!$/")
              (vim.cmd "match ExtraWhitespace /\\s\\+$/")))))
  (au [:BufWinEnter :InsertEnter :InsertLeave]
      {:callback match-whitespace :group grp})
  (au :BufWinLeave {:command "call clearmatches()" :group grp}))

(λ rm-ws []
  (let [save_cursor (vim.fn.getpos ".")]
    (vim.cmd "let _s=@/\n%s/\\s\\+$//e\nlet @/=_s\nnohl\nunlet _s")
    (vim.fn.setpos "." save_cursor)))

(vim.keymap.set [:n] :<leader>rs rm-ws {:desc "Remove all trailing whitespace"})
; ]]]

; [[[ BufOnly
; rewrite with Neovim API? it's a bit slow right now
(vim.api.nvim_create_user_command :BufOnly ":%bd|e#" {})
; ]]]

; [[[ cd file gitroot
(λ git-root [dir]
  (let [cmd (.. "git -C " (vim.fn.escape dir " ") " rev-parse --show-toplevel")]
    (. (vim.fn.systemlist cmd) 1)))

(λ cd-git-root []
  (let [current-file (vim.api.nvim_buf_get_name 0)
        current-dir (if (= "" current-file) (vim.fn.getcwd)
                        (vim.fn.fnamemodify current-file ":h"))
        gr (git-root current-dir)
        [msg dest-dir] (if (= vim.v.shell_error 0) ["" gr]
                           ["not a git directory. " current-dir])]
    (print (.. msg "changing directory to " dest-dir))
    (vim.fn.chdir dest-dir)))

(vim.keymap.set [:n] :<leader>gc cd-git-root
                {:desc "[G]it root [C]hange to current file"})

; ]]]

(λ add-plugin [opts]
  (let [file (.. :fnl/lua/custom/plugins/ (. opts :args) :.fnl)]
    (vim.cmd.edit file)))

(vim.api.nvim_create_user_command :AddPlugin add-plugin {:nargs 1})

; Fysh Command
; (vim.keymap.set [:v] :<leader>f ":%!fysh-num<CR>" {:desc "[F]ysh"})

; Add extra file extensions for detecting filetype
(vim.filetype.add {:extension {:ll :llvm :fysh :fysh :templ :templ}})

(require :custom.main)
(require :custom.large-file)

; [[[ Polish
(set vim.wo.colorcolumn "80,100")

(λ load-catppuccin []
  (let [catppuccin (require :catppuccin)]
    (catppuccin.setup {:flavour :mocha :transparent_background true}))
  (vim.cmd.colorscheme :catppuccin)
  ;; Disable startup screen
  (vim.opt.shortmess:append {:I true}))

; (vim.cmd.colorscheme :onedark)
(load-catppuccin)
; ]]]

(λ reset-highlight []
  (let [active-buf (. (. (require :vim.treesitter.highlighter) :active)
                      (vim.api.nvim_get_current_buf))]
    (active-buf:destroy))
  (vim.cmd.edit (vim.fn.expand "%")))

(vim.api.nvim_create_user_command :ResetHighlight reset-highlight
                                  {:desc "Resets Treesitter highlight"})

(vim.keymap.set :n :<leader>S
                "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>"
                {:desc "Reload luasnip"})

; vim:foldmethod=marker foldmarker=[[[,]]]
