local M = {}

function M.config()
  vim.cmd("colorscheme vscode")
end

M.plugin_spec = {
  "Mofiqul/vscode.nvim",
  config = M.config
}

return M
