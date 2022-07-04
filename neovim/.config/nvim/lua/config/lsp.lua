local M = {}

function M.setup()
  local lspconfig = require('lspconfig')
  -- Provide capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  -- Setup Language Servers
  lspconfig.clangd.setup({ capabilities = capabilities })
  lspconfig.gopls.setup({ capabilities = capabilities })
  lspconfig.pylsp.setup({ capabilities = capabilities })
  lspconfig.rnix.setup({ capabilities = capabilities })
  lspconfig.rust_analyzer.setup({ capabilities = capabilities })
end

return M
