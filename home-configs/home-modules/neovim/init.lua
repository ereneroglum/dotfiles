 local fn = vim.fn
 local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
 if fn.empty(fn.glob(install_path)) > 0 then
   packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
 end

 vim.cmd('packadd packer.nvim')

 require('packer').startup(function(use)
   -- Autopairs
   use({
     'windwp/nvim-autopairs',
     config = function()
       local npairs = require('nvim-autopairs')
       npairs.setup({
         check_ts = true
       })
     end
   })

   -- Boostrap package manager
   use({ 'wbthomason/packer.nvim' })

   -- Bufferline
   use({
     'akinsho/bufferline.nvim',
     config = function()
       require('bufferline').setup()
     end
   })

   -- Comments
   use ({
     'numToStr/Comment.nvim',
     config = function()
       require('Comment').setup()
     end
   })

   -- Completion
   use({
     'hrsh7th/nvim-cmp',
     requires = {
       { 'hrsh7th/cmp-buffer' },
       { 'hrsh7th/cmp-nvim-lsp' },
       { 'hrsh7th/cmp-path' },
       { 'ray-x/cmp-treesitter' },
       { 'saadparwaiz1/cmp_luasnip' },
       { 'onsails/lspkind.nvim' }
     },
     config = function()
       vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
       local cmp = require('cmp')
       cmp.setup({
         window = {
           completion = {
             winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
             col_offset = -3,
             side_padding = 0
           }
         },
         formatting = {
           fields = { 'kind', 'abbr', 'menu' },
           format = function(entry, vim_item)
             local kind = require('lspkind').cmp_format({ mode = 'symbol_text', maxwidth = 50 })(entry, vim_item)
             local strings = vim.split(kind.kind, '%s', { trimempty = true })
             kind.kind = ' ' .. strings[1] .. ' '
             kind.menu = '    (' .. strings[2] .. ')'
             return kind
           end
         },
         mapping = cmp.mapping.preset.insert({
           ['<CR>'] = cmp.mapping.confirm({ select = true })
         }),
         snippet = {
           expand = function(args)
             require('luasnip').lsp_expand(args.body)
           end
         },
         sources = {
           { name = 'buffer' },
           { name = 'luasnip' },
           { name = 'nvim_lsp' },
           { name = 'path' },
           { name = 'treesitter' }
         }
       })

       --- Autopairs integration
       local cmp_autopairs = require('nvim-autopairs.completion.cmp')
       cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
     end
   })

   -- Dressing
   use({
     'stevearc/dressing.nvim'
   })

   -- Git Signs
   use({
     'lewis6991/gitsigns.nvim',
     config = function()
       require('gitsigns').setup({
         current_line_blame = true,
         current_line_blame_opts = {
           delay = 500
         }
       })
     end
   })

   -- Indentline
   use({
     'lukas-reineke/indent-blankline.nvim',
     config = function()
       require('indent_blankline').setup({
         show_current_context = true,
         show_current_context_start = true,
         space_char_blankline = ' '
       })
     end
   })

   -- Legendary
   use({
     'mrjones2014/legendary.nvim'
   })

   -- LSP
   use({
     'neovim/nvim-lspconfig',
     config = function()
       local lspconfig = require('lspconfig')

       --- Provide capabilities
       local capabilities =  require('cmp_nvim_lsp').default_capabilities(capabilities)

       --- Setup Language Servers
       lspconfig.clangd.setup({ capabilities = capabilities })
       lspconfig.gopls.setup({ capabilities = capabilities })
       lspconfig.pylsp.setup({ capabilities = capabilities })
       lspconfig.rust_analyzer.setup({ capabilities = capabilities })
     end
   })

   -- Lualine
   use({
     'nvim-lualine/lualine.nvim',
     config = function()
       require('lualine').setup()
     end
   })

   -- Luasnip
   use({
     'L3MON4D3/LuaSnip'
   })

   -- Plenary
   use({
     'nvim-lua/plenary.nvim'
   })

   -- Telescope (Fuzzy Finder)
   use({
     'nvim-telescope/telescope.nvim',
     requires = {
       {
         'ahmedkhalf/project.nvim',
         config = function()
           require('project_nvim').setup()
           require('telescope').load_extension('projects')
         end
       },
       {
         'nvim-telescope/telescope-file-browser.nvim',
         config = function()
           require('telescope').load_extension('file_browser')
         end
       }
     },
     config = function()
       require('telescope').setup()
     end
   })

   -- Theme
   use({
     'Mofiqul/vscode.nvim',
     config = function()
       vim.cmd('colorscheme vscode')
     end
   })

   -- Toggleterm
   use({
     'akinsho/toggleterm.nvim',
     config = function()
       require('toggleterm').setup()
     end
   })

   -- Treesitter
   use({
     'nvim-treesitter/nvim-treesitter',
     config = function()
       require('nvim-treesitter.configs').setup({
         ensure_installed = { 'c', 'cpp', 'go', 'nix', 'python', 'rust' },
         sync_install = false,
         highlight = {
           enable = true
         }
       })

       --- Tree sitter folding
       vim.opt.foldmethod = 'expr'
       vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
     end
   })

   -- Webdev Icons
   use({
     'kyazdani42/nvim-web-devicons',
     config = function()
       require('nvim-web-devicons').setup({
         default = true
       })
     end
   })

   -- WhichKey
   use({
     'folke/which-key.nvim',
     config = function()
       require('which-key').setup()
     end
   })

   -- Automatically set up your configuration after cloning packer.nvim
   if packer_bootstrap then
     require('packer').sync()
   end
 end)

 -- Show line numbers
 vim.opt.number = true

 -- Show some empty characters
 vim.opt.list = true
 vim.opt.listchars:append('space:·')

 -- Enable mouse support
 vim.opt.mouse = 'a'

 -- Set folding
 vim.opt.foldlevel = 7
