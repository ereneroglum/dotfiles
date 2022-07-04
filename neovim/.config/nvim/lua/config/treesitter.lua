local M = {}

function M.setup()
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'c', 'cpp', 'go', 'nix', 'python', 'rust' },
    sync_install = false,
    highlight = {
      enable = true
    }
  })

  -- Tree sitter folding
  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
end

return M
