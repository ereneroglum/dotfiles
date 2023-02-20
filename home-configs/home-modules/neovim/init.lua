require("libera.configs").setup()

local specs = {
  require("libera.autopairs").plugin_spec,
  require("libera.dashboard").plugin_spec,
  require("libera.bufferline").plugin_spec,
  require("libera.comment").plugin_spec,
  require("libera.gitsigns").plugin_spec,
  require("libera.indentline").plugin_spec,
  require("libera.lspconfig").plugin_spec,
  require("libera.lualine").plugin_spec,
  require("libera.noice").plugin_spec,
  require("libera.nvim-cmp").plugin_spec,
  require("libera.telescope").plugin_spec,
  require("libera.toggleterm").plugin_spec,
  require("libera.treesitter").plugin_spec,
  require("libera.vscode").plugin_spec,
  require("libera.which-key").plugin_spec
}

-- Lazy needs leader key to be set before loading any plugin for keymaps to work.
vim.g.mapleader = " "

require("libera.lazy").setup(specs)
