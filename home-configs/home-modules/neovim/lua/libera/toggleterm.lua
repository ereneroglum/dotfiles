local M = {}

M.plugin_spec = {
  "akinsho/toggleterm.nvim",
  cmd = "ToggleTerm",
  config = function()
    require("toggleterm").setup()
  end
}

return M


