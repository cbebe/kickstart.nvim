;; [[ Configure LSP ]]
;;  This function gets run when an LSP connects to a particular buffer.
(fn on-attach [_ bufnr]
  ;; NOTE: Remember that lua is a real programming language, and as such it is possible
  ;; to define small helper and utility functions so you don't have to repeat yourself
  ;; many times.
  ;;
  ;; In this case, we create a function that lets us more easily define mappings specific
  ;; for LSP related items. It sets the mode, buffer and description for us each time.

  (fn nmap [keys func ?desc]
    (let [desc (if ?desc (.. "LSP: " ?desc) nil)]
      (vim.keymap.set :n keys func {:buffer bufnr : desc})))

  (nmap :<leader>rn vim.lsp.buf.rename "[R]e[n]ame")
  (nmap :<leader>ca vim.lsp.buf.code_action "[C]ode [A]ction")
  (nmap :gd (. (require :telescope.builtin) :lsp_definitions)
        "[G]oto [D]efinition")
  (nmap :gr (. (require :telescope.builtin) :lsp_references)
        "[G]oto [R]eferences")
  (nmap :gI (. (require :telescope.builtin) :lsp_implementations)
        "[G]oto [I]mplementation")
  (nmap :<leader>D (. (require :telescope.builtin) :lsp_type_definitions)
        "Type [D]efinition")
  (nmap :<leader>ds (. (require :telescope.builtin) :lsp_document_symbols)
        "[D]ocument [S]ymbols")
  (nmap :<leader>ws (. (require :telescope.builtin)
                       :lsp_dynamic_workspace_symbols)
        "[W]orkspace [S]ymbols")
  ;; See `:help K` for why this keymap
  (nmap :K vim.lsp.buf.hover "Hover Documentation")
  ;; (nmap :<C-k> vim.lsp.buf.signature_help "Signature Documentation")
  ;; Lesser used LSP functionality
  (nmap :gD vim.lsp.buf.declaration "[G]oto [D]eclaration")
  (nmap :<leader>wa vim.lsp.buf.add_workspace_folder "[W]orkspace [A]dd Folder")
  (nmap :<leader>wr vim.lsp.buf.remove_workspace_folder
        "[W]orkspace [R]emove Folder")
  (nmap :<leader>wl
        (fn []
          (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
        "[W]orkspace [L]ist Folders")
  ;; Create a command `:Format` local to the LSP buffer
  (vim.api.nvim_buf_create_user_command bufnr :Format
                                        (fn [_] (vim.lsp.buf.format))
                                        {:desc "Format current buffer with LSP"}))

on-attach