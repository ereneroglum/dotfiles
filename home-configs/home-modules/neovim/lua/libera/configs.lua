local M = {}

function M.setup()
  -- Show line numbers
  vim.opt.number = true

  -- Show some empty characters
  vim.opt.list = true
  vim.opt.listchars:append("space:·")

  -- Enable mouse support
  vim.opt.mouse = "a"

  -- Set folding
  vim.opt.foldlevel = 7

  -- Set epxandtab
  vim.opt.expandtab = true
end

return M
