;; Set <space> as the leader key
;; See `:help mapleader`
;;  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
(set vim.g.mapleader " ")
(set vim.g.maplocalleader " ")

;; [[ Install `lazy.nvim` plugin manager ]]
;;    https://github.com/folke/lazy.nvim
;;    `:help lazy.nvim.txt` for more info
(let [lazypath (.. (vim.fn.stdpath :data) :/lazy/lazy.nvim)]
  (when (not (vim.loop.fs_stat lazypath))
    (vim.fn.system [:git
                    :clone
                    "--filter=blob:none"
                    "https://github.com/folke/lazy.nvim.git"
                    ;; latest stable release
                    :--branch=stable
                    lazypath]))
  (vim.opt.rtp:prepend lazypath))

;; [[ Configure plugins ]]
;; NOTE: Here is where you install your plugins.
;;  You can configure plugins using the `config` key.
;;
;;  You can also configure plugins after the setup call,
;;    as they will be available in your neovim runtime.
(let [s (. (require :lazy) :setup)]
  (s [;; NOTE: First, some plugins that don't require any configuration
      ;;
      ;; Git related plugins
      :tpope/vim-fugitive
      :tpope/vim-rhubarb
      ;; Detect tabstop and shiftwidth automatically
      :tpope/vim-sleuth
      ;; Startup time
      {1 :dstein64/vim-startuptime :cmd :StartupTime}
      ;; NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
      ;;       These are some example plugins that I've included in the kickstart repository.
      ;;       Uncomment any of the lines below to enable them.
      (require :kickstart.plugins.autoformat)
      ; (require :kickstart.plugins.debug)
      ;; NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
      ;;    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
      ;;    up-to-date with whatever is in the kickstart repo.
      ;;    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
      ;;
      ;;    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
      {:import :custom.kickstart}
      {:import :custom.plugins}] {}))

;; [[ Setting options ]]
;; See `:help vim.o`
;; NOTE: You can change these options as you wish!

;; Set highlight on search
(set vim.o.hlsearch false)

;; Make line numbers default
(set vim.wo.number true)
(set vim.wo.relativenumber true)

;; Enable mouse mode
; (set vim.o.mouse :a)

;; Sync clipboard between OS and Neovim.
;;  Remove this option if you want your OS clipboard to remain independent.
;;  See `:help 'clipboard'`
;; This is too slow!!
;; (set vim.o.clipboard "unnamedplus")
(vim.keymap.set [:x] :Y "\"+y" {:silent true})
(vim.keymap.set [:n :v :x] :<leader>p "\"+p" {:silent true})
(vim.keymap.set [:n :v :x] :<leader>P "\"+P" {:silent true})

;; Enable break indent
(set vim.o.breakindent true)

;; Save undo history
(set vim.o.undofile true)

;; Case-insensitive searching UNLESS \C or capital in search
(set vim.o.ignorecase true)
(set vim.o.smartcase true)

;; Keep signcolumn on by default
(set vim.wo.signcolumn :yes)

;; Decrease update time
(set vim.o.updatetime 250)
(set vim.o.timeoutlen 300)

;; Set completeopt to have a better completion experience
(set vim.o.completeopt "menuone,noselect")

;; NOTE: You should make sure your terminal supports this
(set vim.o.termguicolors true)

;; [[ Basic Keymaps ]]

;; Keymaps for better default experience
;; See `:help vim.keymap.set()`
(vim.keymap.set [:n :v] :<Space> :<Nop> {:silent true})

;; Remap for dealing with word wrap
;; (vim.keymap.set :n :k "v:count == 0 ? 'gk' : 'k'" {:expr true :silent true})
;; (vim.keymap.set :n :j "v:count == 0 ? 'gj' : 'j'" {:expr true :silent true})

;; Diagnostic keymaps
(let [dg vim.diagnostic]
  (λ map [key fun desc]
    (vim.keymap.set :n key fun {: desc}))
  (map "[d" dg.goto_prev "Go to previous diagnostic message")
  (map "]d" dg.goto_next "Go to next diagnostic message")
  (map :<leader>E dg.open_float "Open floating diagnostic message")
  (map :<leader>q dg.setloclist "Open diagnostics list"))

;; [[ Highlight on yank ]]
;; See `:help vim.highlight.on_yank()`
(let [highlight-group (vim.api.nvim_create_augroup :YankHighlight {:clear true})]
  (vim.api.nvim_create_autocmd :TextYankPost
                               {:callback (λ [] (vim.highlight.on_yank))
                                :group highlight-group
                                :pattern "*"}))

;; [[ Configure Telescope ]]
;; See `:help telescope` and `:help telescope.setup()`
(let [telescope (require :telescope)]
  (telescope.setup {:defaults {:mappings {:i {:<C-u> false}}}})
  ;; Enable telescope fzf native, if installed
  (pcall telescope.load_extension :fzf))
