local lspconfig = require "lspconfig"

lspconfig["tsserver"].setup{}

lspconfig["volar"].setup(require "lsp.server.volar".args)
