local M = {}

function M.setup()
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
        require('config.autopairs').setup()
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
        require('config.bufferline').setup()
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
        require('config.cmp').setup()
      end
    })

    -- File Tree
    use({
      'kyazdani42/nvim-tree.lua',
      after = { 'nvim-web-devicons', 'project.nvim' },
      config = function()
        require('config.nvimtree').setup()
      end
    })

    -- LSP
    use({
      'neovim/nvim-lspconfig',
      after = { 'cmp-nvim-lsp' },
      config = function()
        require('config.lsp').setup()
      end
    })

    -- Lualine
    use({
      'nvim-lualine/lualine.nvim',
      after = { 'nvim-web-devicons', 'onedark.nvim' },
      config = function()
        require('config.lualine').setup()
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
        require('config.null-ls').setup()
      end
    })

    -- Onedark Theme
    use({
      'navarasu/onedark.nvim',
      config = function()
        require('config.onedark').setup()
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
        require('config.project').setup()
      end
    })

    -- Telescope (Fuzzy Finder)
    use({
      'nvim-telescope/telescope.nvim',
      after = { 'nvim-treesitter', 'nvim-web-devicons', 'plenary.nvim', 'project.nvim' },
      config = function()
        require('config.telescope').setup()
      end
    })

    -- Treesitter
    use({
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require('config.treesitter').setup()
      end
    })

    -- Webdev Icons
    use({
      'kyazdani42/nvim-web-devicons',
      config = function()
        require('config.webdevicons').setup()
      end
    })

    -- WhichKey
    use({
      'folke/which-key.nvim',
      config = function()
        require('config.whichkey').setup()
      end
    })

    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
      require('packer').sync()
    end
  end)
end

return M
