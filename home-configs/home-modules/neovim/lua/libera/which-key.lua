local M = {}

function M.config()
  require("which-key").setup()
end

M.plugin_spec = {
  "folke/which-key.nvim",
  config = M.config,
}

return M
