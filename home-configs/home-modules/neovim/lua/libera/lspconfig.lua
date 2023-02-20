local M = {}

M.plugin_spec = {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    -- Check if nvim-cmp is present
    local capabilities
    local is_cmp_present, cmp = pcall(require, "cmp_nvim_lsp")
    if is_cmp_present then
      capabilities = cmp.default_capabilities()
    else
      capabilities = vim.lsp.protocol.make_client_capabilities()
    end

    -- Setup Language Servers
    local lspservers = { "clangd", "gopls", "pylsp", "rust_analyzer" }
    for _,i in ipairs(lspservers) do
      lspconfig[i].setup({ capabilities = capabilities })
    end
  end,
  event = { "BufReadPost", "BufNewFile" }
}

return M
