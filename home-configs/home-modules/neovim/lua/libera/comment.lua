local M = {}

M.plugin_spec = {
  "numToStr/Comment.nvim",
   config = function()
     require('Comment').setup()
   end,
   event = { "BufReadPost", "BufNewFile" }
}

return M
