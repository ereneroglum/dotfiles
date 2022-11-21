{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraConfig = ''
      lua << EOF
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
          after = { 'impatient.nvim', 'nvim-treesitter' },
          config = function()
            local npairs = require('nvim-autopairs')
            npairs.setup({
              check_ts = true
            })
          end
        })

        -- Boostrap package manager
        use({
          'wbthomason/packer.nvim'
        })

        -- Bufferline
        use({
          'akinsho/bufferline.nvim',
          after = { 'impatient.nvim', 'nvim-web-devicons' },
          config = function()
            require('bufferline').setup()
          end
        })

        -- Comments
        use ({
          'numToStr/Comment.nvim',
          after = { 'impatient.nvim' },
          config = function()
            require('Comment').setup()
          end
        })

        -- Completion
        use({
          'hrsh7th/nvim-cmp',
          requires = {
            { 'hrsh7th/cmp-buffer', after = { 'impatient.nvim', 'nvim-cmp' } } ,
            { 'hrsh7th/cmp-nvim-lsp', after = { 'impatient.nvim', 'nvim-cmp' } },
            { 'hrsh7th/cmp-path', after = { 'impatient.nvim', 'nvim-cmp' } },
            { 'ray-x/cmp-treesitter', after = { 'impatient.nvim', 'nvim-cmp' } },
            { 'saadparwaiz1/cmp_luasnip', after = { 'impatient.nvim', 'LuaSnip', 'nvim-cmp' } }
          },
          after = { 'impatient.nvim', 'nvim-autopairs' },
          config = function()
            vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
            local cmp = require('cmp')
            cmp.setup({
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

        -- File Tree
        use({
          'kyazdani42/nvim-tree.lua',
          after = { 'impatient.nvim', 'nvim-web-devicons', 'project.nvim' },
          config = function()
            require('nvim-tree').setup({
              respect_buf_cwd = true,
              sync_root_with_cwd = true,
              update_focused_file = {
                enable = true,
                update_root = true
              }
            })
          end
        })

        -- Git Signs
        use({
          'lewis6991/gitsigns.nvim',
          after = { 'impatient.nvim' },
          config = function()
            require('gitsigns').setup({
              current_line_blame = true,
              current_line_blame_opts = {
                delay = 500
              }
            })
          end
        })

        -- Impatient
        use({
          'lewis6991/impatient.nvim',
          config = function()
            require('impatient')
          end
        })

        -- Indentline
        use({
          'lukas-reineke/indent-blankline.nvim',
          after = { 'impatient.nvim' },
          config = function()
            require('indent_blankline').setup({
              show_current_context = true,
              show_current_context_start = true,
              space_char_blankline = ' '
            })
          end
        })

        -- LSP
        use({
          'neovim/nvim-lspconfig',
          after = { 'cmp-nvim-lsp', 'impatient.nvim' },
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
          after = { 'impatient.nvim', 'nvim-web-devicons', 'vscode.nvim' },
          config = function()
            require('lualine').setup()
          end
        })

        -- Luasnip
        use({
          'L3MON4D3/LuaSnip',
          after = { 'impatient.nvim' }
        })

        -- Plenary
        use({
          'nvim-lua/plenary.nvim',
          after = { 'impatient.nvim' }
        })

        -- Project
        use({
          'ahmedkhalf/project.nvim',
          after = { 'impatient.nvim' },
          config = function()
            require('project_nvim').setup()
          end
        })

        -- Telescope (Fuzzy Finder)
        use({
          'nvim-telescope/telescope.nvim',
          after = { 'impatient.nvim', 'nvim-treesitter', 'nvim-web-devicons', 'plenary.nvim', 'project.nvim' },
          config = function()
            local telescope = require('telescope')
            telescope.setup()
            telescope.load_extension('projects')
          end
        })

        -- Theme
        use({
          'Mofiqul/vscode.nvim',
          after = { 'impatient.nvim' },
          config = function()
            vim.cmd('colorscheme vscode')
          end
        })

        -- Treesitter
        use({
          'nvim-treesitter/nvim-treesitter',
          after = { 'impatient.nvim' },
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
          after = { 'impatient.nvim' },
          config = function()
            require('nvim-web-devicons').setup({
              default = true
            })
          end
        })

        -- WhichKey
        use({
          'folke/which-key.nvim',
          after = { 'impatient.nvim' },
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
      EOF
    '';
  };
}
