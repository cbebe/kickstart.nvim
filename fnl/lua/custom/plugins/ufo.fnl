(tset vim.opt :foldcolumn :1)

; '0' is not bad
(tset vim.opt :foldlevel 99)

; Using ufo provider need a large value, feel free to decrease the value
(tset vim.opt :foldlevelstart 99)
(tset vim.opt :foldenable true)

(local t [:kevinhwang91/nvim-ufo])
(tset t :dependencies [:kevinhwang91/promise-async])

(λ config []
  (let [capabilities (vim.lsp.protocol.make_client_capabilities)
        lspconfig (require :lspconfig)]
    (tset capabilities.textDocument :foldingRange
          {:dynamicRegistration false :lineFoldingOnly true})
    (let [language_servers (lspconfig.util.available_servers)]
      (each [_ ls (ipairs language_servers)]
        (let [server (. lspconfig ls)]
          (server.setup {: capabilities})))))
  (let [ufo (require :ufo)]
    (ufo.setup)))

(tset t :config config)

t
