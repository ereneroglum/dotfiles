local M = {}

M.plugin_spec = {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    local is_treesitter_present, _ = pcall(require, "nvim-treesitter")
    require("indent_blankline").setup({
      show_current_context = is_treesitter_present,
      show_current_context_start = is_treesitter_present,
      space_char_blankline = " "
    })
  end,
  event = { "BufReadPost", "BufNewFile" }
}

return M
