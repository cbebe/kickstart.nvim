(set vim.opt.foldcolumn :1)

; '0' is not bad
(set vim.opt.foldlevel 99)

; Using ufo provider need a large value, feel free to decrease the value
(set vim.opt.foldlevelstart 99)
(set vim.opt.foldenable true)

(λ config []
  (let [capabilities (vim.lsp.protocol.make_client_capabilities)
        lspconfig (require :lspconfig)]
    (set capabilities.textDocument.foldingRange
         {:dynamicRegistration false :lineFoldingOnly true})
    (let [language-servers (lspconfig.util.available_servers)]
      (each [_ ls (ipairs language-servers)]
        (let [server (. lspconfig ls)]
          (server.setup {: capabilities})))))
  (let [ufo (require :ufo)]
    (ufo.setup)))

{1 :kevinhwang91/nvim-ufo :dependencies [:kevinhwang91/promise-async] : config}
