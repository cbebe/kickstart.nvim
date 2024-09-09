;; 5 MiB
(local max-file-size (* (* 5 1024) 1024))

(λ ignore-large-files [ev]
  (let [file (. ev :match)
        size (vim.fn.getfsize file)]
    (if (> size max-file-size)
        (do
          (set vim.opt_local.swapfile false)
          (set vim.opt_local.bufhidden :unload)
          (set vim.opt_local.buftype :nowrite)
          (set vim.opt_local.undolevels -1)
          (vim.opt.eventignore:append :FileType))
        (vim.opt.eventignore:remove :FileType))))

(vim.api.nvim_create_augroup :LargeFile {:clear true})
(vim.api.nvim_create_autocmd :BufReadPre
                             {:group :LargeFile :callback ignore-large-files})
