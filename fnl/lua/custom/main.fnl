;; See `:help telescope.builtin`
(vim.keymap.set :n :<leader>? (. (require :telescope.builtin) :oldfiles)
                {:desc "[?] Find recently opened files"})

(vim.keymap.set :n :<leader><space> (. (require :telescope.builtin) :buffers)
                {:desc "[ ] Find existing buffers"})

(vim.keymap.set :n :<leader>/
                (fn []
                  (let [fuzzy-find (. (require :telescope.builtin)
                                      :current_buffer_fuzzy_find)
                        get-dropdown (. (require :telescope.themes)
                                        :get_dropdown)]
                    (fuzzy-find (get-dropdown ;; You can pass additional configuration to telescope to change theme, layout, etc.
                                              {:previewer false :winblend 10}))))
                {:desc "[/] Fuzzily search in current buffer"})

(fn telescope-live-grep-open-files []
  ((. (require :telescope.builtin) :live_grep) {:grep_open_files true
                                                :prompt_title "Live Grep in Open Files"}))

(vim.keymap.set :n :<leader>s/ telescope-live-grep-open-files
                {:desc "[S]earch [/] in Open Files"})

(vim.keymap.set :n :<leader>ss (. (require :telescope.builtin) :builtin)
                {:desc "[S]earch [S]elect Telescope"})

(vim.keymap.set :n :<leader>gf (. (require :telescope.builtin) :git_files)
                {:desc "Search [G]it [F]iles"})

(vim.keymap.set :n :<leader>sf (. (require :telescope.builtin) :find_files)
                {:desc "[S]earch [F]iles"})

(vim.keymap.set :n :<leader>sF
                (fn []
                  (let [find-files (. (require :telescope.builtin) :find_files)]
                    (find-files {:find_command [:rg :--files :-uuu :-g :!.git]})))
                {:desc "[S]earch [F]iles including hidden"})

(vim.keymap.set :n :<leader>sh (. (require :telescope.builtin) :help_tags)
                {:desc "[S]earch [H]elp"})

(vim.keymap.set :n :<leader>sw (. (require :telescope.builtin) :grep_string)
                {:desc "[S]earch current [W]ord"})

(vim.keymap.set :n :<leader>sg (. (require :telescope.builtin) :live_grep)
                {:desc "[S]earch by [G]rep"})

(vim.keymap.set :n :<leader>sG
                (fn []
                  (let [live-grep (. (require :telescope.builtin) :live_grep)]
                    (live-grep {:find_command [:rg :-uuu :-g :!.git]})))
                {:desc "[S]earch by [G]rep including hidden"})

(vim.keymap.set :n :<leader>sd (. (require :telescope.builtin) :diagnostics)
                {:desc "[S]earch [D]iagnostics"})

(vim.keymap.set :n :<leader>sr (. (require :telescope.builtin) :resume)
                {:desc "[S]earch [R]esume"})

;; [[ Configure Treesitter ]]
;; See `:help nvim-treesitter`
;; Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
(vim.defer_fn (fn []
                (let [setup (. (require :nvim-treesitter.configs) :setup)
                      to-move {:enable true
                               :goto_next_end {"]M" "@function.outer"
                                               "][" "@class.outer"}
                               :goto_next_start {"]]" "@class.outer"
                                                 "]m" "@function.outer"}
                               :goto_previous_end {"[M" "@function.outer"
                                                   "[]" "@class.outer"}
                               :goto_previous_start {"[[" "@class.outer"
                                                     "[m" "@function.outer"}
                               ;; whether to set jumps in the jumplist
                               :set_jumps true}
                      to-select {:enable true
                                 :keymaps {;; You can use the capture groups defined in textobjects.scm
                                           :aa "@parameter.outer"
                                           :ac "@class.outer"
                                           :af "@function.outer"
                                           :ia "@parameter.inner"
                                           :ic "@class.inner"
                                           :if "@function.inner"}
                                 ;; Automatically jump forward to textobj, similar to targets.vim
                                 :lookahead true}]
                  (setup {;; Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
                          :auto_install false
                          ;; Add languages to be installed here that you want installed for treesitter
                          :ensure_installed [:c
                                             :cpp
                                             :go
                                             :lua
                                             :python
                                             :rust
                                             :tsx
                                             :javascript
                                             :typescript
                                             :vimdoc
                                             :vim
                                             :bash
                                             :fennel]
                          :highlight {:enable true}
                          ;; List of parsers to ignore installing
                          :ignore_install {}
                          :incremental_selection {:enable true
                                                  :keymaps {:init_selection :<c-i>
                                                            :node_decremental :<c-s>
                                                            :node_incremental :<c-i>}}
                          :indent {:enable true}
                          ;; You can specify additional Treesitter modules here:
                          ;; For example:
                          ;; :playground { :enable true }
                          :modules {}
                          ;; Install languages synchronously (only applied to `ensure_installed`)
                          :sync_install false
                          :textobjects {:move to-move :select to-select}})))
  0)

