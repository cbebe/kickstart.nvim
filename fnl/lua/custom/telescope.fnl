; [[ Configure Telescope ]]
; See `:help telescope` and `:help telescope.setup()`
(let [setup (. (require :telescope) :setup)]
  (setup {:defaults {:mappings {:i {:<C-u> false
                                    ; :<C-d> false
                                    }}}}))

; Enable telescope fzf native, if installed
(pcall (. (require :telescope) :load_extension) :fzf)

; See `:help telescope.builtin`
(vim.keymap.set :n :<leader>? (. (require :telescope.builtin) :oldfiles)
                {:desc "[?] Find recently opened files"})

(vim.keymap.set :n :<leader><space> (. (require :telescope.builtin) :buffers)
                {:desc "[ ] Find existing buffers"})

; You can pass additional configuration to telescope to change theme, layout, etc.
(λ fuzzy_buf []
  (let [fuzzy_find (. (require :telescope.builtin) :current_buffer_fuzzy_find)
        dropdown (. (require :telescope.themes) :get_dropdown)]
    (fuzzy_find (dropdown {:winblend 10 :previewer false}))))

(vim.keymap.set :n :<leader>/ fuzzy_buf
                {:desc "[/] Fuzzily search in current buffer"})

(λ telescope_live_grep_open_files []
  ((. (require :telescope.builtin) :live_grep) {:grep_open_files true
                                                :prompt_title "Live Grep in Open Files"}))

(vim.keymap.set :n :<leader>s/ telescope_live_grep_open_files
                {:desc "[S]earch [/] in Open Files"})

(vim.keymap.set :n :<leader>ss (. (require :telescope.builtin) :builtin)
                {:desc "[S]earch [S]elect Telescope"})

(vim.keymap.set :n :<leader>gf (. (require :telescope.builtin) :git_files)
                {:desc "Search [G]it [F]iles"})

(vim.keymap.set :n :<leader>sf (. (require :telescope.builtin) :find_files)
                {:desc "[S]earch [F]iles"})

(λ find_hidden_files []
  (let [find_files (. (require :telescope.builtin) :find_files)]
    (find_files {:find_command [:rg :--files :-uuu :-g :!.git]})))

(vim.keymap.set :n :<leader>sF find_hidden_files
                {:desc "[S]earch [F]iles including hidden"})

(vim.keymap.set :n :<leader>sh (. (require :telescope.builtin) :help_tags)
                {:desc "[S]earch [H]elp"})

(vim.keymap.set :n :<leader>sw (. (require :telescope.builtin) :grep_string)
                {:desc "[S]earch current [W]ord"})

(vim.keymap.set :n :<leader>sg (. (require :telescope.builtin) :live_grep)
                {:desc "[S]earch by [G]rep"})

(λ grep_hidden_files []
  (let [live_grep (. (require :telescope.builtin) :live_grep)]
    (live_grep {:find_command [:rg :--files :-uuu :-g :!.git]})))

(vim.keymap.set :n :<leader>sG grep_hidden_files
                {:desc "[S]earch by [G]rep including hidden"})

(vim.keymap.set :n :<leader>sd (. (require :telescope.builtin) :diagnostics)
                {:desc "[S]earch [D]iagnostics"})

(vim.keymap.set :n :<leader>sr (. (require :telescope.builtin) :resume)
                {:desc "[S]earch [R]esume"})

