(λ get_path_sep []
  (let [os (λ [o] (= (vim.fn.has o) 1))]
    (if (or (os :win32) (os :win32unix)) "\\" "/")))

(λ split [inp sep]
  (let [fields {}
        f (λ [c]
            (tset fields (+ (length fields) 1) c))
        _ (string.gsub inp (string.format "([^%s]+)" sep) f)]
    fields))

(λ path_join [...]
  (local args nil)
  (lua "args = {...}")
  (if (= (length args) 0)
      ""
      (let [first (. args 1)
            path_sep (get_path_sep)
            all_parts {}]
        (if (and (= (type first) :string) (= (first:sub 1 1) path_sep))
            (tset all_parts 1 ""))
        (each [_ v (ipairs args)]
          (vim.list_extend all_parts (split v path_sep)))
        (table.concat all_parts path_sep))))

(λ in_c3 []
  (let [path_sep (get_path_sep)
        c3_path (.. (path_join (os.getenv :HOME) :dox :c3) path_sep)
        cwd (.. (vim.fn.getcwd) path_sep)]
    (= (cwd:sub 1 (length c3_path)) c3_path)))

(local c3_config
       {:cmd [:clangd
              (.. :--query-driver=
                  (path_join (os.getenv :HOME) :.local :share :sxc :bin
                             :sxc-none-eabi-clang++))]})

(if (in_c3) c3_config {})

; [[[ Six tabs
(local current {:sw vim.opt_local.shiftwidth
                :ts vim.opt_local.tabstop
                :sts vim.opt_local.softtabstop
                :et vim.opt_local.expandtab})

(var is_six false)
(λ toggle_tabs []
  (if is_six
      (let []
        (set vim.opt_local.shiftwidth current.sw)
        (set vim.opt_local.tabstop current.ts)
        (set vim.opt_local.softtabstop current.sts)
        (set vim.opt_local.expandtab current.et))
      (let []
        (set current.sw vim.opt_local.shiftwidth)
        (set current.ts vim.opt_local.tabstop)
        (set current.sts vim.opt_local.softtabstop)
        (set current.et vim.opt_local.expandtab)
        (set vim.opt_local.shiftwidth 6)
        (set vim.opt_local.tabstop 6)
        (set vim.opt_local.softtabstop 6)
        (set vim.opt_local.expandtab false)))
  (set is_six (not is_six)))

(vim.api.nvim_create_user_command :ToggleTabs toggle_tabs
                                  {:desc "Toggles tabs to 6 spaces"})

; ]]]

; vim:foldmethod=marker foldmarker=[[[,]]]
