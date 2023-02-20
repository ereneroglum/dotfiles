local M = {}

M.plugin_spec = {
  "windwp/nvim-autopairs",
  config = function()
    local npairs = require("nvim-autopairs")

    -- Check for treesitter
    local is_treesitter_present, _ = pcall(require, "nvim-treesitter")

    npairs.setup({
      check_ts = is_treesitter_present
    })
  end,
  event = "InsertEnter"
}

return M
