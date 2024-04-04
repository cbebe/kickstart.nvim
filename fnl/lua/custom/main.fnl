;; See `:help telescope.builtin`
(let [s vim.keymap.set]
  (λ builtin [fun lkey desc]
    (s :n (.. :<leader> lkey) (. (require :telescope.builtin) fun) {: desc}))
  (builtin :oldfiles "?" "[?] Find recently opened files")
  (builtin :buffers :<space> "[ ] Find existing buffers")
  (builtin :builtin :ss "[S]earch [S]elect Telescope")
  (builtin :git_files :gf "Search [G]it [F]iles")
  (builtin :find_files :sf "[S]earch [F]iles")
  (builtin :help_tags :sh "[S]earch [H]elp")
  (builtin :grep_string :sw "[S]earch current [W]ord")
  (builtin :live_grep :sg "[S]earch by [G]rep")
  (builtin :diagnostics :sd "[S]earch [D]iagnostics")
  (builtin :resume :sr "[S]earch [R]esume")
  (s :n :<leader>/
     (λ []
       (let [fuzzy-find (. (require :telescope.builtin)
                           :current_buffer_fuzzy_find)
             get-dropdown (. (require :telescope.themes) :get_dropdown)]
         (fuzzy-find (get-dropdown ;; You can pass additional configuration to telescope to change theme, layout, etc.
                                   {:previewer false :winblend 10}))))
     {:desc "[/] Fuzzily search in current buffer"})
  (s :n :<leader>s/
     (λ []
       (let [live-grep (. (require :telescope.builtin) :live_grep)]
         (live-grep {:grep_open_files true
                     :prompt_title "Live Grep in Open Files"})))
     {:desc "[S]earch [/] in Open Files"})
  (s :n :<leader>sF
     (λ []
       (let [find-files (. (require :telescope.builtin) :find_files)]
         (find-files {:find_command [:rg :--files :-uuu :-g :!.git]})))
     {:desc "[S]earch [F]iles including hidden"})
  (s :n :<leader>sG
     (λ []
       (let [live-grep (. (require :telescope.builtin) :live_grep)]
         (live-grep {:find_command [:rg :-uuu :-g :!.git]})))
     {:desc "[S]earch by [G]rep including hidden"}))

;; [[ Configure Treesitter ]]
;; See `:help nvim-treesitter`
(λ tree-sitter-config []
  (let [setup (. (require :nvim-treesitter.configs) :setup)
        obj-move {:enable true
                  :goto_next_end {"]M" "@function.outer" "][" "@class.outer"}
                  :goto_next_start {"]]" "@class.outer" "]m" "@function.outer"}
                  :goto_previous_end {"[M" "@function.outer"
                                      "[]" "@class.outer"}
                  :goto_previous_start {"[[" "@class.outer"
                                        "[m" "@function.outer"}
                  ;; whether to set jumps in the jumplist
                  :set_jumps true}
        obj-select {:enable true
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
            :autotag {:enable true}
            ;; Install languages synchronously (only applied to `ensure_installed`)
            :sync_install false
            :textobjects {:move obj-move :select obj-select}})))

;; Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
(vim.defer_fn tree-sitter-config 0)

(let [register (. (require :which-key) :register)]
  (λ key [name]
    {:_ :which_key_ignore : name})
  ;; document existing key chains
  (register {:<leader>c (key "[C]ode")
             :<leader>d (key "[D]ocument")
             :<leader>g (key "[G]it")
             :<leader>h (key "Git [H]unk")
             :<leader>r (key "[R]ename")
             :<leader>s (key "[S]earch")
             :<leader>t (key "[T]oggle")
             :<leader>w (key "[W]orkspace")})
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
(let [servers {:clangd {}
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
               :tsserver {}}]
  ;; Setup neovim lua configuration
  ((. (require :neodev) :setup))
  (let [
        ;; nvim-cmp supports additional completion capabilities, so broadcast that to servers
        capabilities (let [default-capabilities (vim.lsp.protocol.make_client_capabilities)]
                       ((. (require :cmp_nvim_lsp) :default_capabilities) default-capabilities))
        mason-lspconfig (require :mason-lspconfig)]
    ;; Ensure the servers above are installed
    (mason-lspconfig.setup {:ensure_installed (vim.tbl_keys servers)})
    (λ handler [server-name]
      (let [setup (. (. (require :lspconfig) server-name) :setup)
            filetypes (. (or (. servers server-name) {}) :filetypes)]
        (setup {: capabilities
                : filetypes
                :on_attach (require :custom.on-attach)
                :settings (. servers server-name)})))
    (mason-lspconfig.setup_handlers [handler])))

;; [[ Configure nvim-cmp ]]
;; See `:help cmp`
(let [cmp (require :cmp)
      ls (require :luasnip)
      m cmp.mapping]
  ((. (require :luasnip.loaders.from_vscode) :lazy_load))
  (ls.config.setup {})
  (let [keys {:<C-Space> (m.complete {})
              :<C-b> (m.scroll_docs (- 4))
              :<C-f> (m.scroll_docs 4)
              :<C-n> (m.select_next_item)
              :<C-p> (m.select_prev_item)
              :<CR> (m.confirm {:behavior cmp.ConfirmBehavior.Insert
                                :select true})
              :<S-Tab> (m (λ [?fallback]
                            (if (cmp.visible) (cmp.select_prev_item)
                                (ls.locally_jumpable (- 1)) (ls.jump (- 1))
                                (?fallback))) [:i :s])
              :<Tab> (m (λ [?fallback]
                          (if (cmp.visible) (cmp.select_next_item)
                              (ls.expand_or_locally_jumpable) (ls.expand_or_jump)
                              (?fallback))) [:i :s])}]
    (cmp.setup {:completion {:completeopt "menu,menuone,noinsert"}
                :mapping (m.preset.insert keys)
                :snippet {:expand (λ [args] (ls.lsp_expand args.body))}
                :sources [{:name :nvim_lsp}
                          {:name :luasnip}
                          {:name :path}
                          {:name :treesitter}]})))
