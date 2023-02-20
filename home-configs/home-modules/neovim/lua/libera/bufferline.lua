local M = {}

M.plugin_spec = {
  "akinsho/bufferline.nvim",
  config = function()
    require("bufferline").setup()
  end,
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  event = "BufEnter"
}

return M