(let [register (. (require :which-key) :register)]
  ;; document existing key chains
  (register {:<leader>c {:_ :which_key_ignore :name "[C]ode"}
             :<leader>d {:_ :which_key_ignore :name "[D]ocument"}
             :<leader>g {:_ :which_key_ignore :name "[G]it"}
             :<leader>h {:_ :which_key_ignore :name "Git [H]unk"}
             :<leader>r {:_ :which_key_ignore :name "[R]ename"}
             :<leader>s {:_ :which_key_ignore :name "[S]earch"}
             :<leader>t {:_ :which_key_ignore :name "[T]oggle"}
             :<leader>w {:_ :which_key_ignore :name "[W]orkspace"}})
  ;; register which-key VISUAL mode
  ;; required for visual <leader>hs (hunk stage) to work
  (register {:<leader> {:name "VISUAL <leader>"} :<leader>h ["Git [H]unk"]}
            {:mode :v}))

;; mason-lspconfig requires that these setup functions are called in this order
;; before setting up the servers.
((. (require :mason) :setup))
((. (require :mason-lspconfig) :setup))
;; Enable the following language servers
;;  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
;;
;;  Add any additional override configuration in the following tables. They will be passed to
;;  the `settings` field of the server config. You must look up that documentation yourself.
;;
;;  If you want to override the default filetypes that your language server will attach to you can
;;  define the property 'filetypes' to the map in question.
(local servers {:clangd {}
                ; :pyright {}
                ; :html { :filetypes [:html :twig :hbs] }
                :fennel_language_server {:fennel {;; Gets rid of annoying errors
                                                  :diagnostics {:globals [:vim]}}}
                :gopls {}
                :lua_ls {:Lua {;; NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                               :diagnostics {:disable [:missing-fields]}
                               :telemetry {:enable false}
                               :workspace {:checkThirdParty false}}}
                :rust_analyzer {}
                :tsserver {}})

;; Setup neovim lua configuration
((. (require :neodev) :setup))
;; nvim-cmp supports additional completion capabilities, so broadcast that to servers
(var capabilities (vim.lsp.protocol.make_client_capabilities))
(set capabilities
     ((. (require :cmp_nvim_lsp) :default_capabilities) capabilities))

;; Ensure the servers above are installed
(local mason-lspconfig (require :mason-lspconfig))
(mason-lspconfig.setup {:ensure_installed (vim.tbl_keys servers)})
(fn handler [server-name]
  (let [setup (. (. (require :lspconfig) server-name) :setup)
        filetypes (. (or (. servers server-name) {}) :filetypes)]
    (setup {: capabilities
            : filetypes
            :on_attach (require :custom.on-attach)
            :settings (. servers server-name)})))

(mason-lspconfig.setup_handlers [handler])

;; [[ Configure nvim-cmp ]]
;; See `:help cmp`
(local cmp (require :cmp))
(local luasnip (require :luasnip))
((. (require :luasnip.loaders.from_vscode) :lazy_load))
(luasnip.config.setup {})
(let [keys {:<C-Space> (cmp.mapping.complete {})
            :<C-b> (cmp.mapping.scroll_docs (- 4))
            :<C-f> (cmp.mapping.scroll_docs 4)
            :<C-n> (cmp.mapping.select_next_item)
            :<C-p> (cmp.mapping.select_prev_item)
            :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                        :select true})
            :<S-Tab> (cmp.mapping (fn [fallback]
                                    (if (cmp.visible) (cmp.select_prev_item)
                                        (luasnip.locally_jumpable (- 1)) (luasnip.jump (- 1))
                                        (fallback)))
                                  [:i :s])
            :<Tab> (cmp.mapping (fn [fallback]
                                  (if (cmp.visible) (cmp.select_next_item)
                                      (luasnip.expand_or_locally_jumpable) (luasnip.expand_or_jump)
                                      (fallback)))
                                [:i :s])}
      mapping (cmp.mapping.preset.insert keys)]
  (cmp.setup {:completion {:completeopt "menu,menuone,noinsert"}
              : mapping
              :snippet {:expand (fn [args] (luasnip.lsp_expand args.body))}
              :sources [{:name :nvim_lsp}
                        {:name :luasnip}
                        {:name :path}
                        {:name :treesitter}]}))
