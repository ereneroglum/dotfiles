local M = {}

M.package_manager_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

function M.boostrap()
  if not vim.loop.fs_stat(M.package_manager_path) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      M.package_manager_path
    })
  end
  vim.opt.rtp:prepend(M.package_manager_path)
end

function M.load_plugins(specs)
  require("lazy").setup(specs)
end

function M.setup(specs)
	M.boostrap()
	M.load_plugins(specs)
end

return M
