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

      vim.cmd [[ packadd packer.nvim ]]

      require('packer').startup(function(use)
        -- Autopairs
        use({
          'windwp/nvim-autopairs',
          after = { 'nvim-treesitter' },
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
          after = { 'nvim-web-devicons' },
          config = function()
            require('bufferline').setup()
          end
        })

        -- Completion
        use({
          'hrsh7th/nvim-cmp',
          requires = {
            { 'hrsh7th/cmp-buffer', after = { 'nvim-cmp' } } ,
            { 'hrsh7th/cmp-nvim-lsp', after = { 'nvim-cmp' } },
            { 'hrsh7th/cmp-path', after = { 'nvim-cmp' } },
            { 'ray-x/cmp-treesitter', after = { 'nvim-cmp' } },
            { 'saadparwaiz1/cmp_luasnip', after = { 'LuaSnip', 'nvim-cmp' } }
          },
          after = { 'nvim-autopairs' },
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
          after = { 'nvim-web-devicons', 'project.nvim' },
          config = function()
            require('nvim-tree').setup({
              respect_buf_cwd = true,
              update_cwd = true,
              update_focused_file = {
                enable = true,
                update_cwd = true
              }
            })
          end
        })

        -- LSP
        use({
          'neovim/nvim-lspconfig',
          after = { 'cmp-nvim-lsp' },
          config = function()
            local lspconfig = require('lspconfig')
            --- Provide capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

            --- Setup Language Servers
            lspconfig.clangd.setup({ capabilities = capabilities })
            lspconfig.gopls.setup({ capabilities = capabilities })
            lspconfig.pylsp.setup({ capabilities = capabilities })
            lspconfig.rnix.setup({ capabilities = capabilities })
            lspconfig.rust_analyzer.setup({ capabilities = capabilities })
          end
        })

        -- Lualine
        use({
          'nvim-lualine/lualine.nvim',
          after = { 'nvim-web-devicons', 'onedark.nvim' },
          config = function()
            require('lualine').setup()
          end
        })

        -- Luasnip
        use({
          'L3MON4D3/LuaSnip'
        })

        -- Null-ls
        use({
          'jose-elias-alvarez/null-ls.nvim',
          config = function()
            local null_ls = require('null-ls')
            local sources = {
              null_ls.builtins.diagnostics.cppcheck,
              null_ls.builtins.diagnostics.deadnix,
              null_ls.builtins.diagnostics.flake8,
              null_ls.builtins.formatting.autopep8,
              null_ls.builtins.formatting.clang_format,
              null_ls.builtins.formatting.gofmt,
              null_ls.builtins.formatting.nixfmt,
              null_ls.builtins.formatting.rustfmt
            }
            null_ls.setup({ sources = sources })
          end
        })

        -- Onedark Theme
        use({
          'navarasu/onedark.nvim',
          config = function()
            require('onedark').load()
          end
        })

        -- Plenary
        use({
          'nvim-lua/plenary.nvim'
        })

        -- Project
        use({
          'ahmedkhalf/project.nvim',
          config = function()
            require('project_nvim').setup()
          end
        })

        -- Telescope (Fuzzy Finder)
        use({
          'nvim-telescope/telescope.nvim',
          after = { 'nvim-treesitter', 'nvim-web-devicons', 'plenary.nvim', 'project.nvim' },
          config = function()
            local telescope = require('telescope')
            telescope.setup()
            telescope.load_extension('projects')
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

      -- Enable mouse support
      vim.opt.mouse = 'a'

      -- Set folding
      vim.opt.foldlevel = 7
      EOF
    '';
  };
}