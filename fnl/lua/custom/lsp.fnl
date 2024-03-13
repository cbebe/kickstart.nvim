; [[ Configure LSP ]]
; This function gets run when an LSP connects to a particular buffer.
(λ on_attach [_ bufnr] ; NOTE: Remember that lua is a real programming language, and as such it is possible
  ; to define small helper and utility functions so you don't have to repeat yourself
  ; many times. ; ; In this case, we create a function that lets us more easily define mappings specific
  ; for LSP related items. It sets the mode, buffer and description for us each time.
  (λ nmap [keys func desc]
    (let [desc (if desc (.. "LSP: " desc))]
      (vim.keymap.set :n keys func {:buffer bufnr : desc})))
  (nmap :<leader>rn vim.lsp.buf.rename "[R]e[n]ame")
  (nmap :<leader>ca vim.lsp.buf.code_action "[C]ode [A]ction")
  (let [builtin (require :telescope.builtin)]
    (nmap :gd builtin.lsp_definitions "[G]oto [D]efinition")
    (nmap :gr builtin.lsp_references "[G]oto [R]eferences")
    (nmap :gI builtin.lsp_implementations "[G]oto [I]mplementation")
    (nmap :<leader>D builtin.lsp_type_definitions "Type [D]efinition")
    (nmap :<leader>ds builtin.lsp_document_symbols "[D]ocument [S]ymbols")
    (nmap :<leader>ws builtin.lsp_dynamic_workspace_symbols
          "[W]orkspace [S]ymbols")) ; See `:help K` for why this keymap
  (nmap :K vim.lsp.buf.hover "Hover Documentation") ; nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')  ; Lesser used LSP functionality
  (nmap :gD vim.lsp.buf.declaration "[G]oto [D]eclaration")
  (nmap :<leader>wa vim.lsp.buf.add_workspace_folder "[W]orkspace [A]dd Folder")
  (nmap :<leader>wr vim.lsp.buf.remove_workspace_folder
        "[W]orkspace [R]emove Folder")
  (nmap :<leader>wl
        (λ []
          (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
        "[W]orkspace [L]ist Folders") ; Create a command `:Format` local to the LSP buffer
  (vim.api.nvim_buf_create_user_command bufnr :Format
                                        (λ [_]
                                          (vim.lsp.buf.format))
                                        {:desc "Format current buffer with LSP"}))

; mason-lspconfig requires that these setup functions are called in this order
; before setting up the servers.
((. (require :mason) :setup))
((. (require :mason-lspconfig) :setup))

; Enable the following language servers
; Feel free to add/remove any LSPs that you want here. They will automatically be installed.
;
; Add any additional override configuration in the following tables. They will be passed to
; the `settings` field of the server config. You must look up that documentation yourself.
;
; If you want to override the default filetypes that your language server will attach to you can
; define the property 'filetypes' to the map in question.
(local servers
       {:clangd {}
        :gopls {}
        ; :pyright  {}
        :rust_analyzer {}
        :tsserver {}
        ; html  { :filetypes  [ 'html' 'twig' 'hbs'] }
        :lua_ls {:Lua {:workspace {:checkThirdParty false}
                       :telemetry {:enable false}
                       ; NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                       :diagnostics {:disable [:missing-fields]}}}
        :fennel_language_server {:fennel {:diagnostics {; Gets rid of annoying errors
                                                        :globals [:vim]}}}})

; Setup neovim lua configuration
((. (require :neodev) :setup))

; nvim-cmp supports additional completion capabilities, so broadcast that to servers
(local capabilities
       (let [client_capabilities (vim.lsp.protocol.make_client_capabilities)]
         ((. (require :cmp_nvim_lsp) :default_capabilities) client_capabilities)))

; Ensure the servers above are installed
(local mason_lspconfig (require :mason-lspconfig))

(mason_lspconfig.setup {:ensure_installed (vim.tbl_keys servers)})

(λ handler [server_name]
  (let [setup (. (. (require :lspconfig) server_name) :setup)
        settings (. servers server_name)
        filetypes (. (if settings
                         settings
                         {}) :filetypes)]
    (setup {: capabilities : on_attach : settings : filetypes})))

(mason_lspconfig.setup_handlers [handler])
