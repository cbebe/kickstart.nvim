;; 256 KiB
(local max-file-size (* 256 1024))

(λ ignore-large-files [ev]
  (let [file (. ev :match)
        size (vim.fn.getfsize file)]
    (if (> size max-file-size)
        (do
          (vim.api.nvim_err_writeln (string.format "File too large: %s (%d) bytes"
                                                   file size))
          (vim.api.nvim_command "echohl WarningMsg | echo \"File not loaded due to size\" | echohl None")
          (set vim.opt_local.modifiable false)
          true))))

(vim.api.nvim_create_augroup :LargeFile {:clear true})
(vim.api.nvim_create_autocmd :BufReadPre
                             {:group :LargeFile :callback ignore-large-files})
