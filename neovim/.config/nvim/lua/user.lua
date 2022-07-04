local M = {}

function M.setup()
  -- Show line numbers
  vim.opt.number = true

  -- Show some empty characters
  vim.opt.list = true

  -- Enable mouse support
  vim.opt.mouse = 'a'

  -- Set folding
  vim.opt.foldlevel = 7
end

return M
