local M = {}

M.plugin_spec = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      extensions = {
        file_browser,
        projects
      }
    })
    telescope.load_extension("projects")
    telescope.load_extension("file_browser")
  end,
  dependencies = {
    {
      "ahmedkhalf/project.nvim",
      config = function()
        require("project_nvim").setup()
      end
    },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-lua/plenary.nvim"
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope Live Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope Help Tags" },
    { "<leader>t", "<cmd>Telescope builtin include_extensions=true<cr>", "Telescope Menu" }
  }
}

return M
