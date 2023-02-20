local M = {}

M.plugin_spec = {
  "hrsh7th/nvim-cmp",
  config = function()
    vim.opt.completeopt = { "menu", "menuone", "noselect" }
    local cmp = require("cmp")
    cmp.setup({
      window = {
        completion = {
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          col_offset = -3,
          side_padding = 0
        }
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. strings[1] .. " "
          kind.menu = "    (" .. strings[2] .. ")"
          return kind
        end
      },
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true })
      }),
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end
      },
      sources = {
        { name = "buffer" },
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "treesitter" }
      }
    })

    -- Autopairs integration
    local is_autopairs_present, cmp_autopairs = pcall(require ,"nvim-autopairs.completion.cmp")
    if is_autopairs_present then
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  end,
  dependencies = {
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "onsails/lspkind.nvim",
    "ray-x/cmp-treesitter",
    "saadparwaiz1/cmp_luasnip"
  },
  event = "InsertEnter"
}

return M
